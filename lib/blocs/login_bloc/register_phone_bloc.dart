import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:eventapp/mixins/login_validator.dart';

class RegisterPhoneBloc with LoginValidator {
  final BehaviorSubject<String> _mobileNoBehaviorSubject=BehaviorSubject<String>();

  StreamSink<String> get mobileNoSink=>_mobileNoBehaviorSubject.sink;

  Stream<String> get mobileNoStream=>_mobileNoBehaviorSubject.stream.transform(mobileNoValidator);

  Stream<bool> get submitCheck=>Rx.combineLatest([mobileNoStream], (mobileNo)=>true);



  void registerMobileNoExists() async {












  }





  void dispose()  {
    _mobileNoBehaviorSubject.close();
  }
}