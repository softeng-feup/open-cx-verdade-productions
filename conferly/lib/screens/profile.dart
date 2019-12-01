import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferly/main.dart';
import 'package:flutter/material.dart';


class InfoWrapper extends StatelessWidget {

  InfoWrapper({this.text, this.icon, this.bg});

  final String text;
  final Icon icon;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: this.bg,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
          children: <Widget>[
            this.icon, // icon
            Expanded (
                child: Container (
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(this.text),
                )
            )
          ]
      ),
    );
  }

}

class Profile extends StatefulWidget {

  @override
  ProfileState createState() {
    return new ProfileState();
  }
}


class ProfileState extends State<Profile> {

  String _fullName = "Name";
  String _status = "Status";
  String _bio = "Bio";
  String _local = "Location";
  String _work = "Work";
  List<String> _interests = [];
  bool _loading = true;

  getUserInfo() async {
    Firestore.instance
        .collection("Users")
        .document(MyApp.firebaseUser.uid)
        .get().then((document) {
      if (document.exists) {
        setState(() {
          if (document.data['name'] != "" && document.data['name'] != null)
            _fullName = document.data['name'];
          if (document.data['description'] != "" &&
              document.data['description'] != null)
            _bio = document.data['description'];
          if (document.data['location'] != "" &&
              document.data['location'] != null)
            _local = document.data['location'];
          if (document.data['status'] != "" && document.data['status'] != null)
            _status = document.data['status'];
          if (document.data['work'] != "" && document.data['work'] != null)
            _work = document.data['work'];
          _interests.clear();
          _interests = document.data['interests'].cast<String>();
          _loading = false;
        });
      }
    });
  }

  ProfileState() {
    getUserInfo();
  }

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
        child: Container(
          width: 140.0, height: 140.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color: Colors.grey,
                width: 5.0,
              )
          ),
        )
    );
  }

  Widget _buildFullName() {
    TextStyle _nameStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
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
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
            _status,
            style: TextStyle(
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
      style: _style,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSperator(Size screen) {
    return Container(
      width: screen.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 15.0, bottom: 8.0),
    );
  }

  Widget _buildInterests() {
    List <Widget> chipChildren = new List<Widget>();
    for (int i = 0; i < _interests.length; i++) {
      chipChildren.add(
          Chip(
            label: Text(_interests[i]),
            avatar: Icon(Icons.adb),
            labelPadding: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          )
      );
    }

    return Wrap(
        spacing: 8.0,
        runSpacing: 2.0,
        alignment: WrapAlignment.center,
        children: chipChildren
    );
  }


  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: _loading ?
        Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme
                        .of(context)
                        .accentColor)))
            : SingleChildScrollView(
          child: Stack(
          children: <Widget>[
            _coverImage(sizeScreen),
            Container(
              margin:EdgeInsets.all(16),
              child: Column(
                  children: <Widget>[
                    SizedBox(height: sizeScreen.height / 6.4,),
                    _profileImage(),
                    _buildFullName(),
                    _buildStatus(context),
                    _buildBio(),
                    _buildSperator(sizeScreen),
                    InfoWrapper(
                        text: _local,
                        icon: Icon(Icons.place),
                        bg: Theme
                            .of(context)
                            .scaffoldBackgroundColor),
                    InfoWrapper(
                        text: _work,
                        icon: Icon(Icons.work), bg: Theme
                        .of(context)
                        .scaffoldBackgroundColor),
                    _buildInterests()
                  ],
                ),
              )
          ]

            )


        )
    );
//    );
  }

}

