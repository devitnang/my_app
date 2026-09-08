import 'package:flutter/material.dart';
import 'package:my_app/providers/category_provider.dart';
import 'package:my_app/providers/grocery_provider.dart';
import 'package:my_app/providers/home_provider.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => GroceryProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
    ];
  }

  static const String _tokenKey = 'sv8.16.pos.tokens';

  String? _token;
  bool _isLoading = true;

  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  /// Load token from SharedPreferences
  Future<void> loadToken() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);

    _isLoading = false;
    notifyListeners();
  }

  /// Save token after successful login
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    _token = token;
    notifyListeners();
  }

  /// Clear token on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    _token = null;
    notifyListeners();
  }
}
