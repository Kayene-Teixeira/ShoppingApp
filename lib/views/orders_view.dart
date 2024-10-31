import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Meus Pedidos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: _refreshOrders(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<OrderList>(
              builder: (context, orders, child) => ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (contexto, index) {
                  return OrderWidget(order: orders.items[index]);
                },
              ),
            );
          }
        },
      ),
      // body: RefreshIndicator(
      //   onRefresh: () => _refreshOrders(context),
      //   child: _isLoading
      //       ? const Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : ListView.builder(
      //           itemCount: orders.itemsCount,
      //           itemBuilder: (contexto, index) {
      //             return OrderWidget(order: orders.items[index]);
      //           },
      //         ),
      // ),
      drawer: const AppDrawer(),
    );
  }
}
