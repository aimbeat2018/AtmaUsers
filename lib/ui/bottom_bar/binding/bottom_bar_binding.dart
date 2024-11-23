import 'package:doctor/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:doctor/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:doctor/ui/chat_screen/controller/chat_screen_controller.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/med_clips_screen/controller/med_clips_controller.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:get/get.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(), fenix: true);
    Get.lazyPut<AppointmentScreenController>(() => AppointmentScreenController(), fenix: true);
    Get.lazyPut<MedClipsController>(() => MedClipsController(), fenix: true);
    Get.lazyPut<ChatScreenController>(() => ChatScreenController(), fenix: true);
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController(), fenix: true);
  }
}
