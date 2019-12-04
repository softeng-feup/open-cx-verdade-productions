import 'dart:collection';
import 'package:conferly/models/event.dart';
import 'package:flutter/cupertino.dart';

class EventNotifier with ChangeNotifier {
  List<Event> _eventList = [];
  Event _currentEvent;

  List<Event> get eventList => _eventList;

  Event get currentEvent => _currentEvent;

  setEvents(List<Event> eventList) {
    _eventList = eventList;
    notifyListeners();
  }

  set currentEvent(Event event) {
    _currentEvent = event;
    notifyListeners();
  }
}