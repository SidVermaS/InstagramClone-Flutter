import 'dart:convert';

import 'package:eventapp/blocs/users_bloc/bloc.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';


class UsersBloc extends Bloc<UsersEvent, UsersState>  { 
  List<User> usersList=List<User>(); 

  UsersBloc():super(null);

  UsersState get initialState=>UsersInitialState();

  bool notLoading=true;
  int page=-1;
  URLQueryParams queryParams=URLQueryParams();

  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if(event is FetchUsersEvent)  {
      if(notLoading)  {
          notLoading=false;
          try {
            page++;
            queryParams.append('page', page);
            http.Response response=await Global.connect.sendGet('${ConstantSubUrls.user}?${queryParams.toString()}');
            Map<String, dynamic> mapResponse=jsonDecode(response.body);

            if(response.statusCode==200)  {
              List<dynamic> dynamicList=mapResponse['users'] as List<dynamic>; 
              if(dynamicList.length==0) {
                page--;
              } else  {
                dynamicList.map((i)=>usersList.add(User.fromJson(i))).toList();
              }
            } else  {     
              page--;     
              yield UsersErrorState(message: mapResponse['message'], usersList: usersList);              
            }
          } catch(e)  {
          page--;
          yield UsersErrorState(message: e.toString(), usersList: usersList); 
        }
        notLoading=true;        
      }
      yield UsersLoadedState(usersList: usersList);
    }
  }




}