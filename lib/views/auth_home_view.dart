import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/views/auth_view.dart';
import 'package:shop/views/products_overview_view.dart';

class AuthHomeView extends StatelessWidget {
  const AuthHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if(snapshot.error != null) {
          return const Center(child: Text('Ocorreu um erro'));
        } else {
          return auth.isAuth ? ProductsOverviewView() : AuthView();
        }
      },
    );
  }
}
