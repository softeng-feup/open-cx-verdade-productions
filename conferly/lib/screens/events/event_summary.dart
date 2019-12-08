import 'package:conferly/notifier/auth_notifier.dart';
import 'package:conferly/notifier/event_notifier.dart';
import 'package:conferly/screens/events/agenda.dart';
import 'package:conferly/widgets/separator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:conferly/models/event.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'detailEvent.dart';

class EventSummary extends StatelessWidget {
  final Event event;
  final int index;

  EventSummary(this.event, this.index);

  @override
  Widget build(BuildContext context) {
    final eventThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 1.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Hero(
        tag: "event-hero-${event.title}",
        child: Container(
          height: 100.0,
          width: 100.0,
          child: Padding(
            padding: EdgeInsets.all(0),
            child:
            _profileImage(),
          ),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: new Border.all(
              color: Colors.green,
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


    final eventCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0,16.0, 16.0, 1.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: 5,
                  child: new Text(event.title, style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 18.0,
                      color: Colors.black
                    ),
                  ),
              ),
              new Expanded(
                  flex: 1,
                  child: Icon(
                    FontAwesomeIcons.arrowCircleRight,
                    color: Colors.black,
                    size: 22.0,
                  ),
              )
            ],
          ),
          new Text(event.location, style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 14.0,
              color: Colors.black54
            ),
          ),
          new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: 1,
                  child: _eventValue(
                      value: ' '
                          '${event.startDate.toDate().hour.toString().padLeft(2, '0')}'
                          ':'
                          '${event.startDate.toDate().minute.toString().padLeft(2, '0')}h'
                          '-'
                          '${event.endDate.toDate().hour.toString().padLeft(2, '0')}'
                          ':'
                          '${event.endDate.toDate().minute.toString().padLeft(2, '0')}h',
                      icon: FontAwesomeIcons.solidClock)

              ),
              new Container(
                width: 1.0,
              ),
              new Expanded(
                  flex: 1,
                  child: _eventValue(
                      value: ' ${new DateFormat("dd MMMM").format(event.startDate.toDate())}',
                      icon: FontAwesomeIcons.calendarDay)
              )
            ],
          ),
        ],
      ),
    );


    final eventCard = new Container(
      child: eventCardContent,
      height: 100.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Colors.white,
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


    return new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 13.0,
          ),
          child: new Stack(
            children: <Widget>[
              eventCard,
              eventThumbnail,
            ],
          ),
    );
  }

  Widget _profileImage() {
    print(event.speaker_uid);
    return profileImage(event.speaker_uid);
  }
}

class profileImage extends StatefulWidget {


  String _profileUid;

  profileImage(String uid) {
    this._profileUid = uid;
  }


  @override
  profileImageState createState() => profileImageState();
}

class profileImageState extends State<profileImage>{

  String imageFile;

  getImagePath() {
    print(widget._profileUid);
    StorageReference photo = FirebaseStorage(storageBucket: 'gs://conferly-8779b.appspot.com/').ref().child('images/${widget._profileUid}.png');
    photo.getDownloadURL().then((data){
      setState(() {
        imageFile = data;
      });
    }).catchError((error) {

    });
  }

  @override
  void initState() {
    super.initState();
    getImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundImage: (imageFile != null) ? new NetworkImage(imageFile) : (AssetImage('assets/images/profile.png')),
    minRadius: 50,
    maxRadius: 60,
    );
  }
}