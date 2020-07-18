import 'dart:io';

import 'package:eventapp/blocs/gallery_bloc/bloc.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import 'package:eventapp/utils/change_cupertino_tab_bar.dart';
import 'package:eventapp/utils/app_widgets.dart';

class Gallery extends StatefulWidget  {
  _GalleryState createState()=>_GalleryState();
} 

class _GalleryState extends State<Gallery>  {
  AppWidgets appWidgets=AppWidgets();
  GalleryBloc galleryBloc;
  void initState()  {
    super.initState();
    appWidgets.context=context;
    Screen.context=context;
    galleryBloc=BlocProvider.of<GalleryBloc>(context);
    galleryBloc.add(FetchGalleryEvent());
  }
  void dispose()  {
    super.dispose();
    galleryBloc.close();
  }
  Future<bool> _onWillPop() async {
    return true;
  }
  Widget build(BuildContext context)  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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

            return ListView(children:<Widget>[
              Container(
               height: 45,
                child: AppBar(
                  centerTitle: false,
                leading: GestureDetector( child: Icon(Icons.close, size: 30, color: Colors.black54),onTap: ()  {
                  _onWillPop();
                },),
                title: Container(transform: Matrix4.translationValues(-25, 0,0), child: Text('Gallery')),
                actions: <Widget>[FlatButton(onPressed: () {

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
                  return GridTile(child: Opacity(
                    opacity: index==state.index?0.6:0,
                    child: FadeInImage(
                    placeholder: AssetImage('assets/images/gallery_placeholder.png'),
                    fit: BoxFit.cover,
                    image: FileImage(File(state.imagesList[index].toString())))));
                }
              )]);
          }
          return appWidgets.getCircularProgressIndicator();
        })))));
  }
}