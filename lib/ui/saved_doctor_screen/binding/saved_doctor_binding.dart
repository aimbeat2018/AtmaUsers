import 'package:doctor/ui/saved_doctor_screen/controller/saved_doctor_controller.dart';
import 'package:get/get.dart';

class SavedDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedDoctorController>(() => SavedDoctorController(), fenix: true);
  }
}
