import 'package:flutter/material.dart';
import 'package:shop/components/product_grid.dart';

class ProductsOverviewView extends StatelessWidget {
  ProductsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Minha Loja',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ProductGrid(),
    );
  }
}
