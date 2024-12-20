import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/views/auth_home_view.dart';
import 'package:shop/views/cart_view.dart';
import 'package:shop/views/orders_view.dart';
import 'package:shop/views/product_detail_view.dart';
import 'package:shop/views/product_form_view.dart';
import 'package:shop/views/product_view.dart';

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
          create: (_) => Auth(),
        ),
        // Provider abaixo depende do de cima
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(), //cria
          // atualiza
          update: (context, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (context, auth, previous) {
            return OrderList(auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
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
          AppRoutes.AUTH_HOME: (context) => const AuthHomeView(),
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailView(),
          AppRoutes.CART: (context) => const CartView(),
          AppRoutes.ORDERS: (context) => const OrdersView(),
          AppRoutes.PRODUCTS: (context) => const ProductsView(),
          AppRoutes.PRODUCT_FORM: (context) => const ProductFormView(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
