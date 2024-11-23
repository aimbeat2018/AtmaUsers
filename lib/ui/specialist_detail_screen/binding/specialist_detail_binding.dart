import 'package:doctor/ui/specialist_detail_screen/controller/specialist_detail_controller.dart';
import 'package:get/get.dart';

class SpecialistDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecialistDetailController>(() => SpecialistDetailController());
  }
}
