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
      body:
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _showBioInput(),
            _showLocationInput(),
            _showWorkInput(),
            RaisedButton(
              child: Text("Choose interests"),
              onPressed: () => _showReportDialog(),
            ),
//            Text(selectedInterestsList.join(" , ")),
            _buildInterests()
          ],
        ),
      )
    );
  }

  Widget _showBioInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
//        obscureText: true,
        autofocus: false,


        decoration: new InputDecoration(
            labelText: 'Bio',
//            ),
            icon: new Icon(
        Icons.assignment,
        color: Colors.grey,
      )),
//        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _bio = value.trim(),
      ),
    );
  }

  Widget _showLocationInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
//        keyboardType: TextInputType.multiline,
        maxLines: 1,
//        obscureText: true,
        autofocus: false,


        decoration: new InputDecoration(
            labelText: 'Location',
//            ),
            icon: new Icon(
              Icons.place,
              color: Colors.grey,
            )),
//        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _location = value.trim(),
      ),
    );
  }


  Widget _showWorkInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
//        keyboardType: TextInputType.multiline,
        maxLines: 1,
//        obscureText: true,
        autofocus: false,


        decoration: new InputDecoration(
            labelText: 'Work',
//            ),
            icon: new Icon(
              Icons.work,
              color: Colors.grey,
            )),
//        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _work = value.trim(),
      ),
    );
  }

  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Choose Interests"),
            content: MultiSelectChip(
              reportList,
              previousSelected: selectedInterestsList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedInterestsList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Submit"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
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