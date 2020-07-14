import 'package:equatable/equatable.dart';

abstract class HomeEvent  {
  
}

class FetchHomeEvent extends HomeEvent  {

  FetchHomeEvent();

  List<Object> get props=>null;

}
class ModifyFavoriteEvent extends HomeEvent  {
  int index;
  
  ModifyFavoriteEvent({this.index});

  List<Object> get props=>[index];
}

class ModifyCommentsCountEvent extends HomeEvent  {

  int index, comments_count;

  ModifyCommentsCountEvent({this.index, this.comments_count});

  List<Object> get props=>[index, comments_count];



}