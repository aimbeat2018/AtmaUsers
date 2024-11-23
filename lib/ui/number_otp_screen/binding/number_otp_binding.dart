import 'package:doctor/ui/add_number_screen/controller/add_number_controller.dart';
import 'package:doctor/ui/number_otp_screen/controller/number_otp_controller.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/registration_screen/controller/registration_controller.dart';
import 'package:get/get.dart';

class NumberOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NumberOtpController>(() => NumberOtpController());
    Get.lazyPut<AddNumberController>(() => AddNumberController());
    Get.lazyPut<RegistrationController>(() => RegistrationController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
