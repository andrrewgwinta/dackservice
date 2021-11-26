import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../utilities.dart';
import '../globals.dart' as global;

class Article {
  final String? id;
  final String? name;
  final double? quantity;
  final double? price;
  //final double _cost;

  String get sQuantity => (quantity ?? 0).toStringAsFixed(2) ;
  String get sPrice => (price ?? 0).toStringAsFixed(2);
  String get sCost => ((quantity ?? 0) * (price ?? 0) * 10).toStringAsFixed(2);

  Article({this.id, this.name, this.price, this.quantity});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["id"].toString(),
      name: json["name"],
      quantity: double.parse(json["quantity"].toString()),
      price: double.parse(json["quantity"].toString()),
    );
  }
}

class OrdArticles with ChangeNotifier {
  List<Article> _items = [];

  List<Article> get items {
    return [..._items];
  }

  Future<void> loadArticle(String orderId) async {
    final url = Uri.parse(
        '${API.prefixURL}get_ordarticle.php?orderId=$orderId&token=${global.token}');
    //print(url);
    try {
      final response = await http.get(url,);
      if (response.statusCode == 200) {
        final List<dynamic> loadJson = json.decode(response.body);
        final _loadedInformation =
        loadJson.map((json) => Article.fromJson(json)).toList();
        _items = _loadedInformation;
      }
    } catch (error) {
      rethrow;
    }
  }

}