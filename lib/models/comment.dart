class Comment {

  int comment_id, post_id, user_id;

  String comment_text;

  Comment({this.comment_id, this.comment_text, this.post_id, this.user_id});

  Comment.fromJson(Map<String, dynamic> map) {
    post_id=map['post_id'];
    user_id=map['user_id'];
    comment_id=map['comment_id'];
    comment_text=map['comment_text'];
  }

  Map<String, dynamic> toJsonAdd()  {
     return  {
      'user_id': user_id,
      'post_id': post_id,
      'comment_text': comment_text,
    };
  }















}