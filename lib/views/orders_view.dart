import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Meus Pedidos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (contexto, index) {
          return OrderWidget(order: orders.items[index]);
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
