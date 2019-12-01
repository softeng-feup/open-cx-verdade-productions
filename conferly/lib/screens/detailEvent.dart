import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/screens/profile.dart';
import 'package:conferly/widgets/InfoWrapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:conferly/main.dart';

class DetailEvent extends StatefulWidget {

  DocumentSnapshot event;

  DetailEvent(this.event);

  @override
  DetailEventState createState() {
    return new DetailEventState(event);
  }
}

class DetailEventState extends State<DetailEvent> {

  DocumentSnapshot event;

  DetailEventState(this.event);

  @override
  Widget build(BuildContext context) {
    var participants = new List<String>.from(this.event['participants']);
    final bool alreadySaved = participants.contains(MyApp.firebaseUser.uid);
    Timestamp ts = event['startDate'];
    Timestamp te = event['endDate'];

    final fDate = new DateFormat('EEE, d MMMM');
    final fTime = new DateFormat('HH:mm');

    String s_date = fDate.format(ts.toDate());
    String s_time = fTime.format(ts.toDate()) + " - " + fTime.format(te.toDate());
    String location = (event['location']);

    return Scaffold(
        appBar: AppBar(
          title: Text(event['name']),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),

//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _profileImage(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(event['speaker'], style: TextStyle(fontSize: 25),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile(user: event['speaker_uid'],)),
                          );
                        },
                        child: Chip(
                          label: Text("Go to profile >"),
                        ),
                      )
                    ],
                  )


                ],
              ),
            )
            ,
//            Container(
//            margin: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
//            child: Text('16 Sep, 16h30-18h30', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//            ),

            InfoWrapper(
                text: s_date,
                icon: Icon(Icons.calendar_today), bg: Theme
                .of(context)
                .scaffoldBackgroundColor)
            ,
            InfoWrapper(
            text: s_time,
            icon: Icon(Icons.access_time), bg: Theme
                .of(context)
                .scaffoldBackgroundColor)
            ,
            InfoWrapper(
                text: location,
                icon: Icon(Icons.place), bg: Theme
                .of(context)
                .scaffoldBackgroundColor)
            ,
//            Container(
//            margin: EdgeInsets.symmetric(horizontal: 60, vertical: 4),
//            child: Text(event['location'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(event['description'], style: TextStyle(fontSize: 16)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: RaisedButton(
                onPressed: () {

                },
                child: const Text(
                'Go to forum',
                style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            Container(
//              margin: EdgeInsets.fromLTRB(60, 4, 60, 16),
              child: RaisedButton(
                onPressed: () {
                  var newParticipants = new List<String>.from(event['participants']);
                  if (alreadySaved) {
                    newParticipants.remove(MyApp.firebaseUser.uid);
                  }
                  else {
                    newParticipants.add(MyApp.firebaseUser.uid);
                  }
                  event.reference.updateData({
                    'participants' : newParticipants,
                  });
                  Navigator.of(context).pop();
                },
                child: alreadySaved ? const Text(
                    'Remove from Agenda',
                    style: TextStyle(fontSize: 20)
                ) : const Text(
                    'Add to Agenda',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),

          ],
        )


    );
  }

  Widget _profileImage() {
    return Center(
        child: Container (
          width: 120.0, height:120.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color:Colors.grey,
                width:5.0,
              )
          ),
        )
    );
  }

}

