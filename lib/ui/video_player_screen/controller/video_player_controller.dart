import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenController extends GetxController {
  dynamic args = Get.arguments;
  String? video;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void onInit() async {
    await getDataFromArgs();

    await videoPlayerController?.initialize();

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(video ?? ""));

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
      aspectRatio: Get.width / Get.height,
      materialProgressColors: ChewieProgressColors(playedColor: AppColors.primaryAppColor2),
    );

    update([Constant.idVideoPlay]);

    super.onInit();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        video = args[0];
      }
      log("Video Url :: $video");
    }
  }
}
