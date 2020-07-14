import 'package:equatable/equatable.dart';
import 'package:eventapp/models/comment.dart';

abstract class CommentsState extends Equatable  {



}

class CommentsInitialState extends CommentsState {

  List<Object> get props=>[];

}

class CommentsLoadedState extends CommentsState {

  List<Comment> commentsList;

  CommentsLoadedState({this.commentsList});

  List<Object> get props=>[commentsList];

}

class CommentsErrorState extends CommentsState  {

  String message;
  List<Comment> commentsList;

  CommentsErrorState({this.message, this.commentsList});

  List<Object> get props=>[message, commentsList];

}