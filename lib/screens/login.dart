import 'package:eventapp/blocs/login_bloc/login_bloc.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Login extends StatelessWidget {
  final LoginBloc _loginBloc=LoginBloc();
  

  
  Widget build(BuildContext context)  {
    _loginBloc.context=context;

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
                  onChanged: (val)=>_loginBloc.mobileNoSink.add(val),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '',
                    hintText: 'Phone number',
                    floatingLabelBehavior: FloatingLabelBehavior.always
                  ),
                   inputFormatters: [
                        BlacklistingTextInputFormatter(
                            new RegExp('[\\.|\\,\\-\\ ]')),
                      ],
                );
              }
            ),
            SizedBox(height: 15),
            StreamBuilder<String>(
              stream: _loginBloc.passwordStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return TextField(
                  onChanged: (val)=>_loginBloc.passwordSink.add(val),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    labelText: '',
                    hintText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always
                  ),
                );
              }
            ),

        ])
      ),
    );
  }























































}