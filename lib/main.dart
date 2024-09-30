import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/views/cart_view.dart';
import 'package:shop/views/product_detail_view.dart';
import 'package:shop/views/products_overview_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.red,
          ),
          textTheme: theme.textTheme.copyWith(
            titleLarge: theme.textTheme.titleLarge?.copyWith(
              fontFamily: 'Lato',
            ),
          ),
        ),
        routes: {
          AppRoutes.HOME: (context) => ProductsOverviewView(),
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailView(),
          AppRoutes.CART: (context) => const CartView(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
