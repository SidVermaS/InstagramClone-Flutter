import 'dart:convert';

import 'package:eventapp/networks/constant_sub_urls.dart';
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

  int index=0;
  List<Object> imagesList=List<Object>();

  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if(event is FetchGalleryEvent)  {
      try {
        index=event.index;
        print('~~~ imagesList: ${imagesList.length} ');
        imagesList = await FlutterGallaryPlugin.getAllImages;
          print('~~~ imagesList: ${imagesList.length} ');
        yield GalleryLoadedState(imagesList: imagesList, index: index);
      }
      catch(e)  {
           print('~~~ err: imagesList: ${e.toString()} ');
        yield GalleryErrorState(message: e.toString(), imagesList:imagesList, index: index); 
      }
    }
  }
}