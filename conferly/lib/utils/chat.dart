import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createChatWithTwoUsers(String uid1, String uid2, String name1, String name2){

  String chatName = uid1.compareTo(uid2) < 0 ? uid1 + uid2 : uid2 + uid1;

  var documentReference = Firestore.instance
      .collection('Chats')
      .document(chatName);

  return Firestore.instance.runTransaction((transaction) async {
    await transaction.set(
      documentReference,
      {
        'lastMessage': Timestamp.now(),
        'name': "Test",
        'participants': [uid1, uid2],
        'chatName': {
          uid1: name2,
          uid2: name1
        },
        'chatImage': {
          uid1: uid2,
          uid2: uid1
        }
      },
    );
    print("Done creating chat");
  }).then( (value) {
    return chatName;
  });
}