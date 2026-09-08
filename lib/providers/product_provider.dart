import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/api_config.dart';
import 'package:my_app/models/product.dart';

class ProductProvider extends ChangeNotifier {
  Future<List<Product>> fetchExclusiveProducts() async {
    final response = await ApiConfig.get('/products/exclusive');
    List<Product> products = [];
    for (var element in json.decode(response.body)) {
      products.add(Product.fromJson(element));
    }
    return products;
  }

  Future<List<Product>> fetchBestSellingProducts() async {
    final response = await ApiConfig.get('/products/best-selling');
    List<Product> products = [];
    for (var element in json.decode(response.body)) {
      products.add(Product.fromJson(element));
    }
    return products;
  }

  Future<List<Product>> fetchAllProducts() async {
    final response = await ApiConfig.get('/products');
    List<Product> products = [];
    for (var element in json.decode(response.body)) {
      products.add(Product.fromJson(element));
    }
    return products;
  }
}

