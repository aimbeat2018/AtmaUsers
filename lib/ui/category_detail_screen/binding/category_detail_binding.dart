import 'package:doctor/ui/category_detail_screen/controller/category_detail_controller.dart';
import 'package:get/get.dart';

class CategoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryDetailController>(() => CategoryDetailController());
  }
}
