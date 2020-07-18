import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:eventapp/blocs/new_post_bloc/bloc.dart';
import 'package:eventapp/utils/global.dart';
import 'package:rxdart/subjects.dart';
class NewPostBloc extends Bloc<NewPostEvent, NewPostState>  {

  NewPostBloc():super(null);
  File file;

  final BehaviorSubject<String> captionBehaviorSubject=BehaviorSubject<String>();
  Stream<String> get captionStream=>captionBehaviorSubject.stream;
  StreamSink<String> get captionStreamSink=>captionBehaviorSubject.sink;


  NewPostState get initialState=>NewPostInitialState();

  void dispose()  {
    captionBehaviorSubject?.close();
  }

  Stream<NewPostState> mapEventToState(NewPostEvent event) async*  {
    if(event is FetchPhotoEvent) {
       yield* mapFetchPostEventToState(event);  
    }
    else if(event is SubmitPostEvent)  {
      yield* mapSubmitPostEventToState(event);         
    }

    


  }
  Stream<NewPostState> mapFetchPostEventToState(FetchPhotoEvent event) async*  {
    try {
      
      yield NewPostLoadedState(file: file);
    } catch(e)  {
      yield NewPostErrorState(message: e.toString());
    } 
  } 

  Stream<NewPostState> mapSubmitPostEventToState(SubmitPostEvent event) async*  {
     try {
      

    } catch(e)  {
      print('~~~ e: ${e.toString()}');
    }  
  }
}