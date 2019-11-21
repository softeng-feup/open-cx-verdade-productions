import 'package:conferly/screens/sign_in.dart';
import 'package:conferly/screens/sign_up.dart';
import 'package:conferly/utils/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/**
 *
 * This page is going to have signup and sign in
 */

class WelcomePage extends StatefulWidget {
  WelcomePage({this.auth});

  final BaseAuth auth;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage(auth: widget.auth),fullscreenDialog: true));
  }

  void navigateToSignUP() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignupPage(),fullscreenDialog: true));

  }
}
