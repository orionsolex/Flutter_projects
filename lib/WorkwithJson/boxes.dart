import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'boxes.g.dart'; //позволяет получить доступ к закрытым членам файла


// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);




BoxesList boxListFromJson(String str) => BoxesList.fromJson(json.decode(str));

String boxListToJson(BoxesList data) => json.encode(data.toJson());

@JsonSerializable()
class BoxesList {
  BoxesList({
    required this.offices,
  });

  List<Office> offices;

  factory BoxesList.fromJson(Map<String, dynamic> json) => BoxesList(
    offices: List<Office>.from(json["offices"].map((x) => Office.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offices": List<dynamic>.from(offices.map((x) => x.toJson())),
  };
}

@JsonSerializable()
class Office {
  Office({
    required this.address,
    required this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
  });

  String address;
  String id;
  String image;
  double lat;
  double lng;
  String name;
  String phone;

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    address: json["address"],
    id: json["id"],
    image: json["image"],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "id": id,
    "image": image,
    "lat": lat,
    "lng": lng,
    "name": name,
    "phone": phone,
  };
}

Future<BoxesList> getBoxesList() async {
//const url='https://about.google/static/data/locations.json';
  var url = Uri.https('about.google', '/static/data/locations.json');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return BoxesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error ${response.reasonPhrase}');
  }
}








