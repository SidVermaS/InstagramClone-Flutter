import 'package:eventapp/blocs/direct_bloc/bloc.dart';
import 'package:eventapp/models/message.dart';
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

class Direct extends StatefulWidget  {
  _DirectState createState()=>_DirectState();
}
class _DirectState extends State<Direct>  {
  _DirectState() {
    
  }

  AppWidgets _appWidgets=AppWidgets();
  DirectBloc directBloc;
  void initState()  {
    super.initState();
    _appWidgets.context=context;
    Screen.context=context;
    
    directBloc= BlocProvider.of<DirectBloc>(context);
    directBloc.add(FetchDirectEvent());
    directBloc.listenMessages();
   }
  void dispose()  {
    super.dispose();
    directBloc.close();
  }
  
  Future<bool> _onWillPop() async {
    Navigator.of(Screen.context).pop();

    return false;
  }

  Widget build(BuildContext context)  {
     
    

    return _appWidgets.getMaterialApp(WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
         resizeToAvoidBottomPadding: false,
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Screen.eventGrey,
        leading: IconButton(
              onPressed:()  {
                _onWillPop();
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
              centerTitle: false,
              title: _appWidgets.getPageTitle('Direct')
      ),
      bottomNavigationBar: BottomAppBar(  
        child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),    
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget>[
                      
                          // Container(
                          //   margin: EdgeInsets.only(right: 12),
                          //   child: CircleAvatar(
                          //   backgroundImage: NetworkImage('${ConstantBaseUrls.photosPhotoBaseUrl}${Global.user.photo_url}'),radius: 15.0)),
                          Flexible(child: TextField(
                            onChanged: (val)=>directBloc.messageTextStreamSink.add(val),
                            controller: directBloc.messageTextTextEditingController,
                            minLines: 1,
                            maxLines: 3,
                         decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(0,0,0,5),
                          labelText: 'Send a message...',
                          labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                          hintText: 'Send a message...',
                          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                    )
                  ),  
              ),
              GestureDetector(onTap: () {
                if(directBloc.messageTextBehaviorSubject.value.trim().length>0) {
                  FocusScope.of(context).unfocus();
                  directBloc.add(SendMessageEvent());
                }
              }, behavior: HitTestBehavior.translucent, child: 
               StreamBuilder<String>(
                 initialData: '',
              stream: directBloc.messageTextStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return Text('Send', style: TextStyle(color: asyncSnapshot.data==null || asyncSnapshot.data==''?Colors.blue[200]:Screen.eventBlue, fontWeight: FontWeight.w600));}),
            
              )
                        ]),
                    

                         )
                    ),
      body: 
        Container(
        margin: EdgeInsets.fromLTRB(0,13,0, 0),
        padding: EdgeInsets.only(bottom: 5),
        child: Container(
           margin: EdgeInsets.fromLTRB(7, 0, 7, 0),
          child: 
          BlocListener<DirectBloc, DirectState> ( 
            listener:(BuildContext context, DirectState state)  {
              if(state is DirectErrorState) {
                Screen.showToast(state.message);
              }
            },
            child: BlocBuilder<DirectBloc, DirectState> (
            builder: (BuildContext context, DirectState state) {
              if(state is DirectLoadedState)  {    
                return _loadMessages(state.messagesList);
              }
              return _appWidgets.getCircularProgressIndicator();
              }
            )
          )
        ),
               
                ),
                
    )));
    
  }


     Widget _loadMessages(List<Message> messagesList)  {
        print('~~~~ lm');
      return  ListView.builder(
                  itemCount:messagesList.length,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)  {
                    print('~~~~ lm');
                    return Container( margin: EdgeInsets.fromLTRB(0, 5, 0, 5),child: messagesList[index].user.user_id==Global.user.user_id?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                           padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.deepPurple[500],
        borderRadius: BorderRadius.circular(20.0)
      ),
      constraints: BoxConstraints(
        maxWidth: Screen.width * 0.7,
      ),
      child: Text(
        messagesList[index].message_text,
        style: TextStyle(color: Colors.white),
      ),
    ),
                      ],):Row( 
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 5, top:(index==0 || messagesList[index].user.user_id!=messagesList[index-1].user.user_id)?15:0),
                            child: ((messagesList.length-1)==index || messagesList[index].user.user_id!=messagesList[index+1].user.user_id)?CircleAvatar(
                            backgroundImage: NetworkImage('${ConstantBaseUrls.photosPhotoBaseUrl}${Global.user.photo_url}'),radius: 15.0):Container(decoration: BoxDecoration(shape: BoxShape.circle,) ,width:30, height: 15)),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.start,
  children:<Widget>[
  (index==0 || messagesList[index].user.user_id!=messagesList[index-1].user.user_id)?Container(margin: EdgeInsets.only(left: 11.5, bottom:6),child: Text(messagesList[index].user.name, style: TextStyle(fontSize: 11, color: Colors.grey[500]))):SizedBox(width: 0, height: 0),
  Container(
                            padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0)
      ),
          constraints: BoxConstraints(
            maxWidth: Screen.width * 0.7,
          ),
          child: Text(
            messagesList[index].message_text,
            style: TextStyle(color: Colors.black),
          ),
        ),
]),
                          
                      ],));
                  }
                  );
             
    }


}