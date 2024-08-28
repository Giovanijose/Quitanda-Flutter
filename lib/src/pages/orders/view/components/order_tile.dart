import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/orders_model.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/pages/orders/controller/order_controller.dart';
import 'package:greengrocer/src/pages/orders/view/components/order_status_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({
    super.key,
    required this.order,
  });

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (value) {
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                // initiallyExpanded: order.status == 'pending_payment',
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pedido: ${order.id}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    Text(
                      utilsServices.formatDateTime(order.createdDateTime!),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              // Lista de produtos
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children:
                                        controller.order.items.map((orderItem) {
                                      return _OrdemItemWidget(
                                        utilsServices: utilsServices,
                                        orderItem: orderItem,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),

                              // Divisão
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                                width: 8,
                              ),

                              // Status do Pedido
                              Expanded(
                                child: OrderStatusWidget(
                                  status: order.status,
                                  isOverdue: order.overdueDateTime.isBefore(
                                    DateTime.now(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Total
                        Text.rich(
                          TextSpan(
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Total ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                    text: utilsServices
                                        .priceCurrency(order.total)),
                              ]),
                        ),

                        // Pagamento
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return PaymentDialog(
                                      order: order,
                                    );
                                  });
                            },
                            icon: const Icon(Icons.pix),
                            label: const Text('Ver QR Code Pix'),
                          ),
                        ),
                      ],
              );
            },
          )),
    );
  }
}

class _OrdemItemWidget extends StatelessWidget {
  const _OrdemItemWidget({
    required this.utilsServices,
    required this.orderItem,
  });

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(utilsServices.priceCurrency(
            orderItem.totalPrice(),
          )),
        ],
      ),
    );
  }
}
