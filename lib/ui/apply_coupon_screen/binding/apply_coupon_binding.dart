import 'package:doctor/ui/apply_coupon_screen/controller/apply_coupon_controller.dart';
import 'package:get/get.dart';

class ApplyCouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyCouponController>(() => ApplyCouponController());
  }
}
