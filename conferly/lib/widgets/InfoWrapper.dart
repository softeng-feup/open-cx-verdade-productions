import 'package:flutter/widgets.dart';

class InfoWrapper extends StatelessWidget {

  InfoWrapper({this.text, this.icon, this.bg});

  final String text;
  final Icon icon;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
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