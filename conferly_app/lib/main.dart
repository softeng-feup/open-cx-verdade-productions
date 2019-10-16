import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      home: Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
        ),
        body: Container(
          alignment: Alignment.bottomCenter,
          child: Menu(),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final border = BoxDecoration(color: Colors.lightBlueAccent[200], );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            }, icon: Icon( Icons.face), highlightColor: Colors.lightBlueAccent[100],),
          ),
          Expanded(
            child: IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Agenda()),
              );
            }, icon: Icon( Icons.view_agenda), highlightColor: Colors.lightBlueAccent[100],),
          ),
          Expanded(
            child: IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calendar()),
              );
            }, icon: Icon( Icons.calendar_today), highlightColor: Colors.lightBlueAccent[100],),
          ),
          Expanded(
            child: IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chat()),
              );
            }, icon: Icon( Icons.chat), highlightColor: Colors.lightBlueAccent[100],),
          ),
        ],
      ),
    );
  }


}


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Im the Profile'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String description;
  final String speaker;
  Event(this.title, this.description, this.speaker);
}

final _events = <Event>[
  new Event('Workshop Latex', 'Estás farto do Word e de nunca conseguires pôr aquele índice manhoso direitinho? Queres ter 20 na estética do relatório? A dissertação está aí à porta? Então este Workshop é para ti!', 'Joao Varela'),
  new Event('Workshop C++', 'waecewafewaf', 'Joao Abelha'),
  new Event('Industria 4.0', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('A decidir', 'waecewafewaf', 'Vitor Barbosa'),
  new Event('Aqui em baixo', 'waecewafewaf', 'Vitor Barbosa'),
];

final _saved = <Event>[];

class AgendaState extends State<Agenda> {

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
      ),
      body: Center(
        child: _showSaved(),
      ),
    );
  }

  Widget _showSaved() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _saved.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Center(child: _buildRow(_saved[index])),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildRow(Event event) {
    final bool alreadySaved = _saved.contains(event);
    return ListTile(
      title: Text(
        event.title,
        style: _biggerFont,
      ),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle),
        color: Colors.lightBlueAccent[100],
        onPressed: () {
          setState(() {
              _saved.remove(event);
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

  Widget _buildAboutDialog(BuildContext context, Event event) {
    final bool alreadySaved = _saved.contains(event);
    var bottom = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(event.speaker, textAlign: TextAlign.end,),
        IconButton(
          icon: Icon(Icons.remove_circle),
          color: Colors.lightBlueAccent[100],
          onPressed: () {
          setState(() {
            _saved.remove(event);
          });
          Navigator.of(context).pop();},
          ),
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

class Agenda extends StatefulWidget {
  @override
  AgendaState createState() => AgendaState();
}

class CalendarState extends State<Calendar>{
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Center(
        child: _showEvents(),
      ),
    );
  }

  Widget _showEvents() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _events.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Center(child: _buildRow(_events[index])),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }


  Widget _buildRow(Event event) {
    final bool alreadySaved = _saved.contains(event);
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
              _saved.remove(event);
            } else {
              _saved.add(event);
            }
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

  Widget _buildAboutDialog(BuildContext context, Event event) {
    final bool alreadySaved = _saved.contains(event);
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
                _saved.remove(event);
              } else {
                _saved.add(event);
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

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Im the Chat'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}