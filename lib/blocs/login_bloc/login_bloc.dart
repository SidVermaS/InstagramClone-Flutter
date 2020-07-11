import 'dart:async';

import 'package:rxdart/rxdart.dart';

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

  Stream<bool> get submitCheck=>Rx.combineLatest2(mobileNoStream, passwordStream, (email, password)=>true);





















  void dispose()  {
    _mobileNoBehaviorSubject.close();
    _passwordBehaviorSubject.close();
    // _isVisibleStreamController.close();
  }
}