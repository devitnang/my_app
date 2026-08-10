import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:my_app/helper/product_card.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/models/menu_item.dart';
import 'package:my_app/models/grocery.dart';
import 'package:my_app/helper/grocery_card.dart';
import 'package:my_app/helper/page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  // int _selectedIndex = 0;

  List<Product> products = [
    Product(
      id: 1,
      name: 'Organic Banana',
      description: '7pcs, Price',
      price: 4.99,
      image: 'assets/images/banana.png',
    ),
    Product(
      id: 2,
      name: 'Red Apple',
      description: '1Kg, Price',
      price: 8.99,
      image: 'assets/images/apple.png',
    ),
    Product(
      id: 3,
      name: 'Organic Carrot',
      description: '1Kg, Price',
      price: 2.75,
      image: 'assets/images/carrot.png',
    ),
    Product(
      id: 4,
      name: 'Orange',
      description: '1Kg, Price',
      price: 6.79,
      image: 'assets/images/orange.png',
    ),
    Product(
      id: 5,
      name: 'Red Pepper',
      description: '1Kg, Price',
      price: 2.79,
      image: 'assets/images/Pepper.png',
    ),
    Product(
      id: 6,
      name: 'Tomato',
      description: '1Kg, Price',
      price: 7.99,
      image: 'assets/images/Tomato.png',
    ),
    Product(
      id: 7,
      name: 'Beef',
      description: '1Kg, Price',
      price: 19.99,
      image: 'assets/images/Beef.png',
    ),
    Product(
      id: 8,
      name: 'Broiler Chicken',
      description: '1Kg, Price',
      price: 22.99,
      image: 'assets/images/Chicken.png',
    ),
    Product(
      id: 9,
      name: 'Green Apple',
      description: '1Kg, Price',
      price: 12.99,
      image: 'assets/images/greenapple.png',
    ),
  ];

  final List<String> _sliders = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
  ];

  final List<Grocery> grocereies = [
    Grocery(id: 1, name: 'Pules', imageUrl: 'assets/images/Images.png'),
    Grocery(id: 2, name: 'Rices', imageUrl: 'assets/images/Images1.png'),
  ];

  final List<MenuItem> _menus = [
    MenuItem(label: 'Shop', icon: 'assets/images/svg/Shop.svg'),
    MenuItem(label: 'Explore', icon: 'assets/images/svg/Search.svg'),
    MenuItem(label: 'Cart', icon: 'assets/images/svg/Cart.svg'),
    MenuItem(label: 'Favorite', icon: 'assets/images/svg/Favorite.svg'),
    MenuItem(label: 'Account', icon: 'assets/images/svg/Account.svg'),
  ];

  int currentSlideIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(height: 60),
          Center(
            child: Column(
              children: [
                Image.asset('assets/images/Group.png'),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/Exclude.png'),
                    SizedBox(width: 8),
                    Text(
                      'Dhaka, Banassre',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          CupertinoSearchTextField(
            padding: EdgeInsets.all(12),
            backgroundColor: Color(0xFFF2F3F2),
            cursorColor: Colors.black,
            placeholder: 'Search your product',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Icon(CupertinoIcons.search, size: 24),
            ),
          ),

          SizedBox(height: 20),

          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                items: _sliders
                    .map(
                      (sliders) => Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(sliders, fit: BoxFit.fill),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 120,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    currentSlideIndex = index;
                    setState(() {});
                  },
                ),
              ),
              PageIndicator(
                itemCount: _sliders.length,
                currentIndex: currentSlideIndex,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Exclusive Offer',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 270,
            child: ListView(
              scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              primary: false,
              children: products
                  .take(3)
                  .map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(product: product),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Best Selling',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 270,
            child: ListView(
              scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              primary: false,
              children: products
                  .sublist(3)
                  .take(3)
                  .map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(product: product),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Groceries',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              primary: false,
              children: List.generate(
                grocereies.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GroceryCard(grocery: grocereies[index], index: index),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              primary: false,
              children: products
                  .sublist(6)
                  .map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(product: product),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          for (MenuItem item in _menus)
            BottomNavigationBarItem(
              icon: ImageIcon(Svg(item.icon)),
              label: item.label,
            ),
        ],
      ),
    );
  }
}
