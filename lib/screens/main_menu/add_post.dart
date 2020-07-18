import 'package:eventapp/blocs/gallery_bloc/bloc.dart';
import 'package:eventapp/blocs/photo_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:eventapp/screens/sub_screens/gallery.dart';
import 'package:eventapp/screens/sub_screens/photo.dart';
import 'package:eventapp/utils/app_widgets.dart';

class AddPost extends StatefulWidget{
  _AddPostState createState()=>_AddPostState();
} 

class _AddPostState extends State<AddPost> with SingleTickerProviderStateMixin  {
  TabController _tabController;
    AppWidgets _appWidgets=AppWidgets();
  void initState()  {
    super.initState();
    _tabController=TabController(vsync: this, length: 2);
  }
  void dispose()  {
    super.dispose();
    _tabController.dispose();
  }
  Future<bool> onWillPop() async {
    print('~~~ onWillPop called');
    Navigator.of(context).pop();
    return false;
  }
  Widget build(BuildContext context)  {
    return  _appWidgets.getMaterialApp(WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
        indicatorColor: Colors.black,
        labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        controller: _tabController, tabs: <Widget>[getTab('GALLERY'),getTab('PHOTO')])),
      body: TabBarView(controller: _tabController,children: <Widget>[
        BlocProvider(create:(context)=>GalleryBloc(), child: Gallery(backVoidCallback: onWillPop,)),BlocProvider(create:(context)=>PhotoBloc(), child: Photo(backVoidCallback: onWillPop,))
      ],)
      
    )));
  }
  Widget getTab(String text)  {
    return Text(text,style: TextStyle(fontSize: 15),);
  }
}