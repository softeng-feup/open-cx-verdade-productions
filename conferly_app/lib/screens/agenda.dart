import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:conferly/utils/currentUser.dart';

import 'package:conferly/main.dart';


class AgendaState extends State<Agenda> {

  final _biggerFont = const TextStyle(fontSize: 18.0);

  AgendaState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Calendar'),
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

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: MyApp.saved.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          //child: Center(child: _buildRow(MyApp.saved[index])),
          child: RaisedButton(onPressed: inputData,
              )
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
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
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildAboutDialog(context, event),
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

class Agenda extends StatefulWidget {
  @override
  AgendaState createState() => AgendaState();
}