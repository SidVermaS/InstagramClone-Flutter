import 'package:eventapp/models/post.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/screens/main_menu/profile.dart';

abstract class ProfileState {


}

class ProfileInitialState extends ProfileState  {
  List<Object> get props=>[];
}

class ProfileLoadedState extends ProfileState {
  List<Post> postsList;
  User user;
  ProfileLoadedState({this.user,this.postsList});
  List<Object> get props=>[user,postsList];
}

class ProfileErrorState extends ProfileState  {
  List<Post> postsList;
  User user;
  ProfileErrorState({this.user,this.postsList, this.message});
  String message;

  List<Object> get props=>[user,postsList, message];
}





