import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';
import 'dart:math';

class CategoryCard extends StatelessWidget {
  final Category category;
  final int index;
  const CategoryCard({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<Color> cardColors = [
      const Color(0x1A53B175), // Light Green
      const Color(0x1AF8A44C), // Light Orange
      const Color(0x1AF7A593), // Light Pink
      const Color(0x40D3B0E0), // Light Purple
      const Color(0x40FDE598), // Light Yellow
      const Color(0x40B7DFF5), // Light Blue
    ];

    final List<Color> borderColors = [
      const Color(0xB253B175),
      const Color(0xB2F8A44C),
      const Color(0xB2F7A593),
      const Color(0xB2D3B0E0),
      const Color(0xB2FDE598),
      const Color(0xB2B7DFF5),
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColors[index % cardColors.length],
        border: Border.all(
          color: borderColors[index % borderColors.length],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Center(child: Image.asset(category.images!, width: 100)),
          ),
          SizedBox(height: 8),
          Text(
            category.name!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
