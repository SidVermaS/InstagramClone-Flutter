import 'dart:convert';

import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:query_params/query_params.dart';

import 'package:eventapp/blocs/home_bloc/home_event.dart';
import 'package:eventapp/blocs/home_bloc/home_state.dart';
import 'package:eventapp/models/post.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc():super(null);

  HomeState get initialState=>HomeInitialState(); 

  Stream<HomeState> mapEventToState(HomeEvent event) async* {

    if(event is FetchHomeEvent)  { 
      try {
        event.page=event.page+=1;
        URLQueryParams queryParams=URLQueryParams();
        queryParams.append('page', event.page);
        queryParams.append('user_id', event.user_id);
        http.Response response=await Global.connect.sendGet('${ConstantSubUrls.post}?${queryParams.toString()}');
        Map<String, dynamic> mapResponse=jsonDecode(response.body);

        if(response.statusCode==200)  {
          List<dynamic> dynamicList=mapResponse['posts'] as List<dynamic>; 
          List<Post> postsList=List<Post>(); 

          dynamicList.map((i)=>postsList.add(Post.fromJson(i)));
          if(event.page==0) {
            yield HomeLoadedState(postsList: postsList);
          } else  {
            yield HomeMoreLoadedState(postsList: postsList);
          }
        } else  {
          yield HomeErrorState(message: mapResponse['message']);
        }
      } catch(e)  {
        yield HomeErrorState(message: e.toString()); 
      }
    }
  }
}






