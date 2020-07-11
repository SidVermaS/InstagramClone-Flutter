import 'package:badges/badges.dart';
import 'package:eventapp/screens/login.dart';
import 'package:eventapp/screens/register/register_phone.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    //  Screen.height=MediaQuery.of(context).size.height;
    //  Screen.width=MediaQuery.of(context).size.width;
  
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Screen.eventGrey,
        primaryColorDark: Screen.eventBlue
      ),
      title: 'Instagram',
      home: Login(),
      debugShowCheckedModeBanner: false,
      routes: {
        Global.routes.login:(context)=> Login(),
        Global.routes.register_phone:(context)=> RegisterPhone(),
      },
    );
  }
}








































