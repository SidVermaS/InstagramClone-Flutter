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
              yield PostsErrorState(message: mapResponse['message'], postsList: postsList);              
            }
             } catch(e)  {
          page--;
          yield PostsErrorState(message: e.toString(), postsList: postsList); 
        }
        notLoading=true;        
      }
      yield PostsLoadedState(postsList: postsList);
    }
    else if(event is FetchProfileEvent) {
      yield* mapProfileEventToState(event); 
    }
  }

  Stream<ProfileState> mapProfileEventToState(ProfileEvent event) async*  {
    try {
      http.Response response=await Global.connect.sendGet('${ConstantSubUrls.user}?${user.user_id}');
      Map<String, dynamic> mapResponse=jsonDecode(response.body);
      if(response.statusCode==200)  {
        user=User.fromJsonProfile(mapResponse['user']);    
      } else  {      
        yield ProfileErrorState(message: mapResponse['message'], user: user);              
      }















    } catch(e)  {
      yield ProfileErrorState(message: e.toString(), user: user); 
    }
  }
}