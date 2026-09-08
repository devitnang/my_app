import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/api_config.dart';
import 'package:my_app/models/grocery.dart';

class GroceryProvider extends ChangeNotifier {
  Future<List<Grocery>> fetchGroceries() async {
    final response = await ApiConfig.get('/grocery');
    List<Grocery> groceries = [];
    for (var element in json.decode(response.body)) {
      groceries.add(Grocery.fromJson(element));
    }
    return groceries;
  }
}

