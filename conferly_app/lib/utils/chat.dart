import 'package:cloud_firestore/cloud_firestore.dart';

createChatWithTwoUsers(String uid1, String uid2){

  String chatName = uid1.compareTo(uid2) < 0 ? uid1 + uid2 : uid2 + uid1;

  var documentReference = Firestore.instance
      .collection('Chats')
      .document(chatName);

  Firestore.instance.runTransaction((transaction) async {
    await transaction.set(
      documentReference,
      {
        'lastMessage': Timestamp.now(),
        'name': "Test",
        'participants': [uid1, uid2]
      },
    );
    print("Done creating chat");
  });
}