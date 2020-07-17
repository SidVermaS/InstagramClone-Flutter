import 'package:eventapp/models/post.dart';

abstract class ExploreState {


}


class ExploreInitialState extends ExploreState {

  List<Object> get props=>[];

}

class ExploreLoadedState extends ExploreState {
  ExploreLoadedState({this.postsList});

  List<Post> postsList;

  List<Object> get props=>[postsList];
}

class ExploreErrorState extends ExploreState  {

  String message;
  List<Post> postsList;
  ExploreErrorState({this.message, this.postsList});

  List<Object> get props=>[message, postsList];
}