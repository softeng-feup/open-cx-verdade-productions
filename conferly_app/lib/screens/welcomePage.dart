import 'package:conferly/screens/sign_in.dart';
import 'package:conferly/screens/sign_up.dart';
import 'package:flutter/material.dart';

/**
 *
 * This page is going to have signup and sign in
 */

class welcomePage extends StatefulWidget {

  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (
      title: Text('Welcome')
      ),
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: navigateToSignIn,
            child: Text('Sign in')
          ),
          RaisedButton(
            onPressed: navigateToSignUP,
            child: Text('Sign up'),
          )
        ],
      )
    );
  }

  void navigateToSignIn() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage(),fullscreenDialog: true));
  }

  void navigateToSignUP() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage(),fullscreenDialog: true));

  }
}
