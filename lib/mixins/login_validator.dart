import 'dart:async';

import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/regex.dart';

mixin LoginValidator  {
  
  var mobileNoValidator=StreamTransformer<String, String>.fromHandlers(
    handleData: (String mobileNo, EventSink<String> sink) {
      if(Global.regex.mobileNo.hasMatch(mobileNo)) {
        sink.add(mobileNo);
      } else  { 
        sink.addError('Mobile No. should be of 10 digits only');
      }
    }
  );

  var passwordValidator=StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, EventSink<String> sink) {
      if(password.length>5 && password.length<33) {
        sink.add(password);
      } else  {
        sink.addError('Password should be between 6 and 32 characters');
      }

    }
  );
}