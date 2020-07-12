import 'package:eventapp/blocs/register_bloc/register_phone_bloc.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            margin: EdgeInsets.fromLTRB(0,0,0,0),
            // padding: EdgeInsets.fromLTRB(48,15,48,15),
            child: Image.asset('assets/images/tick_round.png',), ),
            Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child:Text('Successfully registered', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
           appWidgets.getRaisedButton((){
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pushNamedAndRemoveUntil(Global.routes.login, (Route<dynamic> route)=>false);
                }, 'Continue')
        ])
      ),
    );
  }
}