import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:eventapp/blocs/photo_bloc/bloc.dart';
import 'package:eventapp/utils/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      GetCamera();
    }
    else if(event is GetCamera)  {
      yield* mapGetCameraEventToState(event);         
    } else if(event is TakePhoto) {
      yield *mapTakePhotoEventToState(event);
    }

    


  }
  Stream<PhotoState> mapGetCameraEventToState(GetCamera event) async*  {
    try {
      cameraController=CameraController(cameraDescriptionsList[event.camera], ResolutionPreset.medium);
      await cameraController.initialize();
      
      yield CameraLoadedState(cameraController: cameraController);
    } catch(e)  {
      yield CameraErrorState(message: e.toString());
    } 
  } 

  Stream<PhotoState> mapTakePhotoEventToState(TakePhoto event) async*  {
     try {
        String filePath='${DateTime.now().millisecondsSinceEpoch}.jpg';
      
        await cameraController.takePicture(filePath);
      
      

















    } catch(e)  {
      yield TakePhotoErrorState(message: e.toString());
    }  
  }
}