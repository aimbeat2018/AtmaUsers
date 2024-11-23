import 'package:doctor/ui/language_screen/controller/language_screen_controller.dart';
import 'package:get/get.dart';

class LanguageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageScreenController>(() => LanguageScreenController());
  }
}
