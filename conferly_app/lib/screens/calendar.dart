import 'package:flutter/material.dart';

import 'package:conferly/main.dart';
import 'detailEvent.dart';

class CalendarState extends State<Calendar>{
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _showEvents(),
      ),
    );
  }

  Widget _showEvents() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: MyApp.events.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Center(child: _buildRow(MyApp.events[index])),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }


  Widget _buildRow(Event event) {
    final bool alreadySaved = MyApp.saved.contains(event);
    return ListTile(
      title: Text(
        event.title,
        style: _biggerFont,
      ),
      trailing: IconButton(
        icon: alreadySaved ? Icon(Icons.add_circle) : Icon(Icons.add_circle_outline),
        color: alreadySaved ?  Colors.lightBlueAccent[100] : null,
        onPressed: () {
          setState(() {
            if (alreadySaved) {
              MyApp.saved.remove(event);
            } else {
              MyApp.saved.add(event);
            }
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

  Widget _buildAboutDialog(BuildContext context, Event event) {
    final bool alreadySaved = MyApp.saved.contains(event);
    var bottom = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(event.speaker, textAlign: TextAlign.end,),
        IconButton(
          icon: alreadySaved ? Icon(Icons.add_circle) : Icon(Icons.add_circle_outline),
          color: alreadySaved ? Colors.lightBlueAccent[100] : null,
          onPressed: () {
            setState(() {
              if (alreadySaved) {
                MyApp.saved.remove(event);
              } else {
                MyApp.saved.add(event);
              }
            });
            Navigator.of(context).pop();},
        )
      ],
    );

    return new AlertDialog(
      title: Text(event.title),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(event.description),
          SizedBox(height: 30),
          bottom,
        ],
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}