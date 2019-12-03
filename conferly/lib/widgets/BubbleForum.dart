import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BubbleForum extends StatelessWidget {

  final DocumentSnapshot message;
  final delivered = true;


  final fDate = new DateFormat('EEE, d MMMM');
  final fTime = new DateFormat('HH:mm');

//  String s_date = fDate.format(ts.toDate());
//  String s_time = fTime.format(ts.toDate()) + " - " + fTime.format(te.toDate());

  BubbleForum(this.message);


  @override
  Widget build(BuildContext context) {
    final int likes = message['likes'].length;
    final int dislikes = message['dislikes'].length;
    final String senderName = message['name_sender'];
    final String senderUID = message['uid_sender'];
    final Timestamp ts = message['time'];
    final String text = message['text'];

//    print("Message: ");
//    print(message.time);
    String dateString = fTime.format(ts.toDate());
    final bg = true ? Colors.white : Colors.greenAccent.shade100;
    final align = true ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = true
        ? BorderRadius.only(
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(5.0),
    )
        : BorderRadius.only(
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0),
      bottomRight: Radius.circular(10.0),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 16),
          child: _profileImage(senderUID),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(senderName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Text(text)
              )
            ],
          ),
        ),
//          Expanded(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              child: Container( padding: EdgeInsets.all(8),child: Icon(Icons.thumb_up, size: 20)),
              onTap: () => null,
            ),
            GestureDetector(
              child: Container( padding: EdgeInsets.all(8),child: Icon(Icons.thumb_down, size: 20)),
              onTap: () => null,
            ),
          ],
        )
//          )
      ],
    );

//    return Column(
//      crossAxisAlignment: align,
//      children: <Widget>[
//        Container(
//          margin: const EdgeInsets.all(3.0),
//          padding: const EdgeInsets.all(8.0),
//          decoration: BoxDecoration(
//            boxShadow: [
//              BoxShadow(
//                  blurRadius: .5,
//                  spreadRadius: 1.0,
//                  color: Colors.black.withOpacity(.12))
//            ],
//            color: bg,
//            borderRadius: radius,
//          ),
//          child: Stack(
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(right: 48.0),
//                child: Text(text),
//              ),
//              Positioned(
//                bottom: 0.0,
//                right: 0.0,
//                child: Row(
//                  children: <Widget>[
//                    Text(dateString,
//                        style: TextStyle(
//                          color: Colors.black38,
//                          fontSize: 10.0,
//                        )),
//                    SizedBox(width: 3.0),
//                    Icon(
//                      icon,
//                      size: 12.0,
//                      color: Colors.black38,
//                    )
//                  ],
//                ),
//              )
//            ],
//          ),
//        )
//      ],
//    );
  }
}

class _profileImage extends StatefulWidget {


  String _profileUid;

  _profileImage(String uid) {
    this._profileUid = uid;
  }


  @override
  _profileImageState createState() => _profileImageState();
}

class _profileImageState extends State<_profileImage>{

  String imageFile;

  getImagePath() async {
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
    return Center(
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: (imageFile != null) ? new NetworkImage(imageFile) : (AssetImage('assets/images/profile.png')),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              )),
        ));
  }
}