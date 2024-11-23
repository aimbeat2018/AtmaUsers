import 'package:doctor/ui/add_number_screen/controller/add_number_controller.dart';
import 'package:get/get.dart';

class AddNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNumberController>(() => AddNumberController());
  }
}
