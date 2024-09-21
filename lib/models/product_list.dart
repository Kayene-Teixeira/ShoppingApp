import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

// Mixin que ajuda com a reatividade
class ProductList with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  // Clonando lista e retornando
  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
