import 'package:flutter/material.dart';

import 'package:conferly/main.dart';
import 'package:conferly/widgets/Bubble.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DetailChat extends StatefulWidget {
  final indexProfile;

  DetailChat(this.indexProfile);

  @override
  DetailChatState createState() {
    return new DetailChatState(indexProfile);
  }
}

class DetailChatState extends State<DetailChat> {
  int indexProfile;

//  Firestore.instance.collection('Messages').snapshots();

  DetailChatState(this.indexProfile);

  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(MyApp.chatProfiles[indexProfile].name),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                buildListMessage(),

                // Input content
                _buildTextComposer(),
              ],
            ),

            // Loading
          ],
        )

//        new Column(
//          children: <Widget>[
//            new StreamBuilder<QuerySnapshot>(
//                stream: Firestore.instance.collection('Messages').snapshots(),
//                builder: (BuildContext context,
//                    AsyncSnapshot<QuerySnapshot> snapshot) {
//                  if (snapshot.hasError)
//                    return new Text('Error: ${snapshot.error}');
//                  switch (snapshot.connectionState) {
//                    case ConnectionState.waiting:
//                      return new Text('Loading...');
//                    default:
//                      return new ListView(
//                        children: snapshot.data.documents
//                            .map((DocumentSnapshot document) {
//                          return new Bubble(message: Message(
//                              document['message'], document['sender'], document['date']));
//                        }).toList(),
//                      );
//                  }
//
//                }
//            ),
////            new Expanded(
////                child: ListView.builder(
////                    padding: const EdgeInsets.all(8),
////                    itemCount: MyApp.chatProfiles[indexProfile].messages.length,
////                    itemBuilder: (BuildContext context, int index) {
////                      return Bubble(message: MyApp.chatProfiles[indexProfile].messages[index]);})
////            ),
//            new Divider(height: 1.0),
//
//            new Container(
//              decoration:
//              new BoxDecoration(color: Theme.of(context).cardColor),
//              child: _buildTextComposer(),
//            ),
//
//          ],
//        )

        );
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Messages')
            .document('7YVPXITbqJqzozTmXdpM')
            .collection('messages')
            .orderBy('time', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor)));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => Bubble(message: Message(
                  snapshot.data.documents[index]['message'], snapshot.data.documents[index]['sender'], snapshot.data.documents[index]['time'])),
              itemCount: snapshot.data.documents.length,
              reverse: true,
//              controller: listScrollController,
            );
          }
        },
      ),
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
//                      color: Theme.of(context).accentColor,
                      color: Theme.of(context)
                          .disabledColor, // TODO add photos to chat later
                    ),
                    onPressed: () => {}),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });

    _sendMessage(text);
  }


  void _sendMessage(String messageText) {

      var documentReference = Firestore.instance
          .collection('Messages')
          .document('7YVPXITbqJqzozTmXdpM')
          .collection('messages')
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'sender' : true,
            'time': Timestamp.now(),
            'message': messageText
          },
        );
        print("Done writing message");
      });
//      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
