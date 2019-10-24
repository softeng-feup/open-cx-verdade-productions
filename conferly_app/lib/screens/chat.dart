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
                    "Messages",
                    style: TextStyle(fontSize: 24),
                  ),
                  margin: EdgeInsets.all(15),
                );
              } else {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailChat(index-1)),
                    );
//                    print("Container pressed");
                  },
                  child: Container(
                    height: 50,
                    color: Colors.grey,
                    child: Center(
                        child: Text('${MyApp.chatProfiles[index - 1].name}')),
                  ),
                );


              }
            })
    );
  }
}

// Navigator.push(
//    context,
//    MaterialPageRoute(builder: (context) => SecondRoute()),
//  );