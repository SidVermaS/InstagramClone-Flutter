import 'package:eventapp/blocs/home_bloc/bloc.dart';
import 'package:eventapp/blocs/home_bloc/home_bloc.dart';
import 'package:eventapp/blocs/home_bloc/home_event.dart';
import 'package:eventapp/models/post.dart';
import 'package:eventapp/networks/constant_base_urls.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:eventapp/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  _HomeState createState()=>_HomeState();
}

class _HomeState extends State<Home>{
  AppWidgets appWidgets=AppWidgets();
  HomeBloc homeBloc;

  void initState()  {
    super.initState();
    appWidgets.context=context;
    Screen.context=context;

    Future.delayed(Duration.zero, ()  {
     Screen.height=MediaQuery.of(context).size.height;
     Screen.width=MediaQuery.of(context).size.width;
    });

    homeBloc=BlocProvider.of<HomeBloc>(context);
    homeBloc.add(FetchHomeEvent());
  }


  Widget build(BuildContext context)  {
    return Scaffold(
      body: Container(
        child: BlocListener<HomeBloc, HomeState>  (
          listener: (BuildContext context, HomeState state) {
            if(state is HomeErrorState)  {
              Screen.showToast(state.message);
            }
          },
          child: BlocBuilder<HomeBloc, HomeState> (builder: (context, state)  {
            if(state is HomeInitialState) {
              return loadShimmer();
            }
            else if(state is HomeLoadedState) {
               return loadPosts(state.postsList);
            }
            else if(state is HomeMoreLoadedState) {
              return loadPosts(state.postsList);
            }
            else if(state is HomeErrorState && state.postsList.length>0)  {
              return loadPosts(state.postsList);
            } else if(state is HomeErrorState)  {
              return loadShimmer();
            }
            return loadShimmer();
          },)
        )
      )
    );
  }

  Widget loadShimmer()  {
    return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: false,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 50, width: double.infinity,
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                            Container(width: 40, height: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white), ),
                            Container(margin: EdgeInsets.only(left: 10),width: 180, height: 20,color: Colors.white),
                          ],)
                        ),
                        Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 5), height: 195, width: double.infinity,color: Colors.white)

                      
                    ],)
                  )
                  
                ),
              );
  }
  Widget loadPosts(List<Post> postsList) {
    return ListView.builder(
      // shrinkWrap: true,
      itemCount: postsList.length,
      itemBuilder: (BuildContext context, int index)  {
      return Container(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
           Container(
             margin: EdgeInsets.fromLTRB(12, 10, 13, 10),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 CircleAvatar(
            backgroundImage: NetworkImage('${ConstantBaseUrls.photosPhotoBaseUrl}${postsList[index].user.photo_url}'),radius: 15.0),
            SizedBox(width: 11.5),
            appWidgets.getName(postsList[index].user.name)
            ],)),
            Container(
              width:Screen.width,
              height: Screen.height-(Screen.height*0.63),
             child: Image.network('${ConstantBaseUrls.photosPhotoBaseUrl}${postsList[index].photo_url}',fit: BoxFit.cover)),
           Container(
             margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 GestureDetector(onTap:() {
                   homeBloc.add(ModifyFavoriteEvent(index: index));
                 }, child:postsList[index].status=='like'?Icon(Icons.favorite, color: Colors.red, size: 30):Icon(Icons.favorite_border, color: Colors.black, size: 30)),
                 SizedBox(width: 10.0),
                Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black),
             ]),
             Icon(FontAwesomeIcons.save, color: Colors.black),
           ],)
        )
          ]));
    });
  }
}