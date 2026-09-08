import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/screen/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProductDetailScreen(id: product.id),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final tween = Tween(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeInOut));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          ),
        );
      },
      child: Container(
        width: 190,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(
          top: 16,
          left: 14,
          right: 14,
          bottom: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: '${product.id}',
                child: Image.network(
                  product.image,
                  width: 90,
                  height: 90,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              product.subtitle.isNotEmpty
                  ? product.subtitle
                  : product.description,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white, size: 20),
                    constraints: const BoxConstraints.tightFor(
                      width: 36,
                      height: 36,
                    ),
                    padding: EdgeInsets.zero,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
