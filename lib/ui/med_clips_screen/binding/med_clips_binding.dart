import 'package:doctor/ui/med_clips_screen/controller/med_clips_controller.dart';
import 'package:get/get.dart';

class MedClipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedClipsController>(() => MedClipsController());
  }
}
