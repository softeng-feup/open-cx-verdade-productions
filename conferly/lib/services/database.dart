import 'package:conferly/main.dart';
import 'package:conferly/models/event.dart';
import 'package:conferly/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference usersCollenction = Firestore.instance.collection('Users');
  final CollectionReference eventsCollenction = Firestore.instance.collection('Events');

  Future<void> introduceUserData(String email, String name) async {
    return await usersCollenction.document(uid).setData({
      'email' : email,
      'name' : name,
      'description' : '',
      'status' : '',
      'interests' : [],
    });
  }
}