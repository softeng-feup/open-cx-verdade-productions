import 'package:conferly/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
    _LoginPageState createState() => new _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if(input.isEmpty) {
                    return 'Email must not be empty!';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
              ),
              TextFormField(
                validator: (input) {
                  if(input.length < 6) {
                    return "Provide a password longer than 6!";
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signIn,
                child: Text('Sign in'),
              )
            ],
          )
      )

    );
  }

  Future<void> signIn() async{
    // validate fields
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context,MaterialPageRoute(builder: (context)=> MyApp()));
      }
      catch(e) {
        print(e.message);
      }
    }
  }
}



