import 'package:conferly/notifier/event_notifier.dart';
import 'package:conferly/screens/authenticate/login_register.dart';
import 'package:conferly/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user.dart';
import 'notifier/auth_notifier.dart';
import 'screens/events/calendar.dart';
import 'screens/chat.dart';
import 'screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:conferly/screens/events/agenda.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => AuthNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context) => EventNotifier(),
    ),
  ],
  child: MyApp2(),
));

getCurrentUser(AuthNotifier notifier) async {
  User user = await AuthService().currentUser();
  notifier.setUser(user);
}

class MyApp2 extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    getCurrentUser(authNotifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coding with Curry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
      ),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? MyApp() : LoginRegisterPage();
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  static FirebaseUser firebaseUser;

  static final saved = <DocumentSnapshot>[];

  static final messages = <Message>[
    new Message('ola tudo bem', true, Timestamp(DateTime.now().second, DateTime.now().millisecond)),
    new Message('ola tudo bem', true, Timestamp(DateTime.now().second, DateTime.now().millisecond)),
    new Message('ola', false, Timestamp(DateTime.now().second, DateTime.now().millisecond)),
    new Message('queres um part time na nossa empresa acho que seria uma boa experieincia para comecares, se quiseres podes sempre falar comigo a qualquer momento', true, Timestamp(DateTime.now().second, DateTime.now().millisecond)),
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.orangeAccent[400],
        textTheme: TextTheme(body1: TextStyle(
            fontFamily: "WorkSansRegular",
//            fontSize: 16.0,
            ))
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
        Calendar(),
        Agenda(),
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
//      appBar: AppBar(
//        title: Text(toolbarTitles[bottomSelectedIndex]),
//      ),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        type: BottomNavigationBarType.fixed,
        items: buildBottomNavBarItems(),
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
    );
  }
}

class Message {
  final String text;
  final bool sentByProfile;
  final Timestamp time;
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











