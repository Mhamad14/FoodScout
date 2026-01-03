import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favoriteRestaurantNames = [];
  static const String _favoritesKey = 'favorite_restaurants';

  List<String> get favoriteRestaurantNames => _favoriteRestaurantNames;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteRestaurantNames = prefs.getStringList(_favoritesKey) ?? [];
    notifyListeners();
  }

  Future<void> toggleFavorite(String restaurantName) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favoriteRestaurantNames.contains(restaurantName)) {
      _favoriteRestaurantNames.remove(restaurantName);
    } else {
      _favoriteRestaurantNames.add(restaurantName);
    }

    notifyListeners();
    await prefs.setStringList(_favoritesKey, _favoriteRestaurantNames);
  }

  bool isFavorite(String restaurantName) {
    return _favoriteRestaurantNames.contains(restaurantName);
  }
}
