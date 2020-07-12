import 'dart:async';
import 'dart:convert';

import 'package:eventapp/models/user.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:eventapp/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:eventapp/mixins/login_validator.dart';

class LoginBloc with LoginValidator {
  final BehaviorSubject<String> _mobileNoBehaviorSubject=BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordBehaviorSubject=BehaviorSubject<String>();
  // final StreamController<bool> _isVisibleStreamController=StreamController<bool>();

  StreamSink<String> get mobileNoSink=>_mobileNoBehaviorSubject.sink;
  StreamSink<String> get passwordSink=>_passwordBehaviorSubject.sink;
  // StreamSink<bool> get isVisibleSink=>_isVisibleStreamController.sink;

  Stream<String> get mobileNoStream=>_mobileNoBehaviorSubject.stream.transform(mobileNoValidator);
  Stream<String> get passwordStream=>_passwordBehaviorSubject.stream.transform(passwordValidator);
  // Stream<bool> get isVisibleStream=>_isVisibleStreamController.stream;

  Stream<bool> get submitCheck=>Rx.combineLatest2(mobileNoStream, passwordStream, (mobileNo, password)=>true);

   void loginAccount() async {
    showLoadingDialog();
    Map<String, dynamic> bodyMap=Map<String,dynamic>();
    bodyMap['mobile_no']=_mobileNoBehaviorSubject.value;
    bodyMap['password']=_passwordBehaviorSubject.value;
    http.Response httpResponse=await Global.connect.sendPostWithouttoken('${ConstantSubUrls.login}', bodyMap);

    
    Map<String, dynamic> mapResponse=jsonDecode(httpResponse.body);

    if(httpResponse.statusCode==200)  {
      Screen.showToast(mapResponse['message']);
      Global.user=User.fromJsonLogin(mapResponse['user']);
      await Global.sharedPrefManager.getSharedPref();
      bool result=await Global.sharedPrefManager.setValue('user', jsonEncode(Global.user.toJsonGlobal()));
      if(result)  {
        Navigator.of(Screen.context).pushNamedAndRemoveUntil(Global.routes.index,(Route<dynamic> route)=>false);
      }
      else  {
        Screen.showToast('Failed to login');
      } 
    } else  {
      Screen.showToast(mapResponse['message']);
    }

    hideLoadingDialog();



  }




















  void dispose()  {
    _mobileNoBehaviorSubject.close();
    _passwordBehaviorSubject.close();
    // _isVisibleStreamController.close();
  }
}