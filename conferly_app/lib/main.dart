import 'package:conferly/screens/WelcomePage.dart';
import 'package:conferly/utils/currentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'screens/agenda.dart';
import 'screens/calendar.dart';
import 'screens/chat.dart';
import 'screens/profile.dart';
import 'screens/WelcomePage.dart';


//void main() => runApp(MyApp());

void main() => runApp(MyApp2());

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "form",
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new WelcomePage(auth: new Auth())
    );
  }
}

class MyApp extends StatelessWidget {

  static FirebaseUser firebaseUser;

  static final saved = <DocumentSnapshot>[];

  static final messages = <Message>[
    new Message('ola tudo bem', true, 1573125889444),
    new Message('ola tudo bem', true, 1573125890444),
    new Message('ola', false, 1573125989444),
    new Message('queres um part time na nossa empresa acho que seria uma boa experieincia para comecares, se quiseres podes sempre falar comigo a qualquer momento', true, 1573135889444),
  ];

  static final chatProfiles = <MessageProfile> [
    new MessageProfile("Contratador", 12312321312, true, messages),
    new MessageProfile("Rafa Varela", 12312321312, false, messages),
    new MessageProfile("Abelha", 12312321312, false, messages),
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int bottomSelectedIndex = 0;
  final toolbarTitles = ["Calendar", "Agenda", "Chat", "Profile"];

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: new Icon(Icons.view_agenda),
        title: new Text(toolbarTitles[0])
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.event),
        title: new Text(toolbarTitles[1]),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        title: Text(toolbarTitles[2])
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        title: Text(toolbarTitles[3])
      )
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Agenda(),
        Calendar(),
        Chat(),
        Profile()
      ],
    );
  }

  @override
  void initState() {
    bottomSelectedIndex = 0;
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(toolbarTitles[bottomSelectedIndex]),
      ),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        type: BottomNavigationBarType.fixed,
        items: buildBottomNavBarItems(),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
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

class Message {
  final String text;
  final bool sentByProfile;
  final int time;
  final bool received;

  Message(this.text, this.sentByProfile, this.time, {this.received = false});
}

class MessageProfile {
  String name;
  int lastOnline;
  bool online;
  List<Message> messages;

  MessageProfile(this.name, this.lastOnline, this.online, this.messages);
}











