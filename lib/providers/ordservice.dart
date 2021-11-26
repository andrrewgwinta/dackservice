import 'dart:async';
import 'dart:convert';

//import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utilities.dart';
import '../globals.dart' as global;

class ServiceItem {

  final String id;
  final String name;
  bool doned;
  final DateTime datePlan;
  final String orderId;
  final String orderName;
  final String machineId;
  final String machineName;
  final String serviceGroupId;
  final String atypeName;
  String workersIdString;
  bool expanded = false;

  //TODO строка персонала-выполнения

  ServiceItem({required this.id,
    required this.name,
    required this.doned,
    required this.machineId,
    required this.machineName,
    required this.datePlan,
    required this.orderId,
    required this.orderName,
    required this.serviceGroupId,
    required this.atypeName,
    required this.workersIdString,
    this.expanded = false});

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: json["id"].toString(),
      name: json["name"],
      doned: (json["doned"].toString() == '1'),
      datePlan: (json['datePlan'] != null)
          ? DateTime.parse(json['datePlan'])
          : DateTime(2000, 1, 1),
      machineId: json["machineId"].toString(),
      machineName: json["machineName"],
      orderId: json["orderId"].toString(),
      orderName: json["orderName"],
      serviceGroupId: json["serviceGroupId"].toString(),
      atypeName: json["atypeName"],
      workersIdString: json["workers"] ?? '',
      expanded: false,
    );
  }

  void updateOnServer(String newValue) async {
    print('in updateDoneIndormation newValue = $newValue');
    String toServer = (newValue == '')?newValue:
        newValue.substring(2, newValue.length - 2).replaceAll('^^', ',');

    workersIdString=newValue;

    doned = (newValue != '');

    final url = Uri.parse(
        '${API
            .prefixURL}do_update_doned.php?id=$id&machine=$machineId&value=$toServer&token=${global
            .token}');
    //print(url);

    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        //what?
      }
    } catch (error) {
      rethrow;
    }



  }
}

class OrdServices with ChangeNotifier {
  List<ServiceItem> _items = [];

  List<ServiceItem> get items {
    return [..._items];
  }

  Future<void> loadOrdServices() async {
    final Map<String, dynamic> queryParam = API.filterToJson;
    final String queryString = Uri(queryParameters: queryParam).query;
    final url = Uri.parse('${API.prefixURL}get_ordservises.php?$queryString');
    //print(url);
    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        final List<dynamic> loadJson = json.decode(response.body);
        final _loadedInformation =
        loadJson.map((json) => ServiceItem.fromJson(json)).toList();
        _items = _loadedInformation;
      }
    } catch (error) {
      rethrow;
    }
    //notifyListeners();
  }

  void updateDoneInformation(String id, String newValue){
    final updatedRecord = _items.firstWhere((element) => element.id == id);
    updatedRecord.updateOnServer(newValue);
    notifyListeners();
  }

}
