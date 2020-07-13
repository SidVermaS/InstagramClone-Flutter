import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable  {
  
}

class FetchHomeEvent extends HomeEvent  {
  int user_id, page;

  FetchHomeEvent({this.user_id, this.page});

  List<Object> get props=>[user_id, page];

}