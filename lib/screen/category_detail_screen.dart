import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/api_config.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/helper/product_card.dart';

class CategoryDetailScreen extends StatefulWidget {
  final Category category;
  final int index;
  const CategoryDetailScreen({
    super.key,
    required this.category,
    required this.index,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  bool _isLoading = true;
  List<Product> products = [];

  final List<Color> _headerColors = [
    const Color(0x1A53B175), // Light Green
    const Color(0x1AF8A44C), // Light Orange
    const Color(0x1AF7A593), // Light Pink
    const Color(0x40D3B0E0), // Light Purple
    const Color(0x40FDE598), // Light Yellow
    const Color(0x40B7DFF5), // Light Blue
  ];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    try {
      final response = await ApiConfig.get('/products');
      _isLoading = false;
      if (response.statusCode == 200) {
        for (var element in json.decode(response.body)) {
          products.add(Product.fromJson(element));
        }
      }
    } catch (e) {
      _isLoading = false;
      debugPrint('Error fetching products for category: $e');
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color headerColor =
        _headerColors[widget.index % _headerColors.length];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with category image and name
          Container(
            width: double.infinity,
            color: headerColor,
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        if (widget.category.images != null)
                          Image.asset(
                            widget.category.images!,
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        SizedBox(height: 12),
                        Text(
                          widget.category.name ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Product grid
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning_amber, size: 80, color: Colors.red),
                        SizedBox(height: 16),
                        Text('No products found!'),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
