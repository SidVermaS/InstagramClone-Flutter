import 'dart:async';
import 'dart:convert';

import 'package:eventapp/blocs/comments_bloc/bloc.dart';
import 'package:eventapp/models/comment.dart';
import 'package:eventapp/networks/constant_sub_urls.dart';
import 'package:eventapp/utils/global.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:query_params/query_params.dart';
import 'package:rxdart/rxdart.dart';


class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  
  CommentsBloc({this.comment,this.post_id,this.comments_count}):super(null);

  CommentsState get initialState=>CommentsInitialState();

  final BehaviorSubject<String> commentBehaviorSubject=BehaviorSubject<String>();
  Stream<String> get commentStream=>commentBehaviorSubject.stream;
  StreamSink<String> get commentStreamSink=>commentBehaviorSubject.sink;

  bool notLoading=true;

  int page=-1, post_id,comments_count;
  Comment comment;
  List<Comment> commentsList=List<Comment>(); 
  Map<String, dynamic> bodyMap;
  URLQueryParams queryParams=URLQueryParams();

  void dispose()  {
    commentBehaviorSubject.close();
  }

  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {

    if(event is FetchCommentsEvent) {
      if(notLoading)  {
          notLoading=false;
          try {
            yield CommentsLoadedState(commentsList: commentsList, isLoadingMore: true);
            page++;
            queryParams=URLQueryParams();
            queryParams.append('page', page);
            queryParams.append('post_id', post_id);
            http.Response response=await Global.connect.sendGet('${ConstantSubUrls.comment}?${queryParams.toString()}');
            Map<String, dynamic> mapResponse=jsonDecode(response.body);
    
            if(response.statusCode==200)  {
              List<dynamic> dynamicList=mapResponse['comments'] as List<dynamic>; 
              
              dynamicList.map((i)=>commentsList.add(Comment.fromJson(i))).toList();
              if(dynamicList.length==0) {
                page--;
              }
              yield CommentsLoadedState(commentsList: commentsList, isLoadingMore: false);
             
            } else  {     
              page--;     
              yield CommentsErrorState(message: mapResponse['message'], commentsList: commentsList);
              
            }
          } catch(e)  {
            page--;
            yield CommentsErrorState(message: e.toString(), commentsList: commentsList); 
          }
        notLoading=true;
        }
    } else if(event is AddCommentEvent) {
        yield* mapAddCommentEventToState(event);

    } else if(event is DeleteCommentEvent)  {





    }
  }
    Stream<CommentsState> mapAddCommentEventToState(AddCommentEvent event) async* {
        
        try {
          comment.comment_text=event.comment_text;
          commentStreamSink.add('');
          commentsList.insert(0, comment);
          yield CommentsLoadedState(commentsList: commentsList, isLoadingMore: false);

          bodyMap=comment.toJsonAdd();

          http.Response response=await Global.connect.sendPost('${ConstantSubUrls.comment}', bodyMap);
          Map<String, dynamic> mapResponse=jsonDecode(response.body);
  
          if(response.statusCode==201)  {
            commentsList[0].comment_id=mapResponse['comment']['comment_id'];
            comments_count++;
          } else  {   

            yield CommentsErrorState(message: mapResponse['message'], commentsList: commentsList);
            commentsList.removeAt(0);            
          }
        } catch(e)  {
          yield CommentsErrorState(message: e.toString(), commentsList:commentsList); 
          commentsList.removeAt(0);  
        }
        yield CommentsLoadedState(commentsList: commentsList, isLoadingMore: false);
  }
}