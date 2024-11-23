import 'package:chewie/chewie.dart';
import 'package:doctor/ui/video_player_screen/controller/video_player_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<VideoPlayerScreenController>(
        id: Constant.idVideoPlay,
        builder: (logic) {
          return Stack(
            children: [
              logic.chewieController != null ? Chewie(controller: logic.chewieController!) : const SizedBox(),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppAsset.icArrowRight,
                    height: 30,
                  ),
                ),
              ).paddingOnly(top: 25, left: 15),
            ],
          );
        },
      ),
    );
  }
}
