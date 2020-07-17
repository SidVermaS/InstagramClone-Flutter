import 'package:badges/badges.dart';
import 'package:eventapp/blocs/explore_bloc/bloc.dart';
import 'package:eventapp/models/post.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:eventapp/utils/users_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Explore extends StatefulWidget {
  Explore();
  _ExploreState createState()=>_ExploreState();
}

class _ExploreState extends State<Explore>{
  _ExploreState();

  AppWidgets appWidgets=AppWidgets();
  ExploreBloc exploreBloc;

  void initState()  {
    super.initState();
    appWidgets.context=context;

    Screen.context=context;

    exploreBloc=BlocProvider.of<ExploreBloc>(context);
    exploreBloc.add(FetchExploreEvent());
  }
  void dispose()  {
    super.dispose();
    exploreBloc.close();
  }

  Widget build(BuildContext context)  {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle:Container(margin: EdgeInsets.only(left: 8), child: Row(mainAxisAlignment: MainAxisAlignment.start, children:<Widget>[
          
          appWidgets.getPageTitle('Explore')])),
      
      ),
      child: Container(
        
        child: BlocListener<ExploreBloc, ExploreState>(
          listener: (BuildContext context, ExploreState state)  {
            if(state is ExploreErrorState)  {
            Screen.showToast(state.message);
          }
          },
          child: BlocBuilder<ExploreBloc, ExploreState>(
            builder: (context, state) {
              if(state is ExploreLoadedState) {
                return _loadPosts(state.postsList);
              }
              return appWidgets.getCircularProgressIndicator();
            }
    ))));
  }
  Widget _loadPosts(List<Post> postsList)  {
    return GridView.builder(
      itemCount: postsList.length, 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 1.5, crossAxisSpacing: 1.5),
      itemBuilder: (BuildContext context, int index)  {
        return GridTile(child: Image.network('${ConstantBaseUrls.photosPhotoBaseUrl}${postsList[index].photo_url}', fit: BoxFit.cover));
      }
    );
  }
}