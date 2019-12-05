import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/screens/createChat.dart';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _profileImage(),
              Column(
                children: <Widget>[
                  Text(
                    chat['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Ola tudo bem"),
                ],
              ),
              Text(dateString)
            ],
          ),
        ));
  }

  Widget _profileImage() {
    return Center(
        child: Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: Colors.green,
            width: 1.0,
          )),
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
