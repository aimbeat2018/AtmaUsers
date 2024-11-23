import 'package:doctor/ui/chat_boat_screen/controller/chat_boat_controller.dart';
import 'package:get/get.dart';

class ChatBoatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatBoatController>(() => ChatBoatController());
  }
}
