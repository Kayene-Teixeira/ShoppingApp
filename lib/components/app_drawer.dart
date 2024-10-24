import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text(
              'Bem vindo usuário!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
