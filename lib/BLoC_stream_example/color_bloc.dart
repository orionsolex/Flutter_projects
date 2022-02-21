import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent{event_red,event_green}

class ColorBloc{
Color _color=Colors.red;

final _inputEventController=StreamController<ColorEvent>(); //создаем входящий поток
StreamSink<ColorEvent> get inputEventSink=>_inputEventController.sink;

final _outputStateController=StreamController<Color>(); //создаем исходящий поток
Stream<Color> get outputStateStream=>_outputStateController.stream;

void _mapEventToState(ColorEvent event){ // описываем бизнесс логику
  if(event== ColorEvent.event_red) _color=Colors.red;
  else if(event==ColorEvent.event_green) _color=Colors.green;
  else throw Exception('Wrong Event Type');

  _outputStateController.sink.add(_color); // передаем данные между потоками
}

ColorBloc(){_inputEventController.stream.listen(_mapEventToState);} // описываем конструктор

  void dispose(){
  _inputEventController.close();
  _outputStateController.close();
  }
}