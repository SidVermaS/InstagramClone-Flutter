class User  {
  String mobile_no,name, role,photo_url,token;
  int user_id;
  User({this.user_id, this.name, this.photo_url});
  User.fromJsonGlobal(Map<String, dynamic> map) {
    user_id=map['user_id'];
    mobile_no=map['mobile_no'].toString();
    name=map['name'];
    role=map['role'];
    photo_url=map['photo_url'];
    token=map['token'];
  }
  User.fromJsonLogin(Map<String, dynamic> map) {
      user_id=map['user_id'];
      mobile_no=map['mobile_no'].toString();
      name=map['name'];
      role=map['role'];
      photo_url=map['photo_url'];
      token="bearer ${map['token']}";
    }
  Map<String, dynamic> toJsonGlobal() {
    return  {
      'user_id': user_id,
      'mobile_no': mobile_no,
      'name': name,
      'role': role,
      'photo_url': photo_url,
      'token': token,
    };
  }
}