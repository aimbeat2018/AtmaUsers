import 'package:doctor/ui/personal_chat_screen/controller/personal_chat_controller.dart';
import 'package:get/get.dart';

class PersonalChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalChatController>(() => PersonalChatController());
  }
}
