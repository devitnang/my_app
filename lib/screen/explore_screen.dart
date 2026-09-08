import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/helper/category_card.dart';
import 'package:my_app/providers/category_provider.dart';
import 'package:my_app/screen/category_detail_screen.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryProvider>().categories;

    return ListView(
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
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 17,
            mainAxisSpacing: 20,
            childAspectRatio: 175 / 220,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    reverseTransitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CategoryDetailScreen(
                          category: categories[index],
                          index: index,
                        ),
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
              child: CategoryCard(category: categories[index], index: index),
            );
          },
        ),
      ],
    );
  }
}

