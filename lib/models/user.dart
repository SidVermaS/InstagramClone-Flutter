class User  {
  String mobile_no,name, role,photo_url,token;
  int user_id;

  User.fromJson(Map<String, dynamic> map) {
    user_id=map['user_id'];
    mobile_no=map['mobile_no'];
    name=map['name'];
    role=map['role'];
    photo_url=map['photo_url'];
    token="bearer ${map['token']}";
  }


}