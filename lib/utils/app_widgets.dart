import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';

class AppWidgets  {
  BuildContext context;

  Widget getRaisedButton(VoidCallback voidCallback, String text)  {
    return RaisedButton(
      color: Screen.eventBlue,
      child: Text(text, style: TextStyle(color: Colors.white),),
      onPressed: voidCallback,
    );
  }
}