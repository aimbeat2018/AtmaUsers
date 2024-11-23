import 'package:doctor/ui/my_appointment_screen/controller/my_appointment_controller.dart';
import 'package:get/get.dart';

class MyAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAppointmentController>(() => MyAppointmentController());
  }
}
