import 'package:conferly/notifier/event_notifier.dart';
import 'package:conferly/screens/events/calendar.dart';
import 'package:conferly/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:conferly/models/event.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'detailEvent.dart';

class EventSummary extends StatelessWidget {
  final Event event;
  final int index;

  EventSummary(this.event, this.index);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);

    final eventThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Hero(
        tag: "event-hero-${event.title}",
        child: Container(
          height: 100.0,
          width: 100.0,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: CircleAvatar(
              backgroundImage: ExactAssetImage('assets/images/profile.png'),
              minRadius: 50,
              maxRadius: 60,
            ),
          ),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: new Border.all(
              color: Colors.greenAccent,
              width: 2.0,
            ),
          ),
        ),
      ),
    );

    Widget _eventValue({String value, IconData icon}) {
      return new Container(
        child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Icon(
                icon,
                size: 20.0,
                color: Colors.white30,
              ),
              new Container(width: 8.0),
              new Text(
                value,
                style: TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    fontSize: 12.0,
                    color: Colors.white70
                ),
              ),
            ]
        ),
      );
    }


    final eventCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0,16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(event.title, style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 18.0,
              color: Colors.white
            ),
          ),
          new Container(height: 10.0),
          new Text(event.location, style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 14.0,
              color: Colors.white70
            ),
          ),
          new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: 1,
                  child: _eventValue(
                      value: '${event.startDate.toDate().hour.toString()}:${event.startDate.toDate().minute.toString()}h',
                      icon: FontAwesomeIcons.clock)

              ),
              new Container(
                width: 8.0,
              ),
              new Expanded(
                  flex: 1,
                  child: _eventValue(
                      value: '${event.endDate.toDate().hour.toString()}:${event.endDate.toDate().minute.toString()}h',
                      icon: FontAwesomeIcons.clock)
              )
            ],
          ),
        ],
      ),
    );


    final eventCard = new Container(
      child: eventCardContent,
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Colors.green,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new GestureDetector(
        onTap: () {
          eventNotifier.currentEvent = eventNotifier.eventList[index];
          Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailEvent(eventNotifier.currentEvent),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              new FadeTransition(opacity: animation, child: child),
            ) ,
          );
        },
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 20.0,
          ),
          child: new Stack(
            children: <Widget>[
              eventCard,
              eventThumbnail,
            ],
          ),
        )
    );
  }
}