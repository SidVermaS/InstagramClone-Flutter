import 'package:eventapp/blocs/login_bloc/login_bloc.dart';
import 'package:eventapp/blocs/register_bloc/register_details_bloc.dart';
import 'package:eventapp/utils/app_widgets.dart';
import 'package:eventapp/utils/global.dart';
import 'package:eventapp/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterDetails extends StatefulWidget  {
  RegisterDetails()  {
   
  }
  _RegisterDetailsState createState()=>_RegisterDetailsState();
}

class _RegisterDetailsState extends State<RegisterDetails> {
  RegisterDetailsBloc _registerDetailsBloc=RegisterDetailsBloc();
  bool isHidden=true;
  AppWidgets _appWidgets=AppWidgets();
  void initState()  {
    super.initState();
     _appWidgets.context=context;
      Screen.context=context;
    Future.delayed(Duration.zero, ()  {
     
      Screen.width=MediaQuery.of(context).size.width;       
      final Map arguments = ModalRoute.of(context).settings.arguments as Map;
       _registerDetailsBloc.mobile_no=arguments['mobile_no'];
    });
  
  
  }
  void dispose()  {
    super.dispose();
    _registerDetailsBloc.dispose();
  }
  Widget build(BuildContext context)  {

    return Scaffold(
      body: Container(
         padding: EdgeInsets.fromLTRB(22,0,22,20),
        child: Column(
        children: <Widget>[
        Expanded(child:  ListView(
            shrinkWrap: true,
            children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0,45,0,30),
            child: Text('PROFILE DETAILS',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),textAlign: TextAlign.center, )),
            StreamBuilder<String>(
              stream: _registerDetailsBloc.nameStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return TextField(
                  autofocus: false,
                  onChanged: (val)=>_registerDetailsBloc.nameSink.add(val),
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
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    labelText: 'Full name',
                     labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    hintText: 'Full name',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    errorText: asyncSnapshot.error,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.fromLTRB(10,0,0,0),
                  ),
               
                );
              }
            ),
            SizedBox(height: 16),
          
            StreamBuilder<String>(
              stream: _registerDetailsBloc.passwordStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return TextField(
                  autofocus: false,
                  onChanged: (val)=>_registerDetailsBloc.passwordSink.add(val),
                  keyboardType: TextInputType.text,
                  obscureText: isHidden,
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
                    errorText: asyncSnapshot.error,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: IconButton(icon: isHidden?Icon(Icons.visibility_off, color: Colors.grey[500]):Icon(Icons.visibility, color: Screen.eventBlue), onPressed:(){
                    setState(()  {
                      isHidden=!isHidden;
                    });
                  }),
                    contentPadding: EdgeInsets.fromLTRB(10,0,0,0),
                  ),
                );
              }
            ),
            SizedBox(height: 16),
                 StreamBuilder<String>(
              stream: _registerDetailsBloc.descriptionStream,
              builder:  (BuildContext context, AsyncSnapshot<String> asyncSnapshot) {
                return TextField(
                  autofocus: false,
                  onChanged: (val)=>_registerDetailsBloc.descriptionSink.add(val),
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 3,
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
                    labelText: 'Description',
                     labelStyle:  TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15.0),
                    errorText: asyncSnapshot.error,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.fromLTRB(10,0,0,0),
                  ),
                );
              }
            ),
           
            StreamBuilder(
              initialData: false,
              stream: _registerDetailsBloc.submitCheck,
              builder: (BuildContext context, AsyncSnapshot<bool> asyncSnapshot)  {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child:ButtonTheme(
                    minWidth: double.infinity,
                    child: _appWidgets.getRaisedButton(asyncSnapshot.data==null || !asyncSnapshot.data ?null:(){ FocusScope.of(context).unfocus();
                    _registerDetailsBloc.registerAccount();
                    }, 'Register')));
              }
            )]),
           ),
           _appWidgets.getSmallFadedText('This application is built for educational purposes only'),
           
        ])
      ),
    );
    }


}