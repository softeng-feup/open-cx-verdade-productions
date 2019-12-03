import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/main.dart';
import 'package:conferly/screens/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BubbleForum extends StatelessWidget {

  final DocumentSnapshot message;
//  final Function onLike;
//  final Function onDislike;
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

    final bool liked = message['likes'].contains(MyApp.firebaseUser.uid);
    final bool disliked = message['dislikes'].contains(MyApp.firebaseUser.uid);

//    print("Message: ");
//    print(message.time);
    String dateString = fTime.format(ts.toDate());
    final bg = senderUID != MyApp.firebaseUser.uid ? Colors.white : Colors.green[100];

    return Container(
        color: bg,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: _profileImage(senderUID),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(user: senderUID,)),
                );
              },
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
                  child: Container( color: bg, padding: EdgeInsets.all(8),child: Icon(Icons.thumb_up, size: 20, color: liked ? Theme.of(context).primaryColor : null,)),
                  onTap: () => clickUpvote(),
                ),
                Text((likes-dislikes).toString(), style: TextStyle(fontSize: 11)),
                GestureDetector(
                  child: Container( color: bg, padding: EdgeInsets.all(8),child: Icon(Icons.thumb_down, size: 20, color: disliked ? Theme.of(context).accentColor : null, )),
                  onTap: () => clickDownvote(),
                ),
              ],
            )
    //          )
          ],
      )
    );
  }

  clickUpvote(){
    Firestore.instance.runTransaction((transaction) async {

      if (message['likes'].contains(MyApp.firebaseUser.uid)) {
        await transaction.update(message.reference, <String, dynamic>{
          'likes': FieldValue.arrayRemove([MyApp.firebaseUser.uid])
        });
      } else {
        if (message['dislikes'].contains(MyApp.firebaseUser.uid)){
          await transaction.update(message.reference, <String, dynamic>{
            'dislikes': FieldValue.arrayRemove([MyApp.firebaseUser.uid])
          });
        }
        await transaction.update(message.reference, <String, dynamic>{
          'likes': FieldValue.arrayUnion([MyApp.firebaseUser.uid])
        });
      }

    });
  }

  clickDownvote(){
    Firestore.instance.runTransaction((transaction) async {

      if (message['dislikes'].contains(MyApp.firebaseUser.uid)) {
        await transaction.update(message.reference, <String, dynamic>{
          'dislikes': FieldValue.arrayRemove([MyApp.firebaseUser.uid])
        });
      } else {
        if (message['likes'].contains(MyApp.firebaseUser.uid)){
          await transaction.update(message.reference, <String, dynamic>{
            'likes': FieldValue.arrayRemove([MyApp.firebaseUser.uid])
          });
        }
        await transaction.update(message.reference, <String, dynamic>{
          'dislikes': FieldValue.arrayUnion([MyApp.firebaseUser.uid])
        });
      }

    });
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