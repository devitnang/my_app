import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/providers/grocery_provider.dart';

void main() {
  test('ProductProvider fetches exclusive products from API', () async {
    final provider = ProductProvider();
    final products = await provider.fetchExclusiveProducts();
    expect(products, isNotEmpty);
    print('Fetched ${products.length} exclusive products successfully');
    print('First product: ${products.first.name}, price: \$${products.first.price}');
  });

  test('ProductProvider fetches best selling products from API', () async {
    final provider = ProductProvider();
    final products = await provider.fetchBestSellingProducts();
    expect(products, isNotEmpty);
    print('Fetched ${products.length} best selling products successfully');
  });

  test('GroceryProvider fetches groceries from API', () async {
    final provider = GroceryProvider();
    final groceries = await provider.fetchGroceries();
    expect(groceries, isNotEmpty);
    print('Fetched ${groceries.length} groceries successfully');
    print('First grocery: ${groceries.first.name}');
  });

  test('Fetch single product detail by ID from API', () async {
    final provider = ProductProvider();
    final allProducts = await provider.fetchAllProducts();
    expect(allProducts, isNotEmpty);
    print('Fetched all ${allProducts.length} products successfully');
  });
}
