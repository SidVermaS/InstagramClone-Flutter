import 'package:eventapp/blocs/login_bloc/login_bloc.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget  {
  _LoginState createState()=>_LoginState();
}

class _LoginState extends State<Login> {
  final LoginBloc _loginBloc=LoginBloc();
  bool isVisible=false;
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
      
      body: Container(
         padding: EdgeInsets.fromLTRB(22,0,22,0),
        child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0,85,0,10),
            padding: EdgeInsets.fromLTRB(48,15,48,15),
            child: Image.asset('assets/images/instagram.png',), ),
            StreamBuilder<String>(
              stream: _loginBloc.mobileNoStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return TextField(
                  autofocus: false,
                  onChanged: (val)=>_loginBloc.mobileNoSink.add(val),
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
            StreamBuilder<String>(
              stream: _loginBloc.passwordStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return TextField(
                  autofocus: false,
                  onChanged: (val)=>_loginBloc.passwordSink.add(val),
                  keyboardType: TextInputType.text,
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
                      borderSide: BorderSide(color: Colors.grey[300])
                    ),
                    labelText: 'Password',
                    labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: IconButton(icon: isVisible?Icon(Icons.visibility, color: Screen.eventBlue):Icon(Icons.visibility_off, color: Colors.grey[500]), onPressed:(){
                    setState(()  {
                      isVisible=!isVisible;
                    });
                  }),
                    contentPadding: EdgeInsets.fromLTRB(10,0,0,0),
                  ),
                );
              }
            ),
            StreamBuilder(
              initialData: false,
              stream: _loginBloc.submitCheck,
              builder: (BuildContext context, AsyncSnapshot<bool> asyncSnapshot)  {
                return _appWidgets.getRaisedButton(asyncSnapshot.data?(){}:null, 'Log in');
              }
            ),
        ])
      ),
    );
  }























































}