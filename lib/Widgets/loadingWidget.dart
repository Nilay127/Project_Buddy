import 'package:flutter/material.dart';
import 'package:project_app/Widgets/color.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color2),
    ),
  );
}

linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
    ),
  );
}
