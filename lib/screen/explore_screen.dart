import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/helper/category_card.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/widget/bottom_navigation.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Category> categories = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(height: 56),
          Center(
            child: Text(
              'Find Products',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 33),
          CupertinoSearchTextField(
            padding: EdgeInsets.all(12),
            backgroundColor: Color(0xFFF2F3F2),
            cursorColor: Colors.black,
            placeholder: 'Search Store',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Icon(CupertinoIcons.search, size: 24, color: Colors.black),
            ),
          ),

          GridView.builder(
            padding: const EdgeInsets.only(top: 20),
            shrinkWrap: true,
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17,
              mainAxisSpacing: 20,
              childAspectRatio: 175 / 220,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(category: categories[index], index: index);
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
    );
  }
}
