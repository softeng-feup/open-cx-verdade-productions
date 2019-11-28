import 'package:flutter/material.dart';

import 'package:conferly/main.dart';
import 'detailChat.dart';

import 'detailEvent.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: MyApp.chatProfiles.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  child: Text(
                    MyApp.firebaseUser.uid,
                    style: TextStyle(fontSize: 24),
                  ),
                  margin: EdgeInsets.all(15),
                );
              } else {
                return getProfileChat(context, index - 1);


              }
            })
    );
  }

  Widget getProfileChat(BuildContext context, int indexProfile){
    MessageProfile profile = MyApp.chatProfiles[indexProfile];
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailChat(indexProfile)),
        );
//                    print("Container pressed");
      },
      child: Container(
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _profileImage(),
            Column(children: <Widget>[
              Text(profile.name, style: TextStyle(fontWeight: FontWeight.bold),),
              Text("Ola tudo bem"),
            ],),
            Text("12:45")
          ],
        ),
      )
    );
  }

  Widget _profileImage() {
    return Center(
        child: Container (
          width: 40.0, height:40.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color:Colors.grey,
                width:1.0,
              )
          ),
        )
    );
  }
}