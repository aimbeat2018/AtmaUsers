import 'package:get/get.dart';

import '../controller/membership_controller.dart';

class MembershipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MembershipController>(() => MembershipController());
    // Get.lazyPut<ConfirmBookingController>(() => ConfirmBookingController());
  }
}
