import 'package:doctor/ui/set_password_screen/controller/set_password_controller.dart';
import 'package:get/get.dart';

class SetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPasswordController>(() => SetPasswordController());
  }
}
