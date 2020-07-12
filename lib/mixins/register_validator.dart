
import 'dart:async';

import 'package:eventapp/utils/global.dart';

mixin RegisterValidator {
  var nameValidator=StreamTransformer<String, String>.fromHandlers(
    handleData: (String name, EventSink<String> sink) {
      if(Global.regex.name.hasMatch(name))  {
        sink.add(name);
      } else  {
        sink.addError('Name can be alphabets between the length of 3 and 32');
      }
    }
  );
  var descriptionValidator=StreamTransformer<String, String>.fromHandlers(
    handleData: (String description, EventSink<String> sink) {
      if(description.length>2 && description.length<101)  {
        sink.add(description);
      } else  {
        sink.addError('Description can be characters between the length of 3 and 100');
      }
    }
  );





























}