import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/models/event.dart';
import 'package:conferly/notifier/auth_notifier.dart';
import 'package:conferly/notifier/event_notifier.dart';
import 'package:conferly/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailEvent extends StatefulWidget {
  Event event;
  bool add;
  DetailEvent(this.event, this.add);

  @override
  DetailEventState createState() => DetailEventState(event, add);
}

class DetailEventState extends State<DetailEvent> {
  Event event;
  bool add;

  DetailEventState(this.event, this.add);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(event.title),
        ),
        body: ListView(

//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _profileImage(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(event.speaker, style: TextStyle(fontSize: 25),),
                      FlatButton(
                        onPressed: () {

                        },
                        child: Text(
                          "Go to profile >",
                        ),
                      )
                    ],
                  )


                ],
              ),
            )
            ,
            Container(
            margin: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
            child: Text(
                  '${new DateFormat("dd MMMM").format(event.startDate.toDate())}, '
                  '${event.startDate.toDate().hour.toString().padLeft(2, '0')}'
                  ':'
                  '${event.startDate.toDate().minute.toString().padLeft(2, '0')}h'
                  '-'
                  '${event.endDate.toDate().hour.toString().padLeft(2, '0')}'
                  ':'
                  '${event.endDate.toDate().minute.toString().padLeft(2, '0')}h',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
            ,
            Container(
            margin: EdgeInsets.symmetric(horizontal: 60, vertical: 4),
            child: Text(event.location, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 4),
              child: Text(event.description, style: TextStyle(fontSize: 14)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(60, 30, 60, 4),
              child: RaisedButton(
                onPressed: () {},
                child: const Text(
                'Go to forum',
                style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(60, 4, 60, 16),
              child: RaisedButton(
                onPressed: _changeEvents,
                child: _buildChild()
              ),
            ),

          ],
        )


    );
  }

  Widget _buildChild() {
    if (add) {
      return Text('Add to agenda',
          style: TextStyle(fontSize: 20)
      );
    }

    return Text('Remove from agenda',
        style: TextStyle(fontSize: 20)
    );
  }

  _changeEvents() async {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    event.participants.remove(authNotifier.user.uid);

    if(add) {
      event.participants.add(authNotifier.user.uid);
    } else {
      event.participants.remove(authNotifier.user.uid);
    }

    await DatabaseService().setEventToUser(event);
    setState(() {
      add = !add;
    });
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

