import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

class EditProfile extends StatefulWidget {

  @override
  EditProfileState createState() {
    return EditProfileState();
  }
}


class EditProfileState extends State<EditProfile> {

  String _bio;
  String _location;
  String _work;

  List<String> selectedInterestsList = List();

  List<String> reportList = [
    "AI",
    "Android",
    "IOS",
    "Mobile",
    "Web"
  ];

  bool _loading = true;

  EditProfileState(){
    getUserInfo();
  }

  getUserInfo() async {
    Firestore.instance
        .collection("Users")
        .document(MyApp.firebaseUser.uid)
        .get().then((document) {
      if (document.exists) {
        setState(() {
//          if (document.data['name'] != "" && document.data['name'] != null)
//            _fullName = document.data['name'];
          if (document.data['description'] != "" &&
              document.data['description'] != null)
            _bio = document.data['description'];
          if (document.data['location'] != "" &&
              document.data['location'] != null)
            _location = document.data['location'];
//          if (document.data['status'] != "" && document.data['status'] != null)
//            _status = document.data['status'];
          if (document.data['work'] != "" && document.data['work'] != null)
            _work = document.data['work'];
          selectedInterestsList.clear();
          if (document.data['interests'] != null)
            selectedInterestsList = document.data['interests'].cast<String>();
          _loading = false;
        });
      }
    });
  }

  setUserInfo() async{
    await Firestore.instance
        .collection("Users")
        .document(MyApp.firebaseUser.uid)
        .setData({
          "description": _bio,
          "location": _location,
          "work": _work,
          "interests": selectedInterestsList,
    }, merge: true);
    print("RUNNIHG");
    print("USER: " + MyApp.firebaseUser.uid);
    print("description: " + _bio);
    print("location: " + _location);
    print("work: " + _work);
    print("interests: " + selectedInterestsList.toString());
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Edit profile"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done, color: Colors.white,), onPressed: _loading ? null : () {
            setUserInfo();
            Navigator.pop(context);
          })
        ],
      ),
      body: _loading ?
      Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme
                      .of(context)
                      .accentColor)))
          :SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _showBioInput(),
                _showLocationInput(),
                _showWorkInput(),
                _showInterestsInput(),
                _buildInterests()
              ],
            ),
          )
        )
    );
  }

  Widget _showBioInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        autofocus: false,

        initialValue: _bio,

        decoration: new InputDecoration(
            labelText: 'Bio',
            icon: new Icon(
              Icons.assignment,
              color: Colors.grey,
            )
        ),

        onChanged: (value) => _bio = value,
//          onSaved: (value) => print('saved'),
      ),
    );
  }

  Widget _showLocationInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,

        initialValue: _location,

        decoration: new InputDecoration(
            labelText: 'Location',
            icon: new Icon(
              Icons.place,
              color: Colors.grey,
            )),

        onChanged: (value) => _location = value,
      ),
    );
  }


  Widget _showWorkInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,

        initialValue: _work,

        decoration: new InputDecoration(
            labelText: 'Work',
            icon: new Icon(
              Icons.work,
              color: Colors.grey,
            )),

        onChanged: (value) => _work = value,
      ),
    );
  }

  Widget _showInterestsInput(){
    return Container(
      margin: EdgeInsets.only(top: 24, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(width: 50.0, height: 0.0),
          //                Text("Interests", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Interests", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          IconButton(icon: Icon(Icons.edit, size: 24.0), onPressed: () => _showReportDialog()),
        ],
      ),
    );
  }

  _showReportDialog() {
    List<String> listCur = new List<String>.from(selectedInterestsList);

    const String CONFIRM = "CONFIRM";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Choose Interests"),
            content: MultiSelectChip(
              reportList,
              previousSelected: listCur,
              onSelectionChanged: (selectedList) {
//                setState(() {
                  listCur = selectedList;
//                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Submit"),
                onPressed: () => Navigator.of(context).pop(CONFIRM),
              )
            ],
          );
        }).then((onValue){
          if (onValue == CONFIRM){
            setState(() {
              selectedInterestsList = new List<String>.from(listCur);
            });
          } else {
            listCur = new List<String>.from(selectedInterestsList);
          }
    });
  }


  Widget _buildInterests() {
    List <Widget> chipChildren = new List<Widget>();
    for (int i = 0; i < selectedInterestsList.length; i++) {
      chipChildren.add(
          Chip(
            label: Text(selectedInterestsList[i]),
            avatar: Icon(Icons.adb),
            labelPadding: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          )
      );
    }

    if (chipChildren.length == 0){
      return Container(
        margin: EdgeInsets.all(8),
        child: Text("No choosen interests"),
      );
    }

    return Wrap(
        spacing: 8.0,
        runSpacing: 2.0,
        alignment: WrapAlignment.center,
        children: chipChildren
    );
  }



}


class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final List<String> previousSelected;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged, this.previousSelected});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {

  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();
    if (widget.previousSelected != null)
      selectedChoices = widget.previousSelected;

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {

              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged(selectedChoices);
              });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}