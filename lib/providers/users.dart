import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';


import '../utilities.dart';
import '../globals.dart' as global;


class User {
  final String? id;
  final String? name;
  final String? machineId;

  User({@required this.name, this.id, this.machineId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"].toString(),
      name: json["name"],
      machineId: json["machineId"].toString(),
    );
  }



}

class Users with ChangeNotifier {
  List<User> _items=[];

  List<User> get items {
    return [..._items];
  }

  Future<void> doLogin(String password) async {
    final url =
    Uri.parse('${API.prefixURL}do_login.php?id=${global.userId}&gs=$password');
    print(url);
    try {

      final response = await http.post(url);
      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData.startsWith('error')){
          global.token = '';
        } else {
          global.token = responseData;
        }
      }
    } catch (error) {
      print('in catch');
      //print('in authenticate connect error&clear token');
      global.token = '';
      rethrow;
    }
  }


  List<NsiRecord> getListNsi(String machineId) {
    List<NsiRecord> result = [];
    for (var data in _items)  {
      if (data.machineId == machineId) {
        result.add(NsiRecord(id: data.id!, name: data.name!));
      }
    }
    return result;
  }

  Future<void> loadUsers() async {

    final url = Uri.parse('${API.prefixURL}get_employee.php');
    //print(url);
    try {
      final response = await http.get(url, );
      if (response.statusCode == 200) {
        final List<dynamic> userJson = json.decode(response.body);
        final _loadedInformation =
        userJson.map((json) => User.fromJson(json)).toList();
        _items = _loadedInformation;
      }
    } catch (error) {
      rethrow;
    }
  }

  String getNameById(String id){
    try {
      final selectedName = _items.firstWhere((element) => element.id==id).name;
      return selectedName!;
    } catch (e) {
      return '';
    }
  }


}

