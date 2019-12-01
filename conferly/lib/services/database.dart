import 'package:conferly/models/event.dart';
import 'package:conferly/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/notifier/auth_notifier.dart';
import 'package:conferly/notifier/event_notifier.dart';

class DatabaseService {
  introduceUserData(String uid, String email, String name, AuthNotifier authNotifier) async {
    CollectionReference usersCollenction = Firestore.instance.collection('Users');
    await usersCollenction.document(uid).setData({
      'email' : email,
      'name' : name,
      'description' : '',
      'status' : 0,
      'interests' : [],
    });

    getUser(uid, authNotifier);
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: snapshot.data['uid'],
      name: snapshot.data['name'],
      description: snapshot.data['description'],
      status: snapshot.data['status'],
    );
  }

  Event _eventDataFromSnapshot(DocumentSnapshot snapshot) {
    return Event(
      title: snapshot.data['name'],
      description: snapshot.data['description'],
      location: snapshot.data['location'],
      speaker: snapshot.data['speaker'],
      speaker_uid: snapshot.data['speaker_uid'],
      startDate: snapshot.data['startDate'],
      endDate: snapshot.data['endDate'],
    );
  }

  getUser(String uid, AuthNotifier authNotifier) async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('Users').document(uid).get();
    User user = _userDataFromSnapshot(snapshot);
    authNotifier.setUser(user);
  }

  getEvents(EventNotifier eventNotifier) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('Events').getDocuments();

    List<Event> _eventList = [];

    snapshot.documents.forEach((document) {
      Event event = _eventDataFromSnapshot(document);
      _eventList.add(event);
    });

    eventNotifier.eventList = _eventList;
  }
}