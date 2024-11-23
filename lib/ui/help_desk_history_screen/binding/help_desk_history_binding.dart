import 'package:doctor/ui/help_desk_history_screen/controller/help_desk_history_controller.dart';
import 'package:get/get.dart';

class HelpDeskHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpDeskHistoryController>(() => HelpDeskHistoryController());
  }
}
