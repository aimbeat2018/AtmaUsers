import 'package:doctor/ui/history_screen/controller/history_screen_controller.dart';
import 'package:get/get.dart';

class HistoryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryScreenController>(() => HistoryScreenController());
  }
}
