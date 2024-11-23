import 'package:doctor/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<BottomBarController>(() => BottomBarController());
  }
}
