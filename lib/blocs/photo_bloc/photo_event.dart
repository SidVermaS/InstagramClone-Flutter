abstract class PhotoEvent {

}
class GetAvailableCameras extends PhotoEvent  {
   int camera;
  GetAvailableCameras({this.camera});

  List<Object> get props=>null;

}
class GetCamera extends PhotoEvent  {
  int camera;
  GetCamera({this.camera});

  List<Object> get props=>null;

}

class TakePhoto extends PhotoEvent  {

  TakePhoto();

  List<Object> get props=>null;

}