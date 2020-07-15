

import 'package:equatable/equatable.dart';
import 'package:eventapp/models/comment.dart';

abstract class CommentsEvent  {


}

class FetchCommentsEvent extends CommentsEvent  {

  FetchCommentsEvent();

  List<Object> get props=>null;

}

class AddCommentEvent extends CommentsEvent { 
  String comment_text;

  AddCommentEvent({this.comment_text});

  List<Object> get props=>[comment_text];
}

class DeleteCommentEvent extends CommentsEvent {
  int index;

  DeleteCommentEvent({this.index});

  List<Object> get props=>[index];
}