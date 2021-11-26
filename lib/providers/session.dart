import 'dart:async';
import 'dart:convert';

import 'package:dackservice/utilities.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as global;
import '../utilities.dart';

class Session with ChangeNotifier {
  Future<void> loadSavedSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    global.userId = preferences.getString('userId') ?? '';
    global.userName = preferences.getString('userName') ?? '';
    //global.token = preferences.getString('token') ?? '';
    global.machineId = preferences.getString('machineId') ?? '';
    global.machineName = preferences.getString('machineName') ?? '';

    //global.serverName = preferences.getString('serverName') ?? '';
    global.serverName = '91.237.235.227:8012';

    print('in loadSession  ${global.machineId} ${global.userId}');
  }

  Future<void> loadSavedFilter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    global.filterDate = DateTime.now();

    if (preferences.containsKey('filterData')) {
      try {
        final extractedFilterData =
            json.decode(preferences.getString('filterData')!)
                as Map<String, Object>;

        global.fltDateType = FilterDateType
            .values[int.parse(extractedFilterData['fltDateType'].toString())];

        global.fltMachineType = FilterMachineType.values[
            int.parse(extractedFilterData['fltMachineType'].toString())];

        global.fltOrdNum = extractedFilterData['fltOrdNum'].toString();
        global.fltOrdPerson = extractedFilterData['fltOrdPerson'].toString();
        global.fltOrdNum1C = extractedFilterData['fltOrdNum1c'].toString();
      } catch (error) {
        print('null in catch -> create');
      }
    } else {
      setDefaultFilter();
    }
  }

  void setDefaultFilter() {
    global.fltDateType = FilterDateType.fdtOneDay;
    global.fltOrdNum = '';
    global.fltOrdPerson = '';
    global.fltOrdNum1C = '';
    global.fltMachineType = FilterMachineType.fmtOnlyCurrent;
    notifyListeners();
  }

  Future<void> saveCurrentSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('userId', global.userId);
    preferences.setString('userName', global.userName);
    //preferences.setString('token', global.token);
    preferences.setString('serverName', global.serverName);
    preferences.setString('machineId', global.machineId);
    preferences.setString('machineName', global.machineName);
    print('in saveSession  ${global.machineId} ${global.userId}');
    notifyListeners();
  }

  Future<void> saveCurrentFilter() async {
    // print('in save filter ');
    // print('global.fltDateType=${global.fltDateType}');
    // print('global.fltMachineType=${global.fltMachineType}');
    SharedPreferences preferences = await SharedPreferences.getInstance();
     final filterData = json.encode(API.filterToJson);

    print("global.fltOrdNum ${global.fltOrdNum}");
    // final filterData = json.encode({
    //   'fltOrdNum': global.fltOrdNum,
    //   'fltOrdPerson': global.fltOrdPerson,
    //   'fltOrdNum1c': global.fltOrdNum1C,
    //   'fltDateType': global.fltDateType.index.toString(),
    //   'fltMachineType': global.fltMachineType.index.toString()
    // });
    await preferences.setString('filterData', filterData);
    //notifyListeners();
  }

  void setServerName(String value) {
    global.serverName = value;
  }

// String get userId => global.userId;
//
// String get userName => global.userId;
//
// String get token => global.userId;
//
// String get serverName => global.userId;
//
// String get machinesId => global.machineId;
//
// String get machinesName => global.machineName;
//
// bool get noServer => (global.serverName == '');
//
// bool get noUser => (global.userId == '');
//
// bool get noToken => (global.token == '');
//
// void setUserId(String value) {
//   global.userId = value;
// }
//
// void setUserName(String value) {
//   global.userName = value;
// }
//
// void setMachinesId(String value) {
//   global.userId = value;
// }
//
// void setMachinesName(String value) {
//   global.userName = value;
// }
//
// void setToken(String value) {
//   global.token = value;
// }
//
}
