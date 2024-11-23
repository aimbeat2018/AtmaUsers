import 'package:doctor/ui/complain_screen/controller/complain_screen_controller.dart';
import 'package:get/get.dart';

class ComplainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplainScreenController>(() => ComplainScreenController());
  }
}
