import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/screens/createChat.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:conferly/main.dart';
import 'detailChat.dart';

import 'events/detailEvent.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
        body: Column(
              children: <Widget>[
//                Container(
//                  child: Text(
//                    "Messages",
//                    style: TextStyle(fontSize: 24),
//                  ),
//                  margin: EdgeInsets.all(15),
//                ),
                buildListChats()
              ],
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateChat()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.white,
        ),
    );
  }

  Widget getProfileChat(BuildContext context, DocumentSnapshot chat) {
//    MessageProfile profile = MyApp.chatProfiles[indexProfile];
    String dateString = chat['lastMessage'].toDate().hour.toString().padLeft(2,'0') + ":" + chat['lastMessage'].toDate().minute.toString().padLeft(2,'0');

    String chatName = chat['name'];
    if (chat['chatName'] != null && chat['chatName'][MyApp.firebaseUser.uid] != null && chat['chatName'][MyApp.firebaseUser.uid] != "")
      chatName = chat['chatName'][MyApp.firebaseUser.uid];

    String chatImage = "";
    if (chat['chatImage'] != null && chat['chatImage'][MyApp.firebaseUser.uid] != null && chat['chatImage'][MyApp.firebaseUser.uid] != "")
      chatImage = chat['chatImage'][MyApp.firebaseUser.uid];

    String lastText = "No text message";
    if (chat['lastText'] != null && chat['lastText'] != "")
        lastText = chat['lastText'];

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailChat(chat)),
          );
//                    print("Container pressed");
        },
        child: Container(
          padding: EdgeInsets.all(4),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _profileImage(chatImage),
              Container(width: 16,),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      chatName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(height: 4,),
                    Text(lastText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
              Text(dateString)
            ],
          ),
        ));
  }

  Widget buildListChats() {
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Chats')
            .where("participants", arrayContains: MyApp.firebaseUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor)));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => getProfileChat(context, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
//              controller: listScrollController,
            );
          }
        },
      ),
    );
  }
}

class _profileImage extends StatefulWidget {
String _profileUid;

_profileImage(String uid) {
  this._profileUid = uid;
}

@override
_profileImageState createState() => _profileImageState();
}

class _profileImageState extends State<_profileImage> {
  String imageFile;

  getImagePath() async {
    StorageReference photo =
    FirebaseStorage(storageBucket: 'gs://conferly-8779b.appspot.com/')
        .ref()
        .child('images/${widget._profileUid}.png');
    photo.getDownloadURL().then((data) {
      setState(() {
        imageFile = data;
      });
    }).catchError((error) {});
  }

  @override
  void initState() {
    super.initState();
    getImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: (imageFile != null)
                    ? new NetworkImage(imageFile)
                    : (AssetImage('assets/images/profile.png')),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color: Colors.green,
                width: 1.0,
              )),
        ));
  }
}
