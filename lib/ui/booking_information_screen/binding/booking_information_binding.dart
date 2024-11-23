import 'package:doctor/ui/booking_information_screen/controller/booking_information_controller.dart';
import 'package:get/get.dart';

class BookingInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingInformationController>(() => BookingInformationController());
  }
}
