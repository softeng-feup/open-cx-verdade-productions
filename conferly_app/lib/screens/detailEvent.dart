import 'package:flutter/material.dart';

class DetailEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Im the EVENT'),
          onPressed: () {

          },
        ),
      ),
    );
  }
}