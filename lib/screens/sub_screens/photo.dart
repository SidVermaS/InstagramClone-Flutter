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
  VoidCallback backVoidCallback;
  Photo({this.backVoidCallback});
  _PhotoState createState()=>_PhotoState(backVoidCallback: backVoidCallback);
} 

class _PhotoState extends State<Photo>  {
  VoidCallback backVoidCallback;
  _PhotoState({this.backVoidCallback});
  PhotoBloc photoBloc;
  void initState()  {
    super.initState();
   
    Screen.context=context;
    photoBloc=BlocProvider.of<PhotoBloc>(context);
    photoBloc.appWidgets.context=context;
    photoBloc.add(GetAvailableCameras());
  }
  void dispose()  {
    super.dispose();
    photoBloc.close();
  }
  Widget build(BuildContext context)  {
    return 
    WillPopScope(
      onWillPop: ()async=>false,
      child: 
      Scaffold(
      body: Container(
        child: ListView(children:<Widget>[
              Container(
               height: 45,
                child: AppBar(
                  centerTitle: false,
                leading: GestureDetector( child: Icon(Icons.close, size: 30, color: Colors.black54),onTap: ()  {
                  backVoidCallback();
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
            return showCamera(state.cameraController);          
          } else if(state is TakePhotoErrorState)  {
            return showCamera(state.cameraController);
          }
          return photoBloc.appWidgets.getCircularProgressIndicator();
        })
        ) ])
         
        )
        )
        );
  }
  Widget showCamera(CameraController cameraController)  {
      return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children:<Widget>[
                Container(
                 
                  height: Screen.height/2,
                  width: double.infinity,
                  child:  CameraPreview(cameraController)),

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
}