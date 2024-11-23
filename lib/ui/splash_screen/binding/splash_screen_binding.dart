import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/splash_screen/controller/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
