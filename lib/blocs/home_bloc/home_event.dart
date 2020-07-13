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