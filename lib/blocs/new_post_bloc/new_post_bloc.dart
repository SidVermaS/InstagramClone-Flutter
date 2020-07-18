import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eventapp/networks/connect.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load/load.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:eventapp/blocs/new_post_bloc/bloc.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:query_params/query_params.dart';
import 'package:rxdart/subjects.dart';
class NewPostBloc extends Bloc<NewPostEvent, NewPostState>  {

  NewPostBloc():super(null);
  File file;
  Connect _connect=Connect();
  URLQueryParams queryParams=URLQueryParams();  
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
      showLoadingDialog();
      yield* mapSubmitPostEventToState(event);  
      hideLoadingDialog();       
    }

    


  }
  Stream<NewPostState> mapFetchPostEventToState(FetchPhotoEvent event) async*  {
    try {
      file=event.file;
      yield NewPostLoadedState(file: file);
    } catch(e)  {
      yield NewPostErrorState(message: e.toString());
    } 
  } 

  Stream<NewPostState> mapSubmitPostEventToState(SubmitPostEvent event) async*  {
     try {
       queryParams.append('file_type', 'posts');
      Response<dynamic> response=await _connect.sendFormDataPostRequest('${ConstantSubUrls.upload}?${queryParams.toString()}', file);
      Screen.showToast(response.data.toString());
        //  if(response.statusCode==201)  {
        //    Screen.showToast(response['message']);
        //  }else {
        //    Screen.showToast(mapResponse['message'].toString());
        //   }
      

    } catch(e)  {
      print('~~~  err: ${e.toString()}');
      yield SubmittedErrorState(message: e.toString());
    }  
  }
}