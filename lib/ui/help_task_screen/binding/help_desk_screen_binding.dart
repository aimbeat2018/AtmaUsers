import 'package:doctor/ui/help_task_screen/controller/help_desk_screen_controller.dart';
import 'package:get/get.dart';

class HelpDeskScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpDeskScreenController>(() => HelpDeskScreenController());
  }
}
