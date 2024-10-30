import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

// Mixin que ajuda com a reatividade
class ProductList with ChangeNotifier {
  // Aponta para o banco de dados
  final _baseUrl = 'https://shop-coder-flut-default-rtdb.firebaseio.com';
  List<Product> _items = DUMMY_PRODUCTS;
  // bool _showFavoriteOnly = false;

  // Clonando lista e retornando
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    // Só quando a resposta está pronta é que eu vou executar o código após o post
    // Criando no firebase
    final response = await http.post(
      Uri.parse('$_baseUrl/products.json'), //url -  necessario terminar em .json
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        },
      ), //objeto que eu quero passar
    );

    // Adicionando o novo item no array de produtos local
      final id = jsonDecode(response.body)['name'];
      _items.add(
        Product(
          id: id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          isFavorite: product.isFavorite,
        ),
      );
      notifyListeners();
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  void deleteProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items.removeWhere((element) => element.id == product.id);
      notifyListeners();
    }
  }

  int get itemsCount {
    return _items.length;
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
