import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';

import 'package:eventapp/blocs/photo_bloc/bloc.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:eventapp/utils/app_widgets.dart';

class Photo extends StatefulWidget  {
  _PhotoState createState()=>_PhotoState();
} 

class _PhotoState extends State<Photo>  {
  AppWidgets appWidgets=AppWidgets();
  PhotoBloc photoBloc;
  void initState()  {
    super.initState();
    appWidgets.context=context;
    Screen.context=context;
    photoBloc=BlocProvider.of<PhotoBloc>(context);
    photoBloc.add(GetCamera(camera: 0));
  }
  void dispose()  {
    super.dispose();
    photoBloc.close();
  }
  Future<bool> _onWillPop() async {
    return true;
  }
  Widget build(BuildContext context)  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      body: Container(
        child: BlocListener<PhotoBloc, PhotoState>(
        listener: (BuildContext context, PhotoState state)  {
          if(state is CameraErrorState)  {
            Screen.showToast(state.message);
          } else if(state is TakePhotoErrorState)  {
            Screen.showToast(state.message);
          }
        },
        child: BlocBuilder<PhotoBloc, PhotoState>  ( 
        builder: (context, state) { 
          if(state is CameraLoadedState) {

            return ListView(children:<Widget>[
              Container(
               height: 45,
                child: AppBar(
                  centerTitle: false,
                leading: GestureDetector( child: Icon(Icons.close, size: 30, color: Colors.black54),onTap: ()  {
                  _onWillPop();
                },),
                title: Container(transform: Matrix4.translationValues(-25, 0,0), child: Text('Photo')),
                actions: <Widget>[FlatButton(onPressed: () {

              },child: Text('Next', style: TextStyle(color: Screen.eventBlue, fontSize: 16.5)))],)),
              Container(child: AspectRatio(
                aspectRatio: state.cameraController.value.aspectRatio,
                child: CameraPreview(state.cameraController)
              ))
              
              ]);
          }
          return appWidgets.getCircularProgressIndicator();
        })))));
  }
}