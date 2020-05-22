class User  {
  int user_id;
  String name,role,profile_photo_url,mobile_no,au;

  User.fromJsonGlobalVariablesAndMethods(Map<String, dynamic> map) {
    user_id=map['user_id'];
    name=map['name'];
    role=map['role'];
    profile_photo_url=map['profile_photo_url'];
    mobile_no=map['mobile_no'];
    au=map['au'];
  }
  User.fromJsonHome(Map<String, dynamic> map) {
    user_id=map['user_id'];
    name=map['name'];
    profile_photo_url=map['profile_photo_url'];
  }
  User.fromJson(Map<String, dynamic> map) {
    user_id=map['user_id'];
    name=map['name'];
    role=map['role'];
    profile_photo_url=map['profile_photo_url'];
    mobile_no=map['mobile_no'];
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'name': name,
      'role': role,
      'profile_photo_url': profile_photo_url,
      'mobile_no': mobile_no,
      'au': au,
    };
  }
}