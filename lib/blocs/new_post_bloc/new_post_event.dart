import 'dart:io';

abstract class NewPostEvent {


}

class FetchPhotoEvent extends NewPostEvent  {
  File file;
  FetchPhotoEvent({this.file});

  List<Object> get props=>[file];
}

class SubmitPostEvent extends NewPostEvent  {
  SubmitPostEvent();
  List<Object> get props=>null;
}



































