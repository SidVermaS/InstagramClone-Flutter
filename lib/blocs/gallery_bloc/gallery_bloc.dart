import 'dart:convert';

import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:image_gallery/image_gallery.dart';
import 'package:query_params/query_params.dart';

import 'package:eventapp/blocs/gallery_bloc/bloc.dart';
import 'package:eventapp/models/post.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState>  {

  GalleryBloc():super(null);

  GalleryState get initialState=>GalleryInitialState();

  int index=0, page=-18, limit=18;
  List uriList=List(),imagesList=List();
  AppWidgets appWidgets=AppWidgets();
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if(event is FetchGalleryEvent)  {
      try {
        Map<dynamic, dynamic>  allImageTemp= await FlutterGallaryPlugin.getAllImages;
        uriList=allImageTemp['URIList'] as List;
        uriList.reversed.toList();

        yield* mapMoreGalleryEventToState(event);
      }
      catch(e)  {
        yield GalleryErrorState(message: e.toString(), imagesList:imagesList, index: index); 
      }
    } else if(event is FetchMoreGalleryEvent) {
      
        yield* mapMoreGalleryEventToState(event);
     
    } else if(event is SelectGalleryEvent) {
        try {
          index=event.index;
          yield GalleryLoadedState(imagesList: imagesList, index: index);
      }
      catch(e)  {
        yield GalleryErrorState(message: e.toString(), imagesList:imagesList, index: index); 
      } 
    }
  }

  Stream<GalleryState> mapMoreGalleryEventToState(GalleryEvent event) async*  {
    try {
      page+=18;
      imagesList=uriList.sublist(page,limit);
      yield GalleryLoadedState(imagesList: imagesList, index: index);
    }
    catch(e)  {
      yield GalleryErrorState(message: e.toString(), imagesList:imagesList, index: index); 
    }
  }
}