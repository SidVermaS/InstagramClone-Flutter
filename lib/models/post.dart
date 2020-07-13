class Post  {
  int post_id, user_id, reactions_count, comments_count;
  String caption, photo_url, status;

  Post.fromJson(Map<String, dynamic> map) {
    post_id=map['post_id'];
    user_id=map['user_id'];
    reactions_count=map['reactions_count'];
    comments_count=map['comments_count'];
    caption=map['caption'];
    photo_url=map['photo_url'];
    status=map['status'];
  }









}










