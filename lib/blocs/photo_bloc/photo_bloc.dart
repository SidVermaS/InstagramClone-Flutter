import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:eventapp/blocs/new_post_bloc/bloc.dart';
import 'package:eventapp/screens/new_post.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:eventapp/blocs/photo_bloc/bloc.dart';
import 'package:eventapp/utils/global.dart';
class PhotoBloc extends Bloc<PhotoEvent, PhotoState>  {

  PhotoBloc():super(null);

  PhotoState get initialState=>CameraInitialState();

  CameraController cameraController; 
  List<CameraDescription> cameraDescriptionsList;
  void dispose()  {
    cameraController?.dispose();
  }

  Stream<PhotoState> mapEventToState(PhotoEvent event) async*  {
    if(event is GetAvailableCameras) {
      cameraDescriptionsList=await availableCameras();
       yield* mapGetCameraEventToState(0);  
    }
    else if(event is GetCamera)  {
      yield* mapGetCameraEventToState(event.camera);         
    } else if(event is TakePhoto) {
      yield* mapTakePhotoEventToState(event);
    }

    


  }
  Stream<PhotoState> mapGetCameraEventToState(int camera) async*  {
    try {
      cameraController=CameraController(cameraDescriptionsList[camera], ResolutionPreset.medium);
      await cameraController.initialize();
      
      yield CameraLoadedState(cameraController: cameraController);
    } catch(e)  {
      yield CameraErrorState(message: e.toString());
    } 
  } 

  Stream<PhotoState> mapTakePhotoEventToState(TakePhoto event) async*  {
     try {
      Directory directory=await getApplicationDocumentsDirectory();
      String directoryPath='${directory.path}/uploads';
      await Directory(directoryPath).create(recursive: true);
      String filePath='${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    
      await cameraController.takePicture(filePath);
      navigateToNewPost(filePath);
     } catch(e)  {
      print('~~~ e: ${e.toString()}');
      yield TakePhotoErrorState(message: e.toString(), cameraController: cameraController);
    }  
  }
  void navigateToNewPost(String filePath) async  {
    BuildContext previousContext=Screen.context;
    await Screen.navigateAndRefresh(BlocProvider(create:(context)=>NewPostBloc(), child: NewPost(file: File(filePath))));
    Screen.context=previousContext;      
  }
}