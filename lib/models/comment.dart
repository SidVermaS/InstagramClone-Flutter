import 'package:eventapp/models/user.dart';

class Comment {

  int comment_id, post_id;

  String comment_text;
  User user;
  Comment({this.comment_id, this.comment_text, this.post_id, this.user});

  Comment.fromJson(Map<String, dynamic> map) {
    post_id=map['post_id'];
    user=User.fromJsonComment(map['user']);
    comment_id=map['comment_id'];
    comment_text=map['comment_text'];
  }

  Map<String, dynamic> toJsonAdd()  {
     return  {
      'user_id': user.user_id,
      'post_id': post_id,
      'comment_text': comment_text,
    };
  }















}