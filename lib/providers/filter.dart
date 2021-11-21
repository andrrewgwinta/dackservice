import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as global;
class Filter with ChangeNotifier{
  DateTime currentDate = DateTime.now();

  Future<void> loadSavedFilter() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    global.filterDate  = DateTime.now();


  }


}