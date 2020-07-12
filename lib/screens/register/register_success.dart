import 'package:eventapp/blocs/register_bloc/register_phone_bloc.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterSuccess extends StatefulWidget  {
  _RegisterSuccessState createState()=>_RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  AppWidgets appWidgets=AppWidgets();
  void initState()  {
    super.initState();
    appWidgets.context=context;
     Screen.context=context;
  
  
  }
   void dispose()  {
    super.dispose();
  }
  Widget build(BuildContext context)  {

    return Scaffold(
      body: Container(
         padding: EdgeInsets.fromLTRB(22,0,22,0),
        child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0,60,0,0),
            // padding: EdgeInsets.all(48),
            child: Icon(FontAwesomeIcons.checkCircle, size: 200,)),
        
            Container(
                  margin: EdgeInsets.fromLTRB(0, 60, 0, 20),
                  child:Text('Successfully registered', style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
           appWidgets.getRaisedButton((){
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pushNamedAndRemoveUntil(Global.routes.login, (Route<dynamic> route)=>false);
                }, 'Continue')
        ])
      ),
    );
  }
}