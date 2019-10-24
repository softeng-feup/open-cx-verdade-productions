import 'package:flutter/material.dart';


class LinkButton extends StatelessWidget {

  LinkButton({this.text, this.icon});
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(76, 76), // button width and height
        child: ClipOval(
          child: Material(
            color: Colors.grey, // button color
            child: InkWell(
              splashColor: Colors.blue, // splash color
              onTap: () {}, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  this.icon, // icon
                  Text(this.text), // text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}



class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                   Icon(
                       Icons.person,
                       color: Colors.grey,
                       size:100 ,

                      ),
              Text(
                'Tiago Verdade',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                ),
              ),
              Text(
                'Staff',
                style:TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  letterSpacing: 2,

                )
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Text (
                  'ola sou o tiago e mi gusta fazer aplicacoes. Tou no Ni',
                  style: TextStyle(
                    fontSize: 20
                  ),

                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.insert_emoticon),
                    Text("Student"),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.place),
                    Text("Porto, Portugal"),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                child: LinkButton(
                   text: "Interesses",
                    icon: Icon(Icons.bubble_chart)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  LinkButton(
                    text:"AI",
                    icon: Icon(Icons.adb)
                  ),
                  LinkButton(
                    text:"Android",
                    icon:Icon(Icons.ac_unit)
                  ),
                  LinkButton(
                      text:"Web",
                      icon:Icon(Icons.cast_connected)
                  ),
                  LinkButton(
                      text:"Robotics",
                      icon:Icon(Icons.check_box_outline_blank)
                  ),
                ],
              )






            ],
          ),
            // Navigate to second route when tapped.



    );
  }
}