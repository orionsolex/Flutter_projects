import 'package:flutter/material.dart';

void main() => runApp(myStatelessWidget());

class myStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Static ListView"),
            centerTitle: true,
          ),
          body: BodyListView()),
    );
  }
}

class BodyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView();
  }
}

Widget _myListView() {
  final List<ListItem> items = List<ListItem>.generate(
      10000,
      (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', 'Message body $i'));

  return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is HeadingItem) {
          return ListTile(
              title: Text(item.heading,
                  style: Theme.of(context).textTheme.headline6));
        } else if (item is MessageItem) {
          return ListTile(
            title:
                Text(item.sender, style: Theme.of(context).textTheme.headline6),
            subtitle:
                Text(item.body, style: Theme.of(context).textTheme.headline6),
            leading: Icon(
              Icons.insert_photo,
              color: Colors.red,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
          );
        }
        return Divider();
      });
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
