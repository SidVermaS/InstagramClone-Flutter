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
  final TextEditingController _messageTextTextEditingController=TextEditingController();
  void initState()  {
    super.initState();
    _appWidgets.context=context;
    Screen.context=context;
    
    directBloc= BlocProvider.of<DirectBloc>(context);
    directBloc.add(InitializeDirectEvent());
   }
  void dispose()  {
    super.dispose();
    _messageTextTextEditingController.dispose();
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
                      
                          Container(
                            margin: EdgeInsets.only(right: 12),
                            child: CircleAvatar(
                            backgroundImage: NetworkImage('${ConstantBaseUrls.photosPhotoBaseUrl}${Global.user.photo_url}'),radius: 15.0)),
                          Flexible(child: TextField(
                            onChanged: (val)=>directBloc.messageTextStreamSink.add(val),
                            controller: _messageTextTextEditingController,
                            minLines: 1,
                            maxLines: 3,
                         decoration: InputDecoration(
                           border: InputBorder.none,
                           contentPadding: EdgeInsets.fromLTRB(0,0,0,5),
                             labelText: 'Add a messageText...',
                    labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    hintText: 'Add a messageText...',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                           )
                           ),  
                          ),
              GestureDetector(onTap: () {
                directBloc.add(SendMessageEvent(message_text: _messageTextTextEditingController.text));
                _messageTextTextEditingController.text='';
              }, behavior: HitTestBehavior.translucent, child: 
               StreamBuilder<String>(
                 initialData: '',
              stream: directBloc.messageTextStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return Text('Send', style: TextStyle(color: asyncSnapshot.data==null || asyncSnapshot.data==''?Colors.blue[100]:Screen.eventBlue, fontWeight: FontWeight.w600));}),
            
              )
                        ]),
                    

                         )
                    ),
      body: 
        Container(
        margin: EdgeInsets.fromLTRB(0,13,0, 0),
        padding: EdgeInsets.only(bottom: 5),
        child: 
        ListView(
                shrinkWrap: true,
                children: <Widget>[ 
                  
                  Container(margin: EdgeInsets.fromLTRB(0, 13, 0, 13), width: double.infinity, height: 1.0, color: Colors.grey[300]),
          Container(
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
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children:<Widget>[
                    
                    
                      
                  ]);
              }
              return _appWidgets.getCircularProgressIndicator();
              }
            )
          )
        ),
               
                ],
                )
                ),
                
    )));
    
  }


     Widget _loadDirect(List<Message> messageList)  {
      return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: messageList.length,
                      itemBuilder: (BuildContext context, int index)  {  
                        return Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10), child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:<Widget>[
                           
                    
                    ]));
                      }
                    );
    }


}