import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:eventapp/blocs/auth_bloc/bloc.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc():super(null);


  AuthState get initialState=>AuthInitialState();


  Stream<AuthState> mapEventToState(AuthEvent event) async*  {
    if(event is AppStartedEvent)  {
       await Global.sharedPrefManager.getSharedPref();
        String userString=await Global.sharedPrefManager.getValue('user');

        if(userString==null)  {
          yield UnauthenticatedState();
        } else  {
          Global.user=User.fromJsonGlobal(jsonDecode(userString));
          yield AuthenticatedState(Global.user);
        }
    }
  }





















}