import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:conferly/main.dart';
import 'detailEvent.dart';

class CalendarState extends State<Calendar>{
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(
        child: _showEvents(),
      ),
    );
  }

  Widget _showEvents() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Events')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.separated(
              itemBuilder: (context, index) => _buildRow(snapshot.data.documents[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data.documents.length);
        }
      );
  }


  Widget _buildRow(DocumentSnapshot event) {
    var participants = new List<String>.from(event['participants']);
    final bool alreadySaved = participants.contains(MyApp.firebaseUser.uid);
    return ListTile(
      title: Text(
        event['name'],
        style: _biggerFont,
      ),
      trailing: IconButton(
        icon: alreadySaved ? Icon(Icons.add_circle) : Icon(Icons.add_circle_outline),
        color: alreadySaved ?  Theme.of(context).accentColor : null,
        onPressed: () {
          setState(() {
            var newParticipants = new List<String>.from(event['participants']);
              newParticipants.remove(MyApp.firebaseUser.uid);
            if (alreadySaved) {
            } else {
              newParticipants.add(MyApp.firebaseUser.uid);
            }
            event.reference.updateData({
              'participants' : newParticipants,
            });
          });},
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailEvent(event)),
        );
      },
    );
  }

  Widget _buildAboutDialog(BuildContext context, DocumentSnapshot event) {
    var participants = new List<String>.from(event['participants']);
    final bool alreadySaved = participants.contains(MyApp.firebaseUser.uid);
    var bottom = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(event['speaker'], textAlign: TextAlign.end,),
        IconButton(
          icon: alreadySaved ? Icon(Icons.add_circle) : Icon(Icons.add_circle_outline),
          color: alreadySaved ? Theme.of(context).accentColor : null,
          onPressed: () {
            setState(() {
              var newParticipants = new List<String>.from(event['participants']);
              if (alreadySaved) {
                newParticipants.remove(MyApp.firebaseUser.uid);
              } else {
                newParticipants.add(MyApp.firebaseUser.uid);
              }
              event.reference.updateData({
                'participants' : newParticipants,
              });
            });
            Navigator.of(context).pop();},
        )
      ],
    );

    return new AlertDialog(
      title: Text(event['name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(event['description']),
          SizedBox(height: 30),
          bottom,
        ],
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}