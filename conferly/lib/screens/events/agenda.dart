import 'package:conferly/models/event.dart';
import 'package:conferly/notifier/auth_notifier.dart';
import 'package:conferly/notifier/event_notifier.dart';
import 'package:conferly/services/auth.dart';
import 'package:conferly/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_summary.dart';

class Agenda extends StatefulWidget {
  @override
  AgendaState createState() => AgendaState();
}

class AgendaState extends State<Agenda> {
  final _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Event> events = [];
  final bool horizontal = false;

  @override
  void initState() {
    super.initState();
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    DatabaseService().getEvents(eventNotifier);
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    events = eventNotifier.eventList;

    Future<void> _refreshList() async {
      DatabaseService().getEvents(eventNotifier);
      events = eventNotifier.eventList;
    }

    return new Scaffold(
      body: new RefreshIndicator(
        onRefresh: _refreshList,
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Agenda'),
              actions: <Widget>[
                FlatButton.icon(onPressed: _signOut,
                    icon: Icon(Icons.person),
                    label: Text('logout'))
              ],
            ),
            _showEvents(),
          ],
        ),
      ),
    );
  }

  Widget _showEvents() {
    return Expanded(
      child: new Container(
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new EventSummary(events[index], index),
                  childCount: events.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(
        context, listen: false);
    print(authNotifier.user.name);
    _auth.signOut(authNotifier);
  }
}
