import 'package:flutter/material.dart';
import 'package:my_app/models/grocery.dart';
import 'dart:math';

class GroceryCard extends StatelessWidget {
  final Grocery grocery;
  final int index;
  const GroceryCard({super.key, required this.grocery, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 90,
      decoration: BoxDecoration(
        color: Color.fromRGBO(
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
          0.1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            grocery.imageUrl,
            width: 55,
            height: 55,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image_not_supported,
              size: 40,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              grocery.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
