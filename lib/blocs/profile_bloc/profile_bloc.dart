import 'dart:convert';

import 'package:eventapp/blocs/profile_bloc/bloc.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/models/post.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>  {

  ProfileBloc({this.user}):super(null);
  User user;
  List<Post> postsList=List<Post>();

  ProfileState  get profileInitialState=>ProfileInitialState();

  bool notLoading=true;
  int page=-1;
  URLQueryParams queryParams=URLQueryParams();

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
   
    if(event is FetchPostsEvent)  {
      if(notLoading)  {
          notLoading=false;
          try {
            page++;
             queryParams.append('page', page); 
             queryParams.append('user_id', user.user_id);
            http.Response response=await Global.connect.sendGet('${ConstantSubUrls.post}${ConstantSubUrls.user}?${queryParams.toString()}');
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
              yield ProfileErrorState(message: mapResponse['message'], postsList: postsList, user: user);              
            }
             } catch(e)  {
          page--;
          yield ProfileErrorState(message: e.toString(), postsList: postsList, user: user); 
        }
        notLoading=true;        
      }
      yield ProfileLoadedState(postsList: postsList, user: user);
    }
    else if(event is FetchProfileEvent) {
      yield* mapProfileEventToState(event); 
    }
  }

  Stream<ProfileState> mapProfileEventToState(ProfileEvent event) async*  {
    try {
      http.Response response=await Global.connect.sendGet('${ConstantSubUrls.user}${user.user_id}');
      Map<String, dynamic> mapResponse=jsonDecode(response.body);
      if(response.statusCode==200)  {
         print('~~~ 1 mes: ${(mapResponse['user'])}'); 
        user=User.fromJsonProfile(mapResponse['user']);   
         print('~~~ 2 mes: ${user.toJsonGlobal()} rc: ${user.reactions_count}'); 
      } else  {      
        yield ProfileErrorState(message: mapResponse['message'], user: user, postsList: postsList);              
      }
    } catch(e)  {
      yield ProfileErrorState(message: e.toString(), user: user, postsList: postsList); 
    }
    yield ProfileLoadedState(user: user, postsList: postsList);
  }
}