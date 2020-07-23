import 'dart:io';
import 'package:eventapp/blocs/new_post_bloc/bloc.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import 'package:eventapp/utils/change_cupertino_tab_bar.dart';
import 'package:eventapp/utils/app_widgets.dart';

class NewPost extends StatefulWidget  {
  File file;
  NewPost({this.file});
  _NewPostState createState()=>_NewPostState();
} 

class _NewPostState extends State<NewPost>  {
  
  NewPostBloc newPostBloc;
  void initState()  {
    super.initState();
    newPostBloc.appWidgets.context=context;
    Screen.context=context;
    newPostBloc=BlocProvider.of<NewPostBloc>(context);
    newPostBloc.add(FetchPhotoEvent(file: widget.file));
  }
  void dispose()  {
    super.dispose();
    newPostBloc.dispose();
    newPostBloc.close();
  }
  Future<bool> _onWillPop() async {
    newPostBloc.appWidgets.navigatePop();
    return false;
  }
  Widget build(BuildContext context)  {
    return WillPopScope(
      onWillPop: () async=>false,
      child: Scaffold(
        appBar: AppBar(
                  centerTitle: false,
                leading: GestureDetector( child: Icon(Icons.close, size: 30, color: Colors.black54),onTap: ()  {
                  _onWillPop();
                },),
                title: Container( child: Text('New Post', style: TextStyle(fontSize: 20),)),
                actions: <Widget>[FlatButton(onPressed: () {
                  FocusScope.of(context).unfocus();
                 if(newPostBloc.captionBehaviorSubject.value.length<4) {
                   Screen.showToast('Caption should have atleast 4 characters');
                 }  else  {
                   newPostBloc.add(SubmitPostEvent());
                 }
              },child: Text('Share', style: TextStyle(color: Screen.eventBlue, fontSize: 17.5)))],),
      body: Container(
       
        child: BlocListener<NewPostBloc, NewPostState>(
        listener: (BuildContext context, NewPostState state)  {
          if(state is NewPostErrorState)  {
            Screen.showToast(state.message);
          } else if(state is SubmittedErrorState)  {
            Screen.showToast(state.message);
          }
        },
        child: BlocBuilder<NewPostBloc, NewPostState>  ( 
        builder: (context, state) { 
          if(state is NewPostLoadedState || state is SubmittedErrorState) {
          if(state is NewPostLoadedState) {

            return ListView(children:<Widget>[
              Container( 
                margin: EdgeInsets.fromLTRB(15,18,15,18),
                child: TextField(
                onChanged: (val)=>newPostBloc.captionStreamSink.add(val),
                controller: newPostBloc.captionTextEditingController,
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  prefixIcon: Container(margin: EdgeInsets.only(right: 10),child: Image.file(state.file, height: 55, width: 55, fit: BoxFit.cover)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
                  labelText: 'Write a caption...',
                  labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                  hintText: 'Write a caption...',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                )
              )),
              Container(color: Colors.grey[300], height: 1, width: double.infinity)
            ]);
          }
          }
          return newPostBloc.appWidgets.getCircularProgressIndicator();
        })))));
  }
}