import 'package:conferly/models/event.dart';
import 'package:conferly/notifier/auth_notifier.dart';
import 'package:conferly/notifier/event_notifier.dart';
import 'package:conferly/services/database.dart';
import 'package:flutter/material.dart';
import 'package:conferly/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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

  //search bar
  TextEditingController editingController = TextEditingController();
  final FocusNode myFocusNodeSearch = FocusNode();

  //events and corresponding dates
  List<Event> events = List<Event>();
  List<String> dates = List<String>();
  int _date;

  Future<void> _eventsList(String uid) async {
    List<Event> e = await DatabaseService().getEventsFromUser(uid);
    eventNotifier.setEvents(e);
    List<Event> sorted = eventNotifier.eventList;
    sorted.sort((a , b) { return a.startDate.toDate().compareTo(b.startDate.toDate());});
    setState(() {
      events.clear();
      events.addAll(sorted);
    });
    _datesList();
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
    _eventsList(authNotifier.user.uid);

    return new Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 30.0,),
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
                      (context, index) => new EventSummary(events[index], index, false),
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
    dummySearchList = events;
    if (query.isNotEmpty) {
      List<Event> dummyListData = List<Event>();
      dummySearchList.forEach((item) {
        if (item.title.contains(query)) {
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