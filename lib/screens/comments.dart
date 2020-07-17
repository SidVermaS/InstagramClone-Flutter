import 'package:eventapp/blocs/comments_bloc/bloc.dart';
import 'package:eventapp/models/comment.dart';
import 'package:eventapp/models/post.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
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
  void initState()  {
    super.initState();
    commentsBloc= BlocProvider.of<CommentsBloc>(context);
    commentsBloc.comment=Comment(post_id: post.post_id, user: User(user_id: Global.user.user_id, name: Global.user.name, photo_url: Global.user.photo_url));
  }
  void dispose()  {
    super.dispose();
    _commentTextEditingController.dispose();
    commentsBloc.close();
  }
  
  Future<bool> _onWillPop() async {
    Navigator.of(Screen.context).pop(commentsBloc.comments_count);

    return false;
  }

  Widget build(BuildContext context)  {
     
    _appWidgets.context=context;
    Screen.context=context;
    commentsBloc.add(FetchCommentsEvent());

    return _appWidgets.getMaterialApp(WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
         resizeToAvoidBottomPadding: false,
       resizeToAvoidBottomInset: false,
      // navigationBar: CupertinoNavigationBar(
      //   automaticallyImplyLeading: false,
        // middle: Container(
        //     margin: EdgeInsets.fromLTRB(8, 0, 8, 0),                       
        //     child: Row(mainAxisAlignment: MainAxisAlignment.start, children:<Widget>[GestureDetector(
        //       onTap:()  {
        //         _onWillPop();
        //       },
        //       child: Icon(Icons.arrow_back, color: Colors.black)),  SizedBox(width: 18), _appWidgets.getPageTitle('Comments')])),
      // ),
      appBar: AppBar(
          backgroundColor: Screen.eventGrey,
        leading: IconButton(
              onPressed:()  {
                _onWillPop();
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
              centerTitle: false,
              title: _appWidgets.getPageTitle('Comments')
      ),
      bottomNavigationBar: BottomAppBar(  
        child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),    
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget>[
                      
                          Container(
                            margin: EdgeInsets.only(right: 12),
                            child: CircleAvatar(
                            backgroundImage: NetworkImage('${ConstantBaseUrls.photosPhotoBaseUrl}${Global.user.photo_url}'),radius: 15.0)),
                          Flexible(child: TextField(
                            onChanged: (val)=>commentsBloc.commentStreamSink.add(val),
                            controller: _commentTextEditingController,
                            minLines: 1,
                            maxLines: 3,
                         decoration: InputDecoration(
                           border: InputBorder.none,
                           contentPadding: EdgeInsets.fromLTRB(0,0,0,5),
                             labelText: 'Add a comment...',
                    labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                           )
                           ),  
                          ),
              GestureDetector(onTap: () {
                commentsBloc.add(AddCommentEvent(comment_text: _commentTextEditingController.text));
                _commentTextEditingController.text='';
              }, behavior: HitTestBehavior.translucent, child: 
               StreamBuilder<String>(
                 initialData: '',
              stream: commentsBloc.commentStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return Text('Post', style: TextStyle(color: asyncSnapshot.data==null || asyncSnapshot.data==''?Colors.blue[100]:Screen.eventBlue, fontWeight: FontWeight.w600));}),
            
              )
                        ]),
                    

                         )
                    ),
      body: 
        Container(
        margin: EdgeInsets.fromLTRB(0,13,0, 0),
        padding: EdgeInsets.only(bottom: 5),
        child: 
        ListView(
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
          child: 
          BlocListener<CommentsBloc, CommentsState> ( 
            listener:(BuildContext context, CommentsState state)  {
              if(state is CommentsErrorState) {
                Screen.showToast(state.message);
              }
            },
            child: BlocBuilder<CommentsBloc, CommentsState> (
            builder: (BuildContext context, CommentsState state) {
              // if(state is CommentsLoadedState)  {
              //   return _loadComments(state.commentsList);
              // }
              if(state is CommentsLoadedState)  { 
                
              return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children:<Widget>[
                   
                  _loadComments(state.commentsList),
                    state.isLoadingMore?_appWidgets.getCircularProgressIndicator():GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        commentsBloc.add(FetchCommentsEvent());
                      },
                      child: Icon(Icons.add_circle_outline, color: Colors.grey, size: 50))
                    
                    ]);
              }
              return _appWidgets.getCircularProgressIndicator();
              }
            )
          )
        ),
               
                ],
                )
                ),
                
    )));
    
  }


     Widget _loadComments(List<Comment> commentsList)  {
      return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: commentsList.length,
                      itemBuilder: (BuildContext context, int index)  {  
                        return Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10), child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:<Widget>[
                            Flexible(flex: 1,child: Container(margin: EdgeInsets.only(right: 10), child: CircleAvatar(
              backgroundImage: NetworkImage('${ConstantBaseUrls.photosPhotoBaseUrl}${commentsList[index].user.photo_url}'),radius: 15.0))),
                            Flexible(flex: 5,child:  RichText(text: TextSpan(text: '${commentsList[index].user.name} ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold), children:<TextSpan>[
              TextSpan(text: commentsList[index].comment_text, style: TextStyle(color: Colors.black87, fontSize: 15,fontWeight: FontWeight.normal)),
  
              ])),),
                    
                    ]));
                      }
                    );
    }


}