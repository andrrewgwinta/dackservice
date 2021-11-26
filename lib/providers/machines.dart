import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../utilities.dart';

class MachineItem {
  final String? id;
  final String? name;
  final String? serviceGroupId;
  final String? childCount;
  final String? userId;

  MachineItem({@required this.id, this.name, this.childCount, this.serviceGroupId, this.userId});

  factory MachineItem.fromJson(Map<String, dynamic> json) {
    return MachineItem(
      id: json["id"].toString(),
      name: json["name"],
      serviceGroupId: json["serviceGroup"].toString(),
      childCount: json["childCount"].toString(),
      userId: json["userId"].toString(),
    );
  }

}

class Machines with ChangeNotifier {
  List<MachineItem> _items = [];

  List<MachineItem> get items {
    return [..._items];
  }

  bool isExistId(String id, List<NsiRecord> list){
    bool result = false;
    for(var data in list) {
      if (data.id == id) {
        result = true;
        break;
      }
    }
    return result;
  }

  List<NsiRecord> getMachinesDistinct() {
    List<NsiRecord> result = [];
    for (var data in _items) {
      if (!isExistId(data.id!, result)) {
      result.add(NsiRecord(id: data.id!, name: data.name!));
      }
    }
    return result;
  }

  List<NsiRecord> getMachinesByUser(String userId) {
    List<NsiRecord> result = [];
    for (var data in _items) {
      if (data.userId == userId) {
        result.add(NsiRecord(id: data.id!, name: data.name!));
      }
    }
    return result;
  }

  // List<NsiRecord> get nsiItems {
  //   return[...NsiRecord(id:_items.id, name:_items.name)]
  // }


  Future<void> loadOrdMachines() async {
    // insert into LNK_MACHINES_MACHINES values (23009, 23009);
    // insert into LNK_MACHINES_MACHINES values (23006, 23006);
    // insert into LNK_MACHINES_MACHINES values (23010, 23010);

    final url = Uri.parse('${API.prefixURL}get_machines.php');
    //print(url);
    try {
      final response = await http.get(url, );
      if (response.statusCode == 200) {
        final List<dynamic> loadJson = json.decode(response.body);
        final _loadedInformation =
        loadJson.map((json) => MachineItem.fromJson(json)).toList();
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
