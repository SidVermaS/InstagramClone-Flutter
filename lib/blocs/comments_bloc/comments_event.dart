

import 'package:equatable/equatable.dart';
import 'package:eventapp/models/comment.dart';

abstract class CommentsEvent extends Equatable  {


}

class FetchCommentsEvent extends CommentsEvent  {

  FetchCommentsEvent();

  List<Object> get props=>null;

}

class AddCommentEvent extends CommentsEvent { 
  Comment comment;

  AddCommentEvent({this.comment});

  List<Object> get props=>[comment];
}

class DeleteCommentEvent extends CommentsEvent {
  int index;

  DeleteCommentEvent({this.index});

  List<Object> get props=>[index];
}