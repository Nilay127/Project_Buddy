import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  const PopUp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    return AlertDialog(
      key: key,
      content: Container(
        height: screenheight / 3,
        child: Column(
          children: [
            Text(
              "Request Submitted",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
                "> You can Check your Assignment Id and status in ongoing assignment section"),
            SizedBox(
              height: 8.0,
            ),
            Text(
                "> Daily Check your Assignment status to keep yourself updated about Assignment"),
            SizedBox(
              height: 8.0,
            ),
            Text(
                "> Please send your Assignment documents and reference material along with Assignment Id through Whatsapp or Email"),
          ],
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.red,
          child: Center(
            child: Text("OK"),
          ),
        )
      ],
    );
  }
}
