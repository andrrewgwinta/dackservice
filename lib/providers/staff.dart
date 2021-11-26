import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../utilities.dart';

class Worker {
  //c1.ID, c1.NAME, c2.PSERVICEGROUP_ID, c2.QUALIFICATION, c3.MACHINES_ID, c4.VAL
  final String? id;
  final String? name;
  final String? serviceGroupId;
  final String? qualification;
  final String? machineId;
  final String? val;

  Worker({
    this.id,
    this.name,
    this.serviceGroupId,
    this.qualification,
    this.machineId,
    this.val,
  });

  int? get npp => int.parse(val!);

  @override
  String toString() => 'id=$id name=$name machine=$machineId';

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json["id"].toString(),
      name: json["name"],
      serviceGroupId: json["serviceGroup"].toString(),
      qualification: json["qualification"].toString(),
      machineId: json["machineId"].toString(),
      val: json["npp"].toString(),
    );
  }
}

class Staff with ChangeNotifier {
  List<Worker> _items = [];

  List<Worker> get items {
    return [..._items];
  }

  Future<void> loadStaff() async {
    final url = Uri.parse('${API.prefixURL}get_staff.php');
    //print(url);
    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        final List<dynamic> loadJson = json.decode(response.body);
        final _loadedInformation =
            loadJson.map((json) => Worker.fromJson(json)).toList();
        _items = _loadedInformation;
      }
    } catch (error) {
      rethrow;
    }
  }

  List<NsiRecord> getWorkersList(String machineId, String codeString) {
    List<NsiRecord> result = [];
    for (var element in _items) {
      if (element.machineId == machineId) {
        
        result.insert(
            0,
            NsiRecord(
                id: (element.id ?? ''),
                //name: '${element.val.toString()} ${element.name}',
                name:element.name ?? '',
                npp: element.npp ?? 0,
                checked: codeString.contains('^${element.id}^')));
      }
    }
    result.sort((
      a,
      b,
    ) =>
        a.npp.compareTo(b.npp));
    return result;
  }
}
