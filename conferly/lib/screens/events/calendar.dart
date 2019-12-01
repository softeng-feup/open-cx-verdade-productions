import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:conferly/services/auth.dart';
import 'package:conferly/main.dart';
import 'detailEvent.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  final _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
        title: Text('Calendar'),
          actions: <Widget>[
            FlatButton.icon(onPressed: () {}, icon: Icon(Icons.person), label: Text('logout')),
          ],
      ),
      body: Center(
        child: _showSaved(),
      ),
    );
  }

  void inputData() async {
    //FirebaseUser user =  await auth.currentUser() ;
    //var uid = user.uid;
    //print(uid);
    // here you write the codes to input the data into firestore
  }

  Widget _showSaved() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Events')
            .where("participants", arrayContains: MyApp.firebaseUser.uid)
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
    final bool alreadySaved = MyApp.saved.contains(event);
    return ListTile(
      title: Text(
        event['name'],
        style: _biggerFont,
      ),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle),
        color: Colors.lightBlueAccent[100],
        onPressed: () {
          setState(() {
            MyApp.saved.remove(event);
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
    final bool alreadySaved = MyApp.saved.contains(event);
    var bottom = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(event['speaker'], textAlign: TextAlign.end,),
        IconButton(
          icon: Icon(Icons.remove_circle),
          color: Colors.lightBlueAccent[100],
          onPressed: () {
            setState(() {
              MyApp.saved.remove(event);
            });
            Navigator.of(context).pop();},
        ),
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