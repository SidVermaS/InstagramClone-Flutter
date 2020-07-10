import 'dart:async';

import 'package:eventapp/utils/regex.dart';

mixin LoginValidator  {
  
  var mobileNoValidator=StreamTransformer<String, String>.fromHandlers(
    handleData: (String mobileNo, EventSink<String> sink) {
      if(Regex.mobileNo.hasMatch(mobileNo)) {
        sink.add(mobileNo);
      } else  { 
        sink.add('Mobile No. should be of 10 digits only');
      }
    }
  );

  var passwordValidator=StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, EventSink<String> sink) {
      if(password.length>7 && password.length<33) {
        sink.add(password);
      } else  {
        sink.add('Password should be between 8 and 32 characters');
      }

    }
  );
}