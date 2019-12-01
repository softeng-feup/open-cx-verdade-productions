import 'dart:collection';
import 'package:conferly/models/event.dart';
import 'package:flutter/cupertino.dart';

class EventNotifier with ChangeNotifier {
  List<Event> _eventList = [];
  Event _currentEvent;

  UnmodifiableListView<Event> get eventList => UnmodifiableListView(_eventList);

  Event get currentEvent => _currentEvent;

  set eventList(List<Event> eventList) {
    _eventList = eventList;
    notifyListeners();
  }

  set currentEvent(Event event) {
    _currentEvent = event;
    notifyListeners();
  }
}