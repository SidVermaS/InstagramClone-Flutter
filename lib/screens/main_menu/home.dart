import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _HomeState createState()=>_HomeState();
}

class _HomeState extends State<Home>{
  Widget build(BuildContext context)  {
    return Scaffold(
      body: Center(child: RaisedButton(child: Text('logout'),onPressed: () {
        Global.sharedPrefManager.removeAll();
        
      },))
    );
  }
}