import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:eventapp/mixins/login_validator.dart';

class LoginBloc with LoginValidator {
  BuildContext context;

  final BehaviorSubject<String> _mobileNoBehaviorSubject=BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordBehaviorSubject=BehaviorSubject<String>();

  StreamSink<String> get mobileNoSink=>_mobileNoBehaviorSubject.sink;
  StreamSink<String> get passwordSink=>_passwordBehaviorSubject.sink;

  Stream<String> get mobileNoStream=>_mobileNoBehaviorSubject.stream.transform(mobileNoValidator);
  Stream<String> get passwordStream=>_passwordBehaviorSubject.stream.transform(passwordValidator);

  Stream<bool> get submitCheck=>Rx.combineLatest2(mobileNoStream, passwordStream, (email, password)=>true);





















  void dispose()  {
    _mobileNoBehaviorSubject.close();
    _passwordBehaviorSubject.close();
  }
}