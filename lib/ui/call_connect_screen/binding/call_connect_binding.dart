import 'package:doctor/ui/call_connect_screen/controller/call_connect_controller.dart';
import 'package:get/get.dart';

class CallConnectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallConnectController>(() => CallConnectController());
  }
}
