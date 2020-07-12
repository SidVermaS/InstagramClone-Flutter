import 'package:eventapp/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Profile extends StatelessWidget{
  Widget build(BuildContext context)  {
    return Scaffold(
      body:Center(child: RaisedButton(child: Text('logout'),onPressed: () {
        Global.sharedPrefManager.removeAll();
        Phoenix.rebirth(context);
      },))
    );
  }
}