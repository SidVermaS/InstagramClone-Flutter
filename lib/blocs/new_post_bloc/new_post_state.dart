import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class NewPostState {

}

class NewPostInitialState extends NewPostState  {

  List<Object> get props=>[];

}

class NewPostLoadedState extends NewPostState {
  File file;
  NewPostLoadedState({this.file,});
  List<Object> get props=>[file];
}

class NewPostErrorState extends NewPostState {
  String message;
  NewPostErrorState({this.message});
  List<Object> get props=>[message];
}

class SubmittedState extends NewPostState {
  String message;

  SubmittedState({this.message});

  List<Object> get props=>[message];
}
class SubmittedErrorState extends NewPostState {
  String message;

  SubmittedErrorState({this.message});

  List<Object> get props=>[message];
}
































