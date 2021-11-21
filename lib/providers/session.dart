import 'dart:async';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as global;

class Session with ChangeNotifier  {

  Future<void> loadSavedSession() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    global.userId  = preferences.getString('userId') ?? '';
    global.userName = preferences.getString('userName') ?? '';
    //global.token = preferences.getString('token') ?? '';
    global.machineId =preferences.getString('machineId') ?? '';
    global.machineName =preferences.getString('machineName') ?? '';

    //global.serverName = preferences.getString('serverName') ?? '';
    global.serverName = '91.237.235.227:8012';

    print('in loadSession  ${global.machineId} ${global.userId}' );

  }

  Future<void> saveCurrentSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('userId', global.userId);
    preferences.setString('userName', global.userName);
    //preferences.setString('token', global.token);
    preferences.setString('serverName', global.serverName);
    preferences.setString('machineId', global.machineId);
    preferences.setString('machineName', global.machineName);
    print('in saveSession  ${global.machineId} ${global.userId}' );
    notifyListeners();
  }

  String get userId => global.userId;
  String get userName => global.userId;
  String get token => global.userId;
  String get serverName => global.userId;
  String get machinesId => global.machineId;
  String get machinesName => global.machineName;

  bool get noServer => (global.serverName == '');
  bool get noUser => (global.userId == '');
  bool get noToken => (global.token == '');

  void setUserId(String value){
    global.userId = value;
  }

  void setUserName(String value){
    global.userName = value;
  }

  void setMachinesId(String value){
    global.userId = value;
  }

  void setMachinesName(String value){
    global.userName = value;
  }

  void setToken(String value){
    global.token = value;
  }

  void setServerName(String value){
    global.serverName = value;
  }
}

