import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String title;
  String description;
  String location;
  String speaker;
  String speaker_uid;
  Timestamp startDate;
  Timestamp endDate;
  Event({
    this.title,
    this.description,
    this.location,
    this.speaker,
    this.speaker_uid,
    this.startDate,
    this.endDate
  });
}
