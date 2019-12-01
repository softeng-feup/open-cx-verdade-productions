import 'package:flutter/material.dart';


class InfoWrapper extends StatelessWidget {

  InfoWrapper({this.text, this.icon, this.bg});
  final String text;
  final Icon icon;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: this.bg,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
          children: <Widget>[
            this.icon, // icon
            Text(this.text), // text
          ]
      ),


    );
  }

}

class Profile extends StatelessWidget {

  final String _fullName = "Tiago Verdade";
  final String _status = "Staff";
  final String _bio = "'Sou o Tiago e Mi gusta los meninos' ";
  final String _local = "Porto, Portugal";
  final String _work = "Student";

  Widget _coverImage(Size screen) {
    return Container(
      height: screen.height / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/feup.jpeg'),
          fit: BoxFit.cover,

        ),
      ),
    );

  }

  Widget _profileImage() {
    return Center(
      child: Container (
        width: 140.0, height:140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color:Colors.grey,
            width:5.0,
          )
        ),
      )
    );
  }

  Widget _buildFullName() {
    TextStyle _nameStyle = TextStyle(
      fontFamily: 'Roboto',
      color:Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Text(
      _fullName,
      style: _nameStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 50.0),
      decoration: BoxDecoration(
        color:Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child:Text(
        _status,
        style:TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,

        )
      )

    );
  }


  Widget _buildBio() {
    TextStyle _style = TextStyle(
      fontFamily: 'Spectral',
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      color: Color(0xFF788495),
    );
    return Text(
      _bio,
      style:_style,
    );
  }

  Widget _buildSperator(Size screen) {
    return Container(
      width: screen.width/1.6,
      height: 2.0,
      color:Colors.black54,
      margin: EdgeInsets.only(top:15.0),
    );
  }



  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Stack(
        children: <Widget>[
          _coverImage(sizeScreen),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: sizeScreen.height/6.4,),
                  _profileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildBio(),
                  _buildSperator(sizeScreen),
                   InfoWrapper(
                       text:_local,
                       icon: Icon(Icons.place),
                       bg: Theme.of(context).scaffoldBackgroundColor),
                  InfoWrapper(
                    text: _work,
                    icon:Icon(Icons.work), bg: Theme.of(context).scaffoldBackgroundColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InfoWrapper(
                            text:"Robotics",
                            icon:Icon(Icons.adb),
                            bg: Colors.grey ),
                        InfoWrapper(
                            text:"AI",
                            icon:Icon(Icons.brush),
                            bg: Colors.grey ),
                        InfoWrapper(
                            text:"Web",
                            icon:Icon(Icons.wifi),
                            bg: Colors.grey ),
                        InfoWrapper(
                            text:"Android",
                            icon:Icon(Icons.android),
                            bg: Colors.grey ),

                    ]
                  ),
                ],
              ),
            )
            ,
          )

        ],
      )
    );
  }

}

