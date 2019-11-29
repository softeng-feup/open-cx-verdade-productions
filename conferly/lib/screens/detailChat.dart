import 'package:flutter/material.dart';

import 'package:conferly/main.dart';
import 'package:conferly/widgets/Bubble.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DetailChat extends StatefulWidget {
  DocumentSnapshot chat;

  DetailChat(this.chat);

  @override
  DetailChatState createState() {
    return new DetailChatState(chat);
  }
}

class DetailChatState extends State<DetailChat> {
  DocumentSnapshot chat;

  DetailChatState(this.chat);

  final ScrollController listScrollController = new ScrollController();

  final TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(chat['name']),
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
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Chats')
            .document(chat.documentID)
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
                  snapshot.data.documents[index]['text'], snapshot.data.documents[index]['sender'] != MyApp.firebaseUser.uid, snapshot.data.documents[index]['time'])),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: Theme.of(context).accentColor
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
      onPressed: () => _textMessageSubmitted(_textEditingController.text)
    );
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    _sendMessage(text);
  }


  void _sendMessage(String messageText) {

    if (messageText.trim() != '') {
      var documentReference = Firestore.instance
          .collection('Chats')
          .document(chat.documentID)
          .collection('messages')
          .document(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'sender': MyApp.firebaseUser.uid,
            'time': Timestamp.now(),
            'text': messageText
          },
        );
        print("Done writing message");
      });
      listScrollController.animateTo(
          0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }
}
