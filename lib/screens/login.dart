import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
            child: Image.asset('assets/images/kirana_logo.png'),
          ),
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Text('Kirana')),
              Flexible(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Gokul Dham Ram Shop Gokul Dham Ram Shop Gokul Dham Ram Shop
                      Flexible(
                          child: Text(
                              'Gokul Dham Ram Shop  Gokul Dham Ram Shop Gokul Dham Ram Shop Gokul Dham Ram Shop',
                              style: TextStyle(
                                fontSize: 13.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2)),
//             SizedBox(width: 5.0,),
                      Icon(
                        Icons.edit,
                        size: 13.5,
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
