import 'package:doctor/ui/login_screen/controller/login_screen_controller.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:get/get.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
