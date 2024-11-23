import 'package:doctor/ui/search_screen/controller/search_screen_controller.dart';
import 'package:doctor/ui/top_specialist_screen/controller/top_specialist_controller.dart';
import 'package:get/get.dart';

class TopSpecialistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopSpecialistController>(() => TopSpecialistController());
    Get.lazyPut<SearchScreenController>(() => SearchScreenController());
  }
}
