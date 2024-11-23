import 'package:doctor/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:doctor/ui/my_wallet_screen/controller/my_wallet_controller.dart';
import 'package:get/get.dart';

class ConfirmBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmBookingController>(() => ConfirmBookingController());
    Get.lazyPut<MyWalletController>(() => MyWalletController());
  }
}
