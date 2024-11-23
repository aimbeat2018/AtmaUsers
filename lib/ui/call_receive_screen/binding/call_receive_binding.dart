import 'package:doctor/ui/call_receive_screen/controller/call_receive_controller.dart';
import 'package:get/get.dart';

class CallReceiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallReceiveController>(() => CallReceiveController());
  }
}
