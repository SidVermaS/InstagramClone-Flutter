import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:eventapp/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  _HomeState createState()=>_HomeState();
}

class _HomeState extends State<Home>{
  void initState()  {
    super.initState();

    Screen.context=context;

    Future.delayed(Duration.zero, ()  {
     Screen.height=MediaQuery.of(context).size.height;
     Screen.width=MediaQuery.of(context).size.width;
    });
  }


  Widget build(BuildContext context)  {
    return Scaffold(
      body: loadShimmer()
    );
  }

  Widget loadShimmer()  {
    return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: true,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: ListView(
                        shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 80, width: double.infinity,
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                            Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle), color: Colors.white),
                            Container(margin: EdgeInsets.only(left: 10),width: 40, height: 10,color: Colors.white),
                          ],)
                        ),
                        Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 5), height: 180, width: double.infinity,color: Colors.white)

                      
                    ],)
                  )
                  
                ),
              );
  }

}