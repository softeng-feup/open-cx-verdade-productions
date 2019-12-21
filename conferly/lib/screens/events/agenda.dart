import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/models/event.dart';
import 'package:conferly/notifier/auth_notifier.dart';
import 'package:conferly/notifier/event_notifier.dart';
import 'package:conferly/services/database.dart';
import 'package:conferly/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:conferly/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'detailEvent.dart';
import 'event_summary.dart';

class Agenda extends StatefulWidget {
  @override
  AgendaState createState() => AgendaState();
}

class AgendaState extends State<Agenda> {
  final _auth = AuthService();
  EventNotifier eventNotifier;
  AuthNotifier authNotifier;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading;

  //search bar
  TextEditingController editingController = TextEditingController();
  final FocusNode myFocusNodeSearch = FocusNode();

  //events and corresponding dates
  List<Event> events = List<Event>();
  List<String> dates = List<String>();
  int _date;

  Future<void> _eventsList(String uid) async {
    setState(() {
      loading = true;
    });
    List<Event> e = await DatabaseService().getEventsFromUser(uid);
    eventNotifier.setEvents(e);
    List<Event> sorted = eventNotifier.eventList;
    sorted.sort((a , b) { return a.startDate.toDate().compareTo(b.startDate.toDate());});
    setState(() {
      events.clear();
      events.addAll(sorted);
    });
    _datesList();
    setState(() {
      loading = false;
    });
  }

  void _datesList() {
    var d = Set<String>();
    for (int i = 0; i < events.length; i++) {
      d.add('${new DateFormat("dd MMMM").format(events[i].startDate.toDate())}');
    }
    List<String> _dates = d.toList();
    setState(() {
      dates.clear();
      dates.addAll(_dates);
      dates.add('All Dates');
      _date = dates.length - 1;
    });
  }

  @override
  void initState() {
    authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    _eventsList(authNotifier.user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            key: "signout",
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.white,
            ),
            onPressed: _signOut
          )
        ],
      ),
      key: _scaffoldKey,
      body: loading ? Loading() : Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 8.0,),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 9.0,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 50.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 3.0, left: 25.0, right: 25.0),
                            child: TextField(
                              onChanged: (value) {
                                _filterSearchResults(value);
                              },
                              focusNode: myFocusNodeSearch,
                              controller: editingController,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.search,
                                  color: Colors.black,
                                  size: 22.0,
                                ),
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new Container(
                  width: 1.0,
                ),
                new Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.0, left: 5.0),
                        child: DropdownButton(
                          value: _date == null ? null : dates[_date],
                          icon: Icon(FontAwesomeIcons.calendarDay),
                          iconSize: 15,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 14.0,
                              color: Colors.black),
                          items: dates.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _filterDateResults(value);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _showEvents(),
        ],
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
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) {
                        return new GestureDetector(
                          onTap: () {
                            eventNotifier.currentEvent = eventNotifier.eventList[index];
                            Navigator.of(context).push(
                              new PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new DetailEvent(events[index], !events[index].participants.contains(authNotifier.user.uid)),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                                new SlideTransition(position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation), child: child),
                              ) ,
                            ).then((_) async {
                              setState(() {
                                loading = true;
                              });
                              await _eventsList(authNotifier.user.uid);
                              setState(() {
                                loading = false;
                              });
                            });
                          },
                          child: new EventSummary(events[index], index),
                        );
                      },
                  childCount: events.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterSearchResults(String query) {
    List<Event> dummySearchList = List<Event>();
    dummySearchList = eventNotifier.eventList;
    if (query.isNotEmpty) {
      List<Event> dummyListData = List<Event>();
      dummySearchList.forEach((item) {
        String title = item.title.toLowerCase();
        if (title.contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        events.clear();
        events.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        events.clear();
        events.addAll(eventNotifier.eventList);
      });
    }
  }

  void _filterDateResults(String date) {
    setState(() {
      _date = dates.indexOf(date);
      events.clear();
      events.addAll(eventNotifier.eventList);
    });

    List<Event> dummySearchList = List<Event>();
    dummySearchList = events;
    if (_date != dates.length - 1) {
      List<Event> dummyListData = List<Event>();
      dummySearchList.forEach((item) {
        if ('${new DateFormat("dd MMMM").format(item.startDate.toDate())}' == date) {
          dummyListData.add(item);
        }
      });
      setState(() {
        events.clear();
        events.addAll(dummyListData);
      });
      return;
    }
  }

  void _signOut() {
    print(authNotifier.user.name);
    _auth.signOut();
    authNotifier.setUser(null);
  }
}