import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/registration_screen/controller/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() => RegistrationController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
