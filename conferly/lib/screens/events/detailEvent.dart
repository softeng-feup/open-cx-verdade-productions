import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/models/event.dart';
import 'package:conferly/notifier/auth_notifier.dart';
import 'package:conferly/notifier/event_notifier.dart';
import 'package:conferly/services/database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(event.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 21.0,
              color: Colors.white
          ),
        ),
      ),
      body: Center(

//          crossAxisAlignment: CrossAxisAlignment.stretch,
          child: Column(
            children: <Widget>[
              new SizedBox(height: _height / 20,),
              _profileImage(),
              new SizedBox(height: _height / 30,),
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: _width / 1.2,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 25.0, right: 25.0, bottom: 5.0),
                        child: Text(
                          event.speaker,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 18.0,
                              color: Colors.black
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, left: 25.0, right: 25.0, bottom: 10.0),
                        child: Text(
                          event.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 14.0,
                              color: Colors.black54
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 2, height: _height / 20, color: Colors.green,),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0, left: 25.0, right: 25.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                        flex: 1,
                        child: _eventValue(
                            value: event.location,
                            icon: FontAwesomeIcons.mapMarker)
                    ),
                    new Expanded(
                        flex: 1,
                        child: _eventValue(
                            value: '${new DateFormat("dd MMMM").format(event
                                .startDate.toDate())}',
                            icon: FontAwesomeIcons.calendarDay)
                    ),
                    new Expanded(
                        flex: 1,
                        child: _eventValue(
                            value: ''
                                '${event.startDate
                                .toDate()
                                .hour
                                .toString()
                                .padLeft(2, '0')}'
                                ':'
                                '${event.startDate
                                .toDate()
                                .minute
                                .toString()
                                .padLeft(2, '0')}h'
                                '-'
                                '${event.endDate
                                .toDate()
                                .hour
                                .toString()
                                .padLeft(2, '0')}'
                                ':'
                                '${event.endDate
                                .toDate()
                                .minute
                                .toString()
                                .padLeft(2, '0')}h',
                            icon: FontAwesomeIcons.solidClock)
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2, height: _height / 20, color: Colors.green),
              new SizedBox(height: _height / 30,),
              Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.green
                ),
                child: MaterialButton(
                    minWidth: _width / 1.3,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.white,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Text(
                      "GO TO FORUM",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: "WorkSansBold"),
                    ),
                    onPressed: () {}
                ),
              ),
              new SizedBox(height: _height / 30,),
              Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.green
                ),
                child: MaterialButton(
                    minWidth: _width / 1.3,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.white,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: _buildChild(),
                    onPressed: _changeEvents
                ),
              ),
            ],
          )
      ),

    );
  }

  Widget _eventValue({String value, IconData icon}) {
    return new Container(
      child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(
              icon,
              size: 15.0,
              color: Colors.black54,
            ),
            new Container(width: 1.5),
            new Text(
              value,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 12.0,
                  color: Colors.black54
              ),
            ),
          ]
      ),
    );
  }

  Widget _buildChild() {
    if (add) {
      return Text('ADD TO AGENDA', style: TextStyle(
          fontFamily: "WorkSansSemiBold",
          fontSize: 20.0,
          color: Colors.white
      ),
      );
    }

    return Text('REMOVE FROM AGENDA',
      style: TextStyle(
          fontFamily: "WorkSansSemiBold",
          fontSize: 20.0,
          color: Colors.white
      ),
    );
  }

  _changeEvents() async {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(
        context, listen: false);
    event.participants.remove(authNotifier.user.uid);

    if (add) {
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
        child: Container(
          width: 120.0, height: 120.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color: Colors.green,
                width: 2.0,
              )
          ),
        )
    );
  }

}

