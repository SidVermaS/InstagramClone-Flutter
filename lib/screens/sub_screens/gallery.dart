import 'dart:io';

import 'package:eventapp/blocs/gallery_bloc/bloc.dart';
import 'package:eventapp/blocs/new_post_bloc/bloc.dart';
import 'package:eventapp/screens/new_post.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:provider/provider.dart';

import 'package:eventapp/utils/change_cupertino_tab_bar.dart';
import 'package:eventapp/utils/app_widgets.dart';

class Gallery extends StatefulWidget  {
   VoidCallback backVoidCallback;
  Gallery({this.backVoidCallback});
  _GalleryState createState()=>_GalleryState(backVoidCallback: backVoidCallback);
} 

class _GalleryState extends State<Gallery>  {
   VoidCallback backVoidCallback;
  _GalleryState({this.backVoidCallback});
  AppWidgets appWidgets=AppWidgets();
  GalleryBloc galleryBloc;
  void initState()  {
    super.initState();
    appWidgets.context=context;
    Screen.context=context;
    galleryBloc=BlocProvider.of<GalleryBloc>(context);
    Future.delayed(Duration.zero, ()  {
      galleryBloc.add(FetchGalleryEvent());
    });
  }
  void dispose()  {
    super.dispose();
    galleryBloc.close();
  }
  Widget build(BuildContext context)  {
    return 
    WillPopScope(
      onWillPop: ()async=>false,
      child: 
      Scaffold(
      body: Container(
        child: BlocListener<GalleryBloc, GalleryState>(
        listener: (BuildContext context, GalleryState state)  {
          if(state is GalleryErrorState)  {
            Screen.showToast(state.message);
          }
        },
        child: BlocBuilder<GalleryBloc, GalleryState>  ( 
        builder: (context, state) { 
          if(state is GalleryLoadedState) {

            return LazyLoadScrollView(
      onEndOfPage: ()=>galleryBloc.add(FetchGalleryEvent()),
      scrollOffset: 85,
      child: ListView(children:<Widget>[
              Container(
               height: 45,
                child: AppBar(
                  centerTitle: false,
                leading: GestureDetector( child: Icon(Icons.close, size: 30, color: Colors.black54),onTap: ()  {
                  backVoidCallback();
                },),
                title: Container(transform: Matrix4.translationValues(-5, 0,0), child: Text('Gallery')),
                actions: <Widget>[
                  FlatButton(onPressed: () {
                  navigateToNewPost();
               },child: Text('Next', style: TextStyle(color: Screen.eventBlue, fontSize: 16.5)))],)),
              Stack(children:<Widget>[Image.file(File(state.imagesList[state.index].toString()), fit: BoxFit.cover, width: double.infinity, height: Screen.height*0.4),
              Positioned(bottom: 7, right: 10, child: ButtonTheme(height: 32, child: RaisedButton.icon(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), color: Colors.black38, onPressed: () {}, icon: Icon(Icons.image,color: Colors.white, size: 16), label: Text('SELECT IMAGE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 13))))),
              ]),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.imagesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 1.5, crossAxisSpacing: 1.5),
                itemBuilder: (BuildContext context, int index)  {
                  return GestureDetector(behavior: HitTestBehavior.translucent,
                onTap: () {
                  galleryBloc.add(SelectGalleryEvent(index: index));
                },
                  child: GridTile(
                    child: Opacity(
                    opacity: index==state.index?0.2:1,
                    child: FadeInImage(
                    placeholder: AssetImage('assets/images/gallery_placeholder.png'),
                    fit: BoxFit.cover,
                    image: FileImage(File(state.imagesList[index].toString()))))));
                }
              )
              ]));
          }
          return appWidgets.getCircularProgressIndicator();
        })))
        )
        );
  }
  void navigateToNewPost() async  {
    BuildContext previousContext=Screen.context;
 await Screen.navigateAndRefresh(BlocProvider(create:(context)=>NewPostBloc(), child: NewPost(file: File(galleryBloc.imagesList[galleryBloc.index].toString()))));
       Screen.context=previousContext;      
  }
}