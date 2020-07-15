import 'package:eventapp/blocs/comments_bloc/bloc.dart';
import 'package:eventapp/models/post.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Comments extends StatefulWidget  {
    Comments({this.post}) {
    
  }
  Post post;
  _CommentsState createState()=>_CommentsState(post: post);
}
class _CommentsState extends State<Comments>  {
  _CommentsState({this.post}) {
    
  }

  AppWidgets _appWidgets=AppWidgets();
  Post post;
  CommentsBloc commentsBloc;
  final TextEditingController _commentTextEditingController=TextEditingController();
  Future<bool> _onWillPop() async {
    Navigator.of(Screen.context).pop(commentsBloc.comments_count);

    return false;
  }

  Widget build(BuildContext context)  {
     commentsBloc= BlocProvider.of<CommentsBloc>(context);
    _appWidgets.context=context;
    Screen.context=context;
    commentsBloc.add(FetchCommentsEvent());

    return WillPopScope(
      onWillPop: _onWillPop,
      child: CupertinoPageScaffold(
        
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Container(
            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),                       
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children:<Widget>[GestureDetector(
              onTap:()  {
                _onWillPop();
              },
              child: Icon(Icons.arrow_back, color: Colors.black)),  SizedBox(width: 18), _appWidgets.getPageTitle('Comments')])),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(0,10,0, 10),
        child: ListView(
                shrinkWrap: true,
                children: <Widget>[ 
                  Container(  
        margin: EdgeInsets.fromLTRB(7, 0, 7, 0),
        child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[ 
                      Flexible(
                        flex: 1,
                        child:Container(margin: EdgeInsets.only(right: 10), child: CircleAvatar(
              backgroundImage: NetworkImage('${ConstantBaseUrls.photosPhotoBaseUrl}${post.user.photo_url}'),radius: 15.0))),
                 Flexible(flex: 5, child: RichText(text: TextSpan(text: '${post.user.name} ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold), children:<TextSpan>[
            TextSpan(text: post.caption, style: TextStyle(color: Colors.black87, fontSize: 15,fontWeight: FontWeight.normal))]))),  
                  ])), 
                  Container(margin: EdgeInsets.fromLTRB(0, 13, 0, 13), width: double.infinity, height: 1.0, color: Colors.grey[300]),
          Container(
           margin: EdgeInsets.fromLTRB(7, 0, 7, 0),
          child: BlocListener<CommentsBloc, CommentsState> ( 
            listener:(BuildContext context, CommentsState state)  {
              if(state is CommentsErrorState) {
                Screen.showToast(state.message);
              }
            },
            child: BlocBuilder<CommentsBloc, CommentsState> (
            builder: (BuildContext context, CommentsState state) {
              if(state is CommentsLoadedState)  { 
              return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children:<Widget>[
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.commentsList.length,
                      itemBuilder: (BuildContext context, int index)  {  
                        return Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10), child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:<Widget>[
                            Flexible(flex: 1,child: Container(margin: EdgeInsets.only(right: 10), child: CircleAvatar(
              backgroundImage: NetworkImage('${ConstantBaseUrls.photosPhotoBaseUrl}${state.commentsList[index].user.photo_url}'),radius: 15.0))),
                            Flexible(flex: 5,child:  RichText(text: TextSpan(text: '${state.commentsList[index].user.name} ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold), children:<TextSpan>[
              TextSpan(text: post.caption, style: TextStyle(color: Colors.black87, fontSize: 15,fontWeight: FontWeight.normal)),
  
              ])),),
                    
                    ]));
                      }
                    ),
                    state.isLoadingMore?Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),)):GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        commentsBloc.add(FetchCommentsEvent());
                      },
                      child: Icon(Icons.add_circle_outline, color: Colors.grey, size: 50))
                    
                    ]);
              }
              return Center(child: CircularProgressIndicator());
              }
            )
          )
        ),
                ],))
        // Align(alignment: Alignment.bottomCenter,
        //             child: Container(child: TextField(
        //               decoration: InputDecoration(
        //                 border: OutlineInputBorder()
        //               ),
        //             ))
        //           )
               
    ));
  }










}