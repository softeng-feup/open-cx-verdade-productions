import 'package:flutter/material.dart';

import 'package:conferly/main.dart';
import 'package:conferly/widgets/Bubble.dart';

import 'detailEvent.dart';

class DetailChat extends StatelessWidget {
  int indexProfile;

  DetailChat(this.indexProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(MyApp.chatProfiles[indexProfile].name),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: MyApp.chatProfiles[indexProfile].messages.length,
            itemBuilder: (BuildContext context, int index) {

              return Bubble(message: MyApp.chatProfiles[indexProfile].messages[index].text,
              time: MyApp.chatProfiles[indexProfile].messages[index].time.toString(),
              delivered: true,
              isMe: MyApp.chatProfiles[indexProfile].messages[index].sentByProfile);
            }));
  }
}

//Container(
//                height: 50,
//                color: MyApp.chatProfiles[indexProfile].messages[index].sentByProfile? Colors.grey : Colors.blue,
//                child: Center(
//                    child: Text('${MyApp.chatProfiles[indexProfile].messages[index].text}')),
//              );