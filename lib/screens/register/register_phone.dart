import 'package:eventapp/blocs/login_bloc/register_phone_bloc.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPhone extends StatefulWidget  {
  _RegisterPhoneState createState()=>_RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  final RegisterPhoneBloc _registerPhoneBloc=RegisterPhoneBloc();
  bool isHidden=true;
  AppWidgets _appWidgets=AppWidgets();
  void initState()  {
    super.initState();

    Future.delayed(Duration.zero, ()  {
      _appWidgets.context=context;
      Screen.context=context;
    });
  
  
  }
  
  Widget build(BuildContext context)  {

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                
              },
              child:Container(
                height: 50,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                _appWidgets.getSmallFadedText('Already have an account? '),
                _appWidgets.getSmallBoldText('Log in.')
            ],))),
      ),
      body: Container(
         padding: EdgeInsets.fromLTRB(22,0,22,0),
        child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0,85,0,10),
            padding: EdgeInsets.fromLTRB(48,15,48,15),
            child: Image.asset('assets/images/register_profile.png',), ),
            StreamBuilder<String>(
              stream: _registerPhoneBloc.mobileNoStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return TextField(
                  autofocus: false,
                  onChanged: (val)=>_registerPhoneBloc.mobileNoSink.add(val),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                     fillColor: Colors.grey[100],
                     filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300])
                    
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300])
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    labelText: 'Phone number',
                     labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    hintText: 'Phone number',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    // errorText: asyncSnapshot.error,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.fromLTRB(10,0,0,0),
                  ),
                   inputFormatters: [
                        BlacklistingTextInputFormatter(
                            new RegExp('[\\.|\\,\\-\\(\\)\\*\\#\\ ]')),
                      ],
                );
              }
            ),
            SizedBox(height: 16),
            StreamBuilder(
              initialData: false,
              stream: _registerPhoneBloc.submitCheck,
              builder: (BuildContext context, AsyncSnapshot<bool> asyncSnapshot)  {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child:_appWidgets.getRaisedButton(asyncSnapshot.data==null || !asyncSnapshot.data ?null:(){}, 'Log in'));
              }
            ),
          Center(child: _appWidgets.getSmallFadedText('You may receive SMS updates from Instagram and can opt out any time')),
           
        ])
      ),
    );
  }























































}