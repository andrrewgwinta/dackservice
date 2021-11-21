import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../utilities.dart';

class MachineItem {
  final String? id;
  final String? name;
  final String? serviceGroup;
  final String? childCount;

  MachineItem({@required this.id, this.name, this.childCount, this.serviceGroup});

  factory MachineItem.fromJson(Map<String, dynamic> json) {
    return MachineItem(
      id: json["id"].toString(),
      name: json["name"],
      serviceGroup: json["serviceGroup"].toString(),
      childCount: json["childCount"].toString(),
    );
  }

}

class Machines with ChangeNotifier {
  List<MachineItem> _items = [];

  List<MachineItem> get items {
    return [..._items];
  }

  List<NsiRecord> getListNsi() {
    List<NsiRecord> result = [];
    for (var data in _items) {
      result.add(NsiRecord(id: data.id!, name: data.name!));
    }
    return result;
  }

  // List<NsiRecord> get nsiItems {
  //   return[...NsiRecord(id:_items.id, name:_items.name)]
  // }


  Future<void> loadOrdMachines() async {

    final url = Uri.parse('${API.prefixURL}get_machines.php');
    //print(url);
    try {
      final response = await http.get(url, );
      if (response.statusCode == 200) {
        final List<dynamic> userJson = json.decode(response.body);
        final _loadedInformation =
        userJson.map((json) => MachineItem.fromJson(json)).toList();
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
