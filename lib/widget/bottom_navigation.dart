import 'package:flutter/material.dart';
import 'package:my_app/models/menu_item.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:my_app/screen/home_screen.dart';
import 'package:my_app/screen/explore_screen.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNavigation({super.key, required this.currentIndex, this.onTap});

  static final List<MenuItem> _menus = [
    MenuItem(label: 'Shop', icon: 'assets/images/svg/Shop.svg'),
    MenuItem(label: 'Explore', icon: 'assets/images/svg/Search.svg'),
    MenuItem(label: 'Cart', icon: 'assets/images/svg/Cart.svg'),
    MenuItem(label: 'Favorite', icon: 'assets/images/svg/Favorite.svg'),
    MenuItem(label: 'Account', icon: 'assets/images/svg/Account.svg'),
  ];

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
    }

    if (index == currentIndex) return;

    Widget? targetScreen;
    switch (index) {
      case 0:
        targetScreen = const HomeScreen();
        break;
      case 1:
        targetScreen = const ExploreScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => targetScreen!,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleTap(context, index),
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
    );
  }
}
