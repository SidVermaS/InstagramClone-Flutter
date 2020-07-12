import 'dart:async';
import 'dart:convert';

import 'package:eventapp/mixins/register_validator.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:eventapp/mixins/login_validator.dart';

class RegisterDetailsBloc with LoginValidator, RegisterValidator {
    AppWidgets appWidgets=AppWidgets();
  String mobile_no;
  final BehaviorSubject<String> _nameBehaviorSubject=BehaviorSubject<String>();
  final BehaviorSubject<String> _descriptionBehaviorSubject=BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordBehaviorSubject=BehaviorSubject<String>();

  StreamSink<String> get nameSink=>_nameBehaviorSubject.sink;
  StreamSink<String> get descriptionSink=>_descriptionBehaviorSubject.sink;
  StreamSink<String> get passwordSink=>_passwordBehaviorSubject.sink;

  Stream<String> get nameStream=>_nameBehaviorSubject.stream.transform(nameValidator);
  Stream<String> get descriptionStream=>_descriptionBehaviorSubject.stream.transform(descriptionValidator);
  Stream<String> get passwordStream=>_passwordBehaviorSubject.stream.transform(passwordValidator);

  Stream<bool> get submitCheck=>Rx.combineLatest3(nameStream, descriptionStream, passwordStream, (name, description, password)=>true);



  void registerAccount() async {
    showLoadingDialog();
    Map<String, dynamic> bodyMap=Map<String,dynamic>();
    bodyMap['mobile_no']=mobile_no;
    bodyMap['password']=_passwordBehaviorSubject.value;
    bodyMap['name']=_nameBehaviorSubject.value;
    bodyMap['role']=_descriptionBehaviorSubject.value;
    bodyMap['photo_url']=null;
    http.Response httpResponse=await Global.connect.sendPostWithouttoken('${ConstantSubUrls.register}', bodyMap);

    
    Map<String, dynamic> mapResponse=jsonDecode(httpResponse.body);

    if(httpResponse.statusCode==201)  {
       Screen.showToast(mapResponse['message']);
      Navigator.of(Screen.context).pushNamedAndRemoveUntil(Global.routes.register_success,(Route<dynamic> route)=>false);
    } else  {
      Screen.showToast(mapResponse['message']);
    }

    hideLoadingDialog();



  }

  void dispose()  {
    _nameBehaviorSubject.close();
    _descriptionBehaviorSubject.close();
    _passwordBehaviorSubject.close();
  }
}