import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  final List<Category> categories = [
    Category(name: 'Beverages & Drinks', images: 'assets/images/cat1.png'),
    Category(
      name: 'Fresh Produce & Vegetables',
      images: 'assets/images/cat2.png',
    ),
    Category(
      name: 'Oils, Condiments & Cooking Essentials',
      images: 'assets/images/cat3.png',
    ),
    Category(
      name: 'Fresh Meat, Seafood & Poultry',
      images: 'assets/images/cat4.png',
    ),
    Category(name: 'Bakery, Breads & Grains', images: 'assets/images/cat5.png'),
    Category(name: 'Dairy & Eggs', images: 'assets/images/cat6.png'),
  ];
}
