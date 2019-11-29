import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/utils/chat.dart';
import 'package:flutter/material.dart';

import 'package:conferly/main.dart';

class CreateChat extends StatefulWidget {

  @override
  CreateChatState createState() => CreateChatState();

}


class CreateChatState extends State<CreateChat> {

  TextEditingController textEditingController = new TextEditingController();
  String textQuery = "";

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    textEditingController.addListener((){
      setState(() {
        textQuery = textEditingController.text.toLowerCase();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Chat'),

      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: textEditingController
          ),
          Text("Text $textQuery"),
          buildListUsers()
        ],
      ),
    );
  }

  Widget buildListUsers() {
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Users')
            .where('name_search', isLessThanOrEqualTo: textQuery + 'z' )
            .where('name_search', isGreaterThanOrEqualTo: textQuery)
            .limit(5)
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

  Widget getProfileChat(BuildContext context, DocumentSnapshot profile) {
//    MessageProfile profile = MyApp.chatProfiles[indexProfile];

    return GestureDetector(
        onTap: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => DetailChat(chat)),
//          );
//                    print("Container pressed");
          createChatWithTwoUsers(MyApp.firebaseUser.uid, profile['uid']);
        },
        child: Container(
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _profileImage(),
              Column(
                children: <Widget>[
                  Text(
                    profile['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(profile['email']),
                  Text(profile['uid'])
                ],
              ),
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
                color: Colors.grey,
                width: 1.0,
              )),
        ));
  }


}