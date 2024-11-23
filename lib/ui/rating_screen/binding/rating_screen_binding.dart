import 'package:doctor/ui/rating_screen/controller/rating_screen_controller.dart';
import 'package:get/get.dart';

class RatingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingScreenController>(() => RatingScreenController());
  }
}
