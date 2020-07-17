import 'dart:convert';

import 'package:eventapp/blocs/explore_bloc/bloc.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/models/post.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState>  {

  ExploreBloc():super(null);

  List<Post> postsList=List<Post>();

  ExploreState get initialState=>ExploreInitialState();

  bool notLoading=true;
  int page=-1;
  URLQueryParams queryParams=URLQueryParams();

  Stream<ExploreState> mapEventToState(ExploreEvent event) async* { 
    if(event is FetchExploreEvent)  {
      if(notLoading)  {
          notLoading=false;
          try {
            page++;
             queryParams.append('page', page); 
            http.Response response=await Global.connect.sendGet('${ConstantSubUrls.post}${ConstantSubUrls.explore}?${queryParams.toString()}');
            Map<String, dynamic> mapResponse=jsonDecode(response.body);

            if(response.statusCode==200)  {
              List<dynamic> dynamicList=mapResponse['posts'] as List<dynamic>; 
              if(dynamicList.length==0) {
                page--;
              } else  {
                dynamicList.map((i)=>postsList.add(Post.fromJson(i))).toList();
              }
            } else  {     
              page--;     
              yield ExploreErrorState(message: mapResponse['message'], postsList: postsList);              
            }
             } catch(e)  {
          page--;
          yield ExploreErrorState(message: e.toString(), postsList: postsList, ); 
        }
        notLoading=true;        
      }
      yield ExploreLoadedState(postsList: postsList);
    }

  }
}