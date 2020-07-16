import 'package:eventapp/models/post.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/screens/main_menu/profile.dart';

abstract class ProfileState {


}

class ProfileInitialState extends ProfileState  {
  List<Object> get props=>[];
}

class ProfileLoadedState extends ProfileState {
  User user;
  ProfileLoadedState({this.user});
  List<Object> get props=>[user];
}

class ProfileErrorState extends ProfileState  {
  User user;
  ProfileErrorState({this.user, this.message});
  String message;

  List<Object> get props=>[user, message];
}

class PostsInitialState extends ProfileState  {
  List<Object> get props=>[];
}

class PostsLoadedState extends ProfileState {
  List<Post> postsList;
  PostsLoadedState({this.postsList});
  List<Object> get props=>[postsList];
}

class PostsErrorState extends ProfileState  {
  List<Post> postsList;
  PostsErrorState({this.postsList, this.message});
  String message;

  List<Object> get props=>[postsList, message];
}



