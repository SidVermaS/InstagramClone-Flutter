import 'dart:async';
import 'package:eventapp/networks/connect.dart';
import 'package:eventapp/utils/regex.dart';
import 'package:eventapp/utils/routes.dart';
import 'package:eventapp/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/models/user.dart';

class Global  {
  static User user;
  static Routes routes=Routes();
  static Connect connect=Connect();
  static Regex regex=Regex();
  static SharedPrefManager sharedPrefManager=SharedPrefManager();

  static String currentScreenType = 'home';


}