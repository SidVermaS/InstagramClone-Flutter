import 'package:equatable/equatable.dart';
import 'package:eventapp/models/comment.dart';

abstract class CommentsState  {



}

class CommentsInitialState extends CommentsState {

  List<Object> get props=>[];

}

class CommentsLoadedState extends CommentsState {

  List<Comment> commentsList;
  bool isLoadingMore;
  CommentsLoadedState({this.commentsList, this.isLoadingMore});

  List<Object> get props=>[commentsList, isLoadingMore];

}

class CommentsErrorState extends CommentsState  {

  String message;
  List<Comment> commentsList;

  CommentsErrorState({this.message, this.commentsList});

  List<Object> get props=>[message, commentsList];

}