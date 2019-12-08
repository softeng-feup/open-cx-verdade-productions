import 'package:conferly/models/event.dart';
import 'package:conferly/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  introduceUserData(String uid, String email, String name) async {
    CollectionReference usersCollenction = Firestore.instance.collection('Users');
    await usersCollenction.document(uid).setData({
      'email' : email,
      'name' : name,
      'uid' : uid,
      'name_search' : name.toLowerCase(),
      'description' : '',
      'status' : 'Attendee',
      'interests' : [],
    });
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: snapshot.documentID,
      name: snapshot.data['name'],
      description: snapshot.data['description'],
      status: snapshot.data['status'],
    );
  }

  Event eventDataFromSnapshot(DocumentSnapshot snapshot) {
    return Event(
      id: snapshot.documentID,
      title: snapshot.data['name'],
      description: snapshot.data['description'],
      location: snapshot.data['location'],
      speaker: snapshot.data['speaker'],
      speaker_uid: snapshot.data['speaker_uid'],
      participants: new List<String>.from(snapshot.data['participants']),
      startDate: snapshot.data['startDate'],
      endDate: snapshot.data['endDate'],
    );
  }

  Future<User> getUser(String uid) async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('Users').document(uid).get();
    return _userDataFromSnapshot(snapshot);
  }

  Future<bool> userExists(String uid) async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('Users').document(uid).get();
    return snapshot.exists;
  }

  Future<List<Event>> getEvents() async {
    QuerySnapshot snapshot = await Firestore.instance.collection('Events').getDocuments();
    List<Event> _eventList = [];
    DateTime now = DateTime.now();

    snapshot.documents.forEach((document) {
      Event event = eventDataFromSnapshot(document);
      if(now.isBefore(event.startDate.toDate()))
        _eventList.add(event);
    });

    return _eventList;
  }

  Future<List<Event>> getEventsFromUser(String uid) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('Events').where("participants", arrayContains: uid).getDocuments();
    List<Event> _eventList = [];
    DateTime now = DateTime.now();

    snapshot.documents.forEach((document) {
      Event event = eventDataFromSnapshot(document);
      if(event.participants.contains(uid) && now.isBefore(event.startDate.toDate()))
        _eventList.add(event);
    });

    return _eventList;
  }

  setEventToUser(Event event) async {
    CollectionReference eventsCollenction = Firestore.instance.collection('Events');
    await eventsCollenction.document(event.id).updateData({
      'participants' : event.participants,
    });
  }
}