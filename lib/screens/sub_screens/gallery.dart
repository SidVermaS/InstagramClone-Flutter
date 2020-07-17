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
    galleryBloc.add(FetchGalleryEvent(index: 0));
  }

  Widget build(BuildContext context)  {
    return Scaffold(
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
            return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)  {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.file(state.imagesList[state.index], fit: BoxFit.cover)
                    )
                  )
                ];
              },
              body: GridView.builder(
                shrinkWrap: true,
                itemCount: state.imagesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 1.5, crossAxisSpacing: 1.5),
                itemBuilder: (BuildContext context, int index)  {
                  return GridTile(child: Image.file(state.imagesList[index], fit: BoxFit.cover));
                }
              ));
          }
          return appWidgets.getCircularProgressIndicator();
        }))));
  }
}