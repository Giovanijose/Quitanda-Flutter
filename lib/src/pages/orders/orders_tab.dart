import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;
import 'package:greengrocer/src/pages/orders/components/order_tile.dart';

class Orderstab extends StatelessWidget {
  const Orderstab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (__, index) => const SizedBox(height: 10),
        itemBuilder: (__, index) => OrderTile(order: appData.orders[index]),
        itemCount: appData.orders.length,
      ),
    );
  }
}
