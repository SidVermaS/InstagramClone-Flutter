import 'dart:io';
import 'package:eventapp/utils/global.dart';
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
    photoBloc.add(GetAvailableCameras());
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
        child: ListView(children:<Widget>[
              Container(
               height: 45,
                child: AppBar(
                  centerTitle: false,
                leading: GestureDetector( child: Icon(Icons.close, size: 30, color: Colors.black54),onTap: ()  {
                  _onWillPop();
                },),
                title: Container(transform: Matrix4.translationValues(-5, 0,0), child: Text('Photo')),
               )),
              BlocListener<PhotoBloc, PhotoState>(
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

            return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children:<Widget>[
                // Transform.scale(
                  
                // scale: 3 / 4, // 0.5/state.cameraController.value.aspectRatio,
                // child: AspectRatio(
                //     aspectRatio: state.cameraController.value.aspectRatio,
                //     child: CameraPreview(state.cameraController)
                //   ))

                Container(
                 
                  height: Screen.height/2,
                  width: double.infinity,
                  child:  CameraPreview(state.cameraController)),

                  GestureDetector(behavior: HitTestBehavior.translucent, onTap:()  {
                    photoBloc.add(TakePhoto());
                  }, child: Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(20.0),
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300]
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                    )
                  ))
                ]);
             
              }
               return appWidgets.getCircularProgressIndicator();
        })
        ) ])
         
        
        )));
  }
}