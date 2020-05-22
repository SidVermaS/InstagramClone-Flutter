import 'dart:convert';

import 'package:eventflutterapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:eventflutterapp/localizations/my_localizations.dart';
import 'package:eventflutterapp/screens/home.dart';
import 'package:eventflutterapp/screens/login.dart';
import 'package:eventflutterapp/utils/global_variables_and_methods.dart';
import 'package:eventflutterapp/localizations/my_localizations.dart';
import 'package:eventflutterapp/utils/global_variables_and_methods.dart';
import 'package:eventflutterapp/utils/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefManager.getSharedPref().then((SharedPreferences sharedPreferences) {
    SharedPrefManager.getValue('user').then((String userString) {
      print('~~~ userString: $userString');
      if (userString != null) {
        GlobalVariablesAndMethods.user =
            User.fromJsonGlobalVariablesAndMethods(
                jsonDecode(userString));
        print('~~~ 0th');
      }
      print('~~~ 1st');
      runApp(Phoenix(child: MyApp()));
    });
  });
}
class MyApp extends StatefulWidget  {
  _MyAppState createState()=>_MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state =
    context.ancestorStateOfType(TypeMatcher<_MyAppState>());

    state.setState(() {
      state.locale = newLocale;
    });
  }
}
class _MyAppState extends State<MyApp> {

  Locale locale;
  bool localeLoaded = false;

  @override
  void initState() {
    super.initState();

    this._fetchLocale().then((locale) {
      setState(() {
        this.localeLoaded = true;
        this.locale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if (this.localeLoaded == false) {
      return CircularProgressIndicator();
    } else {
      return MaterialApp(
          title: 'eventflutterapp',
          theme: ThemeData(
              primaryColor: Colors.blue
          ),
          debugShowCheckedModeBanner: false,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            if (this.locale == null) {
              this.locale = deviceLocale;
            }
            return this.locale;
          },
          localizationsDelegates: [
            MyLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('hi', ''),
          ],
          home:GlobalVariablesAndMethods.user==null?Login():Home()
      );
    }
  }
  Future<Locale> _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      return null;
    }
    return Locale(prefs.getString('language_code'),
        '');
  }
}