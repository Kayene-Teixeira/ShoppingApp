import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/contants.dart';

// Mixin que ajuda com a reatividade
class ProductList with ChangeNotifier {
  List<Product> _items = [];
  // bool _showFavoriteOnly = false;

  // Clonando lista e retornando
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json'),
    );

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(Product(
        id: productId,
        name: productData['name'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'],
      ));
    });
    notifyListeners();
  }

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
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json'), //url -  necessario terminar em .json
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

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      http.patch(
        Uri.parse(
            '${Constants.PRODUCT_BASE_URL}/${product.id}.json'), //url -  necessario terminar em .json
        body: jsonEncode(
          {
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl
          },
        ), //objeto que eu quero passar
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      final products = _items[index];
      _items.remove(product);
      notifyListeners();

      final response =
          await http.delete(Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json'));

      if (response.statusCode >= 400) {
        _items.insert(index, products);
        notifyListeners();
        throw HttpException(
          message: 'Não foi possível excluir o produto',
          statusCode: response.statusCode,
        );
      }
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
