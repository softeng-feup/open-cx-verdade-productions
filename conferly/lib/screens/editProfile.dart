import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  String _tags;

//  bool begin = true;

  List<String> selectedInterestsList = List();

  List<String> reportList = [
    "AI",
    "Android",
    "IOS",
    "Mobile",
    "Web"
  ];


//  void fu(var duration){
//    setState(() {
//      begin = false;
//    });
//  }


  @override
  Widget build(BuildContext context) {
//    WidgetsBinding.instance
//        .addPostFrameCallback(fu);
    return Scaffold(
        appBar: AppBar(
        title: Text("Edit profile"),
      ),
      body: SingleChildScrollView(
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

        decoration: new InputDecoration(
            labelText: 'Bio',
            icon: new Icon(
              Icons.assignment,
              color: Colors.grey,
            )
        ),

        onSaved: (value) => _bio = value.trim(),
      ),
    );
  }

  Widget _showLocationInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,

        decoration: new InputDecoration(
            labelText: 'Location',
            icon: new Icon(
              Icons.place,
              color: Colors.grey,
            )),

        onSaved: (value) => _location = value.trim(),
      ),
    );
  }


  Widget _showWorkInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,

        decoration: new InputDecoration(
            labelText: 'Work',
            icon: new Icon(
              Icons.work,
              color: Colors.grey,
            )),

        onSaved: (value) => _work = value.trim(),
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