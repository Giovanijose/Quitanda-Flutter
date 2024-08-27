import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/orders_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/repository/order_repository.dart';
import 'package:greengrocer/src/pages/orders/result/orders_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderController extends GetxController {
  OrderModel order;
  OrderController(this.order);

  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final OrdersResult<List<CartItemModel>> result =
        await orderRepository.getOrderItems(
      orderId: order.id,
      token: authController.user.token!,
    );
    setLoading(false);

    result.when(success: (items) {
      order.items = items;
      update();
    }, error: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
    });
  }
}
