import 'dart:async';
import 'dart:convert';

import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:eventapp/mixins/login_validator.dart';

class RegisterPhoneBloc with LoginValidator {
  AppWidgets appWidgets=AppWidgets();
  final BehaviorSubject<String> _mobileNoBehaviorSubject=BehaviorSubject<String>();

  StreamSink<String> get mobileNoSink=>_mobileNoBehaviorSubject.sink;

  Stream<String> get mobileNoStream=>_mobileNoBehaviorSubject.stream.transform(mobileNoValidator);

  Stream<bool> get submitCheck=>Rx.combineLatest([mobileNoStream], (mobileNo)=>true);



  void verifyMobileNoExists() async {
    showLoadingDialog();
    Map<String, dynamic> bodyMap=Map<String,dynamic>();
    bodyMap['mobile_no']=_mobileNoBehaviorSubject.value;
    http.Response httpResponse=await Global.connect.sendPostWithouttoken('${ConstantSubUrls.register}${ConstantSubUrls.exists}', bodyMap);

    
    Map<String, dynamic> mapResponse=jsonDecode(httpResponse.body);

    if(httpResponse.statusCode==200)  {
       Screen.showToast(mapResponse['message']);
      Navigator.of(Screen.context).pushNamed(Global.routes.register_details, arguments: <String, dynamic>{ 'mobile_no': _mobileNoBehaviorSubject.value });
    } else  {
      Screen.showToast(mapResponse['message']);
    }
    hideLoadingDialog();




  }





  void dispose()  {
    _mobileNoBehaviorSubject.close();
  }
}