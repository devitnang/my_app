import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/config/api_config.dart';
import 'package:my_app/models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isLoading = true;
  Product? product;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    try {
      final response = await ApiConfig.get('/products/${widget.id}');
      _isLoading = false;
      if (response.statusCode == 200) {
        final Product loadedProduct =
            Product.fromJson(json.decode(response.body));
        product = loadedProduct;
      }
    } catch (e) {
      _isLoading = false;
      debugPrint('Error fetching product ${widget.id}: $e');
    }
    if (mounted) setState(() {});
  }

  bool isDetailExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : product == null
          ? Center(child: Text('No data!'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF2F3F2),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            child: SafeArea(
                              child: Stack(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(30),
                                      child: Hero(
                                        tag: '${product!.id}',
                                        child: Image.network(
                                          product!.image,
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(
                                            Icons.image_not_supported,
                                            size: 80,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 8,
                            child: SafeArea(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.10,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: Icon(Icons.arrow_back_ios_new),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 8,
                            child: SafeArea(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.10,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.ios_share),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product!.name,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    product!.toggleFavorite();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    product!.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                  ),
                                  color: product!.isFavorite
                                      ? Colors.red.shade400
                                      : null,
                                ),
                              ],
                            ),
                            Text(
                              product!.subtitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    product!.decreaseQty();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.remove_rounded,
                                    size: 18,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    minWidth: 48,
                                    maxHeight: 48,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                  child: Text(
                                    '${product!.quantity}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    product!.increaseQty();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.add_rounded,
                                    size: 18,
                                    color: Color(0xFF53B175),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '\$${(product!.price * product!.quantity).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(color: Colors.black12, height: 1),
                            InkWell(
                              onTap: () => setState(
                                () => isDetailExpanded = !isDetailExpanded,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Product Detail',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Icon(
                                      isDetailExpanded
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_right,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isDetailExpanded)
                              Padding(
                                padding: EdgeInsets.only(bottom: 12),
                                child: Text(
                                  product!.description,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            Divider(color: Colors.black12, height: 1),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nutritions',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            '100g',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: Colors.black12, height: 1),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Review',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(
                                            5,
                                            (index) => Icon(
                                              Icons.star,
                                              color: Color(0xFFF3603F),
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 24,
                    top: 10,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'Added Item To Cart');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF53B175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Add To Basket',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
