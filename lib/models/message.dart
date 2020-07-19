import 'package:eventapp/models/user.dart';

class Message  {
  String message_text;
  User user;
  Message({this.message_text, this.user});
  Message.fromJson(Map<String, dynamic> map)  {
    message_text=map['message_text'];
    user=User.fromJson(map['user']);
  }
   Map<String, dynamic> toJson() {
    return  {
      'message_text': message_text,
      'user': user.toJsonDetails()
    };
  }
}