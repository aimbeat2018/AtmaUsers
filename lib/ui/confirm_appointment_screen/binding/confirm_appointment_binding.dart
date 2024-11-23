import 'package:doctor/ui/confirm_appointment_screen/controller/confirm_appointment_controller.dart';
import 'package:get/get.dart';

class ConfirmAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmAppointmentController>(() => ConfirmAppointmentController());
  }
}
