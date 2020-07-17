import 'package:equatable/equatable.dart';

abstract class GalleryState extends Equatable  {


}

class GalleryInitialState extends GalleryState  {

  List<Object> get props=>[];
}

class GalleryLoadedState extends GalleryState {
  List<Object> imagesList;
  int index;
  GalleryLoadedState({this.imagesList,this.index});

  List<Object> get props=>[imagesList,index];

}

class GalleryErrorState extends GalleryState  {
  String message;
  List<Object> imagesList;
  int index;
  GalleryErrorState({this.message, this.imagesList, this.index});

  List<Object> get props=>[message, imagesList, index];


}