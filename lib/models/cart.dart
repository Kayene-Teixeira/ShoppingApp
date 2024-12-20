import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (value) => CartItem(
                id: value.id,
                productId: value.productId,
                name: value.name,
                quantity: value.quantity + 1,
                price: value.price,
              ));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
                id: Random().nextDouble().toString(),
                productId: product.id,
                name: product.name,
                quantity: 1,
                price: product.price,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String product_id) {
    if (!_items.containsKey(product_id)) {
      return;
    }

    if (_items[product_id]?.quantity == 1) {
      _items.remove(product_id);
    } else {
      _items.update(
          product_id,
          (value) => CartItem(
                id: value.id,
                productId: value.productId,
                name: value.name,
                quantity: value.quantity - 1,
                price: value.price,
              ));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
