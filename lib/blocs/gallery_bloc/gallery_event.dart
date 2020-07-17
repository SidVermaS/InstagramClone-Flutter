import 'package:equatable/equatable.dart';

abstract class GalleryEvent extends Equatable {


}

class FetchGalleryEvent extends GalleryEvent {

  int index;

  FetchGalleryEvent({this.index});

  List<Object> get props=>[index];

}




