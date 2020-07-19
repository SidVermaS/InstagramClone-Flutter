import 'dart:convert';

import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:query_params/query_params.dart';

import 'package:eventapp/blocs/home_bloc/bloc.dart';
import 'package:eventapp/models/post.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc():super(null);
  
  HomeState get initialState=>HomeInitialState(); 

  bool notLoading=true;
  int page=-1, user_id=Global.user.user_id;
  List<Post> postsList=List<Post>(); 
  Map<String, dynamic> bodyMap;
  URLQueryParams queryParams=URLQueryParams();
  Stream<HomeState> mapEventToState(HomeEvent event) async* {   
      
      if(event is FetchHomeEvent)  { 
        if(notLoading)  {
          notLoading=false;
          try {
            page++;
            queryParams=URLQueryParams();
            queryParams.append('page', page);
            queryParams.append('user_id', user_id);
            http.Response response=await Global.connect.sendGet('${ConstantSubUrls.post}?${queryParams.toString()}');
            Map<String, dynamic> mapResponse=jsonDecode(response.body);
    
            if(response.statusCode==200)  {
              List<dynamic> dynamicList=mapResponse['posts'] as List<dynamic>; 
              
              dynamicList.map((i)=>postsList.add(Post.fromJsonHome(i))).toList();
              if(dynamicList.length==0) {
                page--;
              }
              if(page==0) {
                yield HomeLoadedState(postsList: postsList);
              } else  {
                yield HomeMoreLoadedState(postsList: postsList);
              }
            } else  {     
              page--;     
              yield HomeErrorState(message: mapResponse['message'], postsList: postsList);
              
            }
          } catch(e)  {
            page--;
            yield HomeErrorState(message: e.toString(), postsList:postsList); 
          }
        notLoading=true;
        }
      } else if(event is ModifyFavoriteEvent) {
        yield* mapModifyEventToState(event);
      } else if(event is ModifyCommentsCountEvent) {
        yield* mapModifyCommentsCountEventToState(event);
      }
  }

  Stream<HomeState> mapModifyEventToState(ModifyFavoriteEvent event) async* {
        
        try {
          postsList[event.index].status=postsList[event.index].status=='like'?'remove':'like';
         if(postsList[event.index].status=='like')  {
           postsList[event.index].reactions_count++;
         }  else  {
           postsList[event.index].reactions_count--;
         }
          yield HomeMoreLoadedState(postsList: postsList);

          bodyMap=Map<String, dynamic>();
          bodyMap['post_id']=postsList[event.index].post_id;
          bodyMap['user_id']=Global.user.user_id;
          bodyMap['status']=postsList[event.index].status;
          http.Response response=await Global.connect.sendPatch('${ConstantSubUrls.reaction}', bodyMap);
          Map<String, dynamic> mapResponse=jsonDecode(response.body);
  
          if(response.statusCode==200)  {
            
          } else  {   

            yield HomeErrorState(message: mapResponse['message'], postsList: postsList);
            
          }
        } catch(e)  {
          yield HomeErrorState(message: e.toString(), postsList:postsList); 
        }
  }
    Stream<HomeState> mapModifyCommentsCountEventToState(ModifyCommentsCountEvent event) async* {
        
        try {
          if(postsList[event.index].comments_count!=event.comments_count) {
            postsList[event.index].comments_count=event.comments_count;
            yield HomeMoreLoadedState(postsList: postsList);
          }
        } catch(e)  {
          yield HomeErrorState(message: e.toString(), postsList:postsList); 
        }
  }
}