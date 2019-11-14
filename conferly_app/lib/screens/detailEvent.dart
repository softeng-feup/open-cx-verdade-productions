import 'package:flutter/material.dart';

import 'package:conferly/main.dart';

class DetailEvent extends StatefulWidget {

  final event;

  DetailEvent(this.event);

  @override
  DetailEventState createState() {
    return new DetailEventState(event);
  }
}

class DetailEventState extends State<DetailEvent> {

  Event event;

  DetailEventState(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(event.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Text('16 Sep, 16h30-18h30', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            )
            ,
            Container(
            margin: EdgeInsets.symmetric(horizontal: 60, vertical: 4),
            child: Text('Porto, Portugal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 4),
              child: Text(event.description, style: TextStyle(fontSize: 14)),
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

