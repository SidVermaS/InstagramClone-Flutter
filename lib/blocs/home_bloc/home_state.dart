import 'package:equatable/equatable.dart';
import 'package:eventapp/models/post.dart';

abstract class HomeState  {

}

class HomeInitialState extends HomeState  {


  List<Object> get props=>[];

}

class HomeLoadedState extends HomeState {
  List<Post> postsList;

  HomeLoadedState({this.postsList});
  List<Object> get props=>[postsList];
}
class HomeMoreLoadedState extends HomeState {
  List<Post> postsList;

  HomeMoreLoadedState({this.postsList});
  List<Object> get props=>[postsList];
}

class HomeErrorState extends HomeState  {

  String message;
  List<Post> postsList;
  HomeErrorState({this.message,this.postsList});

  List<Object> get props=>[message,postsList];
}