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
  AppWidgets appWidgets=AppWidgets();
  NewPostBloc newPostBloc;
  void initState()  {
    super.initState();
    appWidgets.context=context;
    Screen.context=context;
    newPostBloc=BlocProvider.of<NewPostBloc>(context);
    newPostBloc.add(FetchPhotoEvent(file: widget.file));
  }
  void dispose()  {
    super.dispose();
    newPostBloc.close();
  }
  Future<bool> _onWillPop() async {
    return false;
  }
  Widget build(BuildContext context)  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
                  centerTitle: false,
                leading: GestureDetector( child: Icon(Icons.close, size: 30, color: Colors.black54),onTap: ()  {
                  _onWillPop();
                },),
                title: Container( child: Text('New Post')),
                actions: <Widget>[FlatButton(onPressed: () {
                 
              },child: Text('Next', style: TextStyle(color: Screen.eventBlue, fontSize: 16.5)))],),
      body: Container(
        child: BlocListener<NewPostBloc, NewPostState>(
        listener: (BuildContext context, NewPostState state)  {
          if(state is NewPostErrorState)  {
            Screen.showToast(state.message);
          }
        },
        child: BlocBuilder<NewPostBloc, NewPostState>  ( 
        builder: (context, state) { 
          if(state is NewPostLoadedState) {

            return ListView(children:<Widget>[
              TextField(
                            onChanged: (val)=>newPostBloc.captionStreamSink.add(val),
                            // controller: _commentTextEditingController,
                            minLines: 1,
                            maxLines: 3,
                         decoration: InputDecoration(
                           prefix: Image.file(state.file, ),
                           border: InputBorder.none,
                           contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
                             labelText: 'Write a caption...',
                    labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    hintText: 'Write a caption...',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                           )
                           )
              
              ]);
          }
          return appWidgets.getCircularProgressIndicator();
        })))));
  }
}