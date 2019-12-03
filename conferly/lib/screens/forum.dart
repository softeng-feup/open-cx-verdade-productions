import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/main.dart';
import 'package:conferly/widgets/BubbleForum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/Bubble.dart';

class Forum extends StatefulWidget {
  final String eventId;

  Forum(this.eventId);

  @override
  ForumState createState() {
    return new ForumState();
  }
}

class ForumState extends State<Forum> {
  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Forum"),
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
        ));
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Forums')
            .document(widget.eventId)
            .collection('messages')
            .orderBy('time', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor)));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
                height: 1,
              ),
//              padding: EdgeInsets.all(16.0),
              itemBuilder: (context, index) => BubbleForum(snapshot.data.documents[index]),
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
        data: new IconThemeData(color: Theme.of(context).accentColor),
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
        onPressed: () => _textMessageSubmitted(_textEditingController.text));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    _sendMessage(text);
  }

  void _sendMessage(String messageText) {
    if (messageText.trim() != '') {
      var documentReference = Firestore.instance
          .collection('Forums')
          .document(widget.eventId)
          .collection('messages')
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'uid_sender': MyApp.firebaseUser.uid,
            'name_sender': "PUT NAME HERE",
            'time': Timestamp.now(),
            'text': messageText,
            'dislikes': [],
            'likes': []
          },
        );
        print("Done writing message");
      });
    }
  }
}
