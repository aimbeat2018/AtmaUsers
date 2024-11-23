import 'package:doctor/ui/booking_screen/controller/booking_screen_controller.dart';
import 'package:doctor/ui/main_screen/controller/main_screen_controller.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/registration_screen/controller/registration_controller.dart';
import 'package:get/get.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
    Get.lazyPut<BookingScreenController>(() => BookingScreenController());
    Get.lazyPut<MainScreenController>(() => MainScreenController());
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }
}
