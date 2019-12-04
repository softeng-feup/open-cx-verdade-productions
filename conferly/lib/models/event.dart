import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id;
  String title;
  String description;
  String location;
  String speaker;
  String speaker_uid;
  List<String> participants;
  Timestamp startDate;
  Timestamp endDate;
  Event({
    this.id,
    this.title,
    this.description,
    this.location,
    this.speaker,
    this.speaker_uid,
    this.participants,
    this.startDate,
    this.endDate
  });
}
