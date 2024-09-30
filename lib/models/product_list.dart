import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

// Mixin que ajuda com a reatividade
class ProductList with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;
  bool _showFavoriteOnly = false;

  // Clonando lista e retornando
  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((product) => product.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}

// if (_showFavoriteOnly) {
//   return _items.where((product) => product.isFavorite).toList();
// }


// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }

// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
