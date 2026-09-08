import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:my_app/helper/grocery_card.dart';
import 'package:my_app/helper/page_indicator.dart';
import 'package:my_app/helper/product_card.dart';
import 'package:my_app/models/grocery.dart';
import 'package:my_app/models/menu_item.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/grocery_provider.dart';
import 'package:my_app/providers/home_provider.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/screen/explore_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  final List<MenuItem> _menus = [
    MenuItem(label: 'Shop', icon: 'assets/images/svg/Shop.svg'),
    MenuItem(label: 'Explore', icon: 'assets/images/svg/Search.svg'),
    MenuItem(label: 'Cart', icon: 'assets/images/svg/Cart.svg'),
    MenuItem(label: 'Favorite', icon: 'assets/images/svg/Favorite.svg'),
    MenuItem(label: 'Account', icon: 'assets/images/svg/Account.svg'),
  ];

  int currentSlideIndex = 0;

  final List<Widget> _pages = [
    const _ShopPage(),
    const ExploreScreen(),
    const Center(child: Text('Cart')),
    const Center(child: Text('Favorite')),
    const Center(child: Text('Account')),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  late final AnimationController _animationController;
  late final Animation<double> _animation;

  double positionX = 0;
  double size = 100;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (_, value, _) =>
            IndexedStack(index: value.currentIndex, children: [..._pages]),
      ),
      bottomNavigationBar: Consumer<HomeProvider>(
        builder: (_, value, _) => BottomNavigationBar(
          currentIndex: value.currentIndex,
          onTap: (index) {
            value.onTap(index);
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
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
      ),
    );
  }
}

/// The Shop tab content (extracted from the old HomeScreen body)
class _ShopPage extends StatefulWidget {
  const _ShopPage();

  @override
  State<_ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<_ShopPage> {
  final List<String> _sliders = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
  ];

  int currentSlideIndex = 0;

  Future<List<Product>>? _exclusiveProducts;
  Future<List<Product>>? _bestSellingProducts;
  Future<List<Grocery>>? _groceries;

  @override
  void initState() {
    super.initState();
    final productProvider = context.read<ProductProvider>();
    final groceryProvider = context.read<GroceryProvider>();
    _exclusiveProducts = productProvider.fetchExclusiveProducts();
    _bestSellingProducts = productProvider.fetchBestSellingProducts();
    _groceries = groceryProvider.fetchGroceries();
  }

  Widget _buildProductsError() {
    return SizedBox(
      height: 270,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber, size: 48, color: Colors.red),
            SizedBox(height: 8),
            Text('Failed to load data!'),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsLoading({double height = 270}) {
    return SizedBox(
      height: height,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
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
        FutureBuilder<List<Product>>(
          future: _exclusiveProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildProductsLoading();
            }
            if (snapshot.hasError) {
              debugPrint('Exclusive products error: ${snapshot.error}');
              return _buildProductsError();
            }
            final products = snapshot.data ?? [];
            return SizedBox(
              height: 270,
              child: ListView(
                scrollDirection: Axis.horizontal,
                primary: false,
                children: products
                    .map(
                      (product) => Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ProductCard(product: product),
                      ),
                    )
                    .toList(),
              ),
            );
          },
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
        FutureBuilder<List<Product>>(
          future: _bestSellingProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildProductsLoading();
            }
            if (snapshot.hasError) {
              debugPrint('Best selling products error: ${snapshot.error}');
              return _buildProductsError();
            }
            final products = snapshot.data ?? [];
            return SizedBox(
              height: 270,
              child: ListView(
                scrollDirection: Axis.horizontal,
                primary: false,
                children: products
                    .map(
                      (product) => Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ProductCard(product: product),
                      ),
                    )
                    .toList(),
              ),
            );
          },
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
        FutureBuilder<List<Grocery>>(
          future: _groceries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildProductsLoading(height: 100);
            }
            if (snapshot.hasError) {
              debugPrint('Groceries error: ${snapshot.error}');
              return _buildProductsError();
            }
            final groceries = snapshot.data ?? [];
            return SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                primary: false,
                children: List.generate(
                  groceries.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GroceryCard(grocery: groceries[index], index: index),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
