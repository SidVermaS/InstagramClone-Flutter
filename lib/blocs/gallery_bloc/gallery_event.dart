import 'package:equatable/equatable.dart';

abstract class GalleryEvent {


}

class FetchGalleryEvent extends GalleryEvent {

  int index;

  FetchGalleryEvent({this.index});

  List<Object> get props=>[index];

}
class FetchMoreGalleryEvent extends GalleryEvent {
  FetchMoreGalleryEvent();

  List<Object> get props=>[];

}
class SelectGalleryEvent extends GalleryEvent {

  int index;

  SelectGalleryEvent({this.index});

  List<Object> get props=>[index];

}



