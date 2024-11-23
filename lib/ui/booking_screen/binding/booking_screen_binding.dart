import 'package:doctor/ui/booking_screen/controller/booking_screen_controller.dart';
import 'package:get/get.dart';

class BookingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingScreenController>(() => BookingScreenController());
  }
}
