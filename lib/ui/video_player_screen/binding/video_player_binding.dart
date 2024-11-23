import 'package:doctor/ui/video_player_screen/controller/video_player_controller.dart';
import 'package:get/get.dart';

class VideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPlayerScreenController>(() => VideoPlayerScreenController());
  }
}
