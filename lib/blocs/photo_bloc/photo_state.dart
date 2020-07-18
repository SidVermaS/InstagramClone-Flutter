import 'package:camera/camera.dart';

abstract class PhotoState {

}

class CameraInitialState extends PhotoState  {
  List<Object> get props=>[];
}

class CameraLoadedState extends PhotoState  {
  CameraController cameraController;
  CameraLoadedState({this.cameraController});
  
  List<Object> get props=>[cameraController];
}

class CameraErrorState extends PhotoState {
  String message;

  CameraErrorState({this.message});

  List<Object> get props=>[message];
}
class TakePhotoErrorState extends PhotoState {
  String message;
    CameraController cameraController;
  TakePhotoErrorState({this.message,this.cameraController});

  List<Object> get props=>[message, cameraController];
}