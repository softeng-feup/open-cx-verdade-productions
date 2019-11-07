import 'package:flutter/material.dart';

import 'package:conferly/main.dart';
import 'package:conferly/widgets/Bubble.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        body: new Column(
          children: <Widget>[
            new Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: MyApp.chatProfiles[indexProfile].messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Bubble(message: MyApp.chatProfiles[indexProfile].messages[index]);})
            ),
            new Divider(height: 1.0),

            new Container(
              decoration:
              new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),

          ],
        )


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
                      color: Theme.of(context).disabledColor, // TODO add photos to chat later
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
    MyApp.messages.add(new Message(messageText, false, DateTime.now().millisecondsSinceEpoch));
  }
}

