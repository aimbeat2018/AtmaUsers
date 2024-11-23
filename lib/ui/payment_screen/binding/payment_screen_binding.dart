import 'package:doctor/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:get/get.dart';

class PaymentScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentScreenController>(() => PaymentScreenController());
  }
}
