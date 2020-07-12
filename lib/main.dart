import 'package:badges/badges.dart';
import 'package:eventapp/screens/main_menu/home.dart';
import 'package:eventapp/screens/main_menu/index.dart';
import 'package:eventapp/screens/login.dart';
import 'package:eventapp/screens/register/register_details.dart';
import 'package:eventapp/screens/register/register_phone.dart';
import 'package:eventapp/screens/register/register_success.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:load/load.dart';

import 'blocs/auth_bloc/bloc.dart';



void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home:LoadingProvider(child: Phoenix(
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Screen.eventGrey,
        primaryColorDark: Screen.eventBlue
      ),
      title: 'Instagram',
      home: BlocProvider(
        create: (context)=>AuthBloc()..add(AppStartedEvent()),
        child: App(),

      ),     
      routes: {
        Global.routes.login:(context)=> Login(),
        Global.routes.register_phone:(context)=> RegisterPhone(),
        Global.routes.register_details:(context)=> RegisterDetails(),
        Global.routes.register_success:(context)=> RegisterSuccess(),
        Global.routes.index:(context)=> Index(),
      },
    ))));
  }
}

class App extends StatelessWidget {

  Widget build(BuildContext context)  {
    return BlocBuilder<AuthBloc, AuthState> (
      builder: (context, state) {
        if(state is AuthInitialState) {
          return Scaffold(body:Container(child:Center(child: CircularProgressIndicator(),)));
        } else if(state is AuthenticatedState)  {
          return Index();
        } else if(state is UnauthenticatedState)  {
          return Login();
        }
        return Scaffold(body:Container(child:Center(child: CircularProgressIndicator(),)));
      }
    );
  }
}
























