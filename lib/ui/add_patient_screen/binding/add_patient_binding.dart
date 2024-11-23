import 'package:doctor/ui/add_patient_screen/controller/add_patient_controller.dart';
import 'package:doctor/ui/booking_screen/controller/booking_screen_controller.dart';
import 'package:get/get.dart';

class AddPatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPatientController>(() => AddPatientController());
    Get.lazyPut<BookingScreenController>(() => BookingScreenController());
  }
}
