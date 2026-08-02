import 'package:flutter/material.dart';
import 'package:my_app/models/grocery.dart';

class GroceryCard extends StatelessWidget {
  final Grocery grocery;
  final int index;
  const GroceryCard({super.key, required this.grocery, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<Color> cardColors = [
      Colors.yellow.shade200,
      Colors.green.shade200,
      Colors.orange.shade200,
    ];

    return Container(
      width: 220,
      height: 90,
      decoration: BoxDecoration(
        color: cardColors[index % cardColors.length],
        // color: Colors.yellow.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(grocery.imageUrl, width: 60),
          SizedBox(width: 16),
          Text(
            grocery.name,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
