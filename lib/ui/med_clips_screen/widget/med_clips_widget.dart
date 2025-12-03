import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:doctor/custom/bottom_sheet/custom_bottom_sheet.dart';
import 'package:doctor/custom/custom_share/custom_share.dart';
import 'package:doctor/custom/network_image/network_image.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/med_clips_screen/controller/med_clips_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
// import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';

class PreviewReelsView extends StatefulWidget {
  final int index;
  final int currentPageIndex;

  const PreviewReelsView({
    super.key,
    required this.index,
    required this.currentPageIndex,
  });

  @override
  State<PreviewReelsView> createState() => _PreviewReelsViewState();
}

class _PreviewReelsViewState extends State<PreviewReelsView> with SingleTickerProviderStateMixin {
  final medClipsController = Get.find<MedClipsController>();

  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  RxBool isPlaying = true.obs;
  RxBool isShowIcon = false.obs;

  RxBool isBuffering = false.obs;
  RxBool isVideoLoading = true.obs;

  RxBool isShowLikeAnimation = false.obs;
  RxBool isShowLikeIconAnimation = false.obs;

  RxBool isReelsPage = true.obs; // This is Use to Stop Auto Playing..

  RxBool isLike = false.obs;
  RxMap customChanges = {"like": 0, "comment": 0}.obs;

  AnimationController? animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    if (animationController != null) {
      animation = Tween(begin: 0.0, end: 1.0).animate(animationController!);
    }
    initializeVideoPlayer();
    customSetting();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    onDisposeVideoPlayer();
    log("Dispose Method Called Success");
    super.dispose();
  }

  Future<void> initializeVideoPlayer() async {
    try {
      String videoPath = medClipsController.getMainReels[widget.index].videoUrl ?? "";

      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoPath));

      await videoPlayerController?.initialize();

      if (videoPlayerController != null && (videoPlayerController?.value.isInitialized ?? false)) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          looping: true,
          allowedScreenSleep: false,
          allowMuting: false,
          showControlsOnInitialize: false,
          showControls: false,
          maxScale: 1,
        );

        if (chewieController != null) {
          isVideoLoading.value = false;
          (widget.index == widget.currentPageIndex && isReelsPage.value)
              ? onPlayVideo()
              : null; // Use => First Time Video Playing...
        } else {
          isVideoLoading.value = true;
        }

        videoPlayerController?.addListener(
          () {
            // Use => If Video Buffering then show loading....
            (videoPlayerController?.value.isBuffering ?? false) ? isBuffering.value = true : isBuffering.value = false;

            if (isReelsPage.value == false) {
              onStopVideo(); // Use => On Change Routes...
            }
          },
        );
      }
    } catch (e) {
      onDisposeVideoPlayer();
      log("Reels Video Initialization Failed :: $e");
    }
  }

  void onStopVideo() {
    isPlaying.value = false;
    videoPlayerController?.pause();
  }

  void onPlayVideo() {
    isPlaying.value = true;
    videoPlayerController?.play();
  }

  void onDisposeVideoPlayer() {
    try {
      onStopVideo();
      videoPlayerController?.dispose();
      chewieController?.dispose();
      chewieController = null;
      videoPlayerController = null;
      isVideoLoading.value = true;
    } catch (e) {
      log("On Dispose VideoPlayer Error :: $e");
    }
  }

  void customSetting() {
    isLike.value = medClipsController.getMainReels[widget.index].isLike ?? false;
    customChanges["like"] = int.parse(medClipsController.getMainReels[widget.index].totalLikes.toString());
    customChanges["comment"] = int.parse(medClipsController.getMainReels[widget.index].totalComments.toString());
  }

  void onClickVideo() async {
    if (isVideoLoading.value == false) {
      videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
      isShowIcon.value = true;
      await 2.seconds.delay();
      isShowIcon.value = false;
    }
    if (isReelsPage.value == false) {
      isReelsPage.value = true; // Use => On Back Reels Page...
    }
  }

  void onClickPlayPause() async {
    videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
    if (isReelsPage.value == false) {
      isReelsPage.value = true; // Use => On Back Reels Page...
    }
  }

  Future<void> onClickShare() async {
    log("Enter share count");

    isReelsPage.value = false;
    CustomShare.onShare(
      title: "https://play.google.com/store/apps/details?id=com.incodes.patient", // Enter your package name
    );
    await medClipsController.onShareCountVideoApiCall(
      userId: Constant.storage.read("userId"),
      videoId: medClipsController.getMainReels[widget.index].id ?? "",
    );
  }

  Future<void> onClickLike() async {
    if (isLike.value) {
      isLike.value = false;
      customChanges["like"]--;
    } else {
      isLike.value = true;
      customChanges["like"]++;
    }
    setState(() {
      isLike.value;
    });
    await medClipsController.onLikeOrDislikeVideoApiCall(
      userId: Constant.storage.read("userId"),
      videoId: medClipsController.getMainReels[widget.index].id ?? "",
    );
  }

  Future<void> onDoubleClick() async {
    if (isLike.value) {
    } else {
      isLike.value = true;
      customChanges["like"]++;

      isShowLikeAnimation.value = true;
      // Vibration.vibrate(duration: 50, amplitude: 128);
      await 1200.milliseconds.delay();
      isShowLikeAnimation.value = false;

      await medClipsController.onLikeOrDislikeVideoApiCall(
        userId: Constant.storage.read("userId"),
        videoId: medClipsController.getMainReels[widget.index].id ?? "",
      );
    }
  }

  onClickComment({required bool isCommentAllowed}) async {
    log("Enter in on Click Comment");
    isReelsPage.value = false;
    customChanges["comment"] = await CommentBottomSheetUi.show(
      context: context,
      videoId: medClipsController.getMainReels[widget.index].id ?? "",
      isCommentAllowed: isCommentAllowed,
      totalComments: customChanges["comment"],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == widget.currentPageIndex) {
      // Use => Play Current Video On Scrolling...
      (isVideoLoading.value == false && isReelsPage.value) ? onPlayVideo() : null;
    } else {
      // Restart Previous Video On Scrolling...
      isVideoLoading.value == false ? videoPlayerController?.seekTo(Duration.zero) : null;
      onStopVideo(); // Stop Previous Video On Scrolling...
    }
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Obx(
          () {
            return GestureDetector(
              onDoubleTap: onDoubleClick,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: onClickVideo,
                    child: Container(
                      color: AppColors.black,
                      height: (Get.height - 50),
                      width: Get.width,
                      child: isVideoLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.typeSelect,
                              ),
                            )
                          : SizedBox.expand(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: videoPlayerController?.value.size.width ?? 0,
                                  height: videoPlayerController?.value.size.height ?? 0,
                                  child: Chewie(controller: chewieController!),
                                ),
                              ),
                            ),
                    ),
                  ),
                  Obx(
                    () {
                      return Visibility(
                        visible: isShowLikeAnimation.value,
                        child: Align(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                            AppAsset.likeLottie,
                            fit: BoxFit.cover,
                            height: 300,
                            width: 300,
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(
                    () {
                      return isShowIcon.value
                          ? Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: onClickPlayPause,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  padding: EdgeInsets.only(left: isPlaying.value ? 0 : 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.black.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: isPlaying.value
                                        ? Icon(
                                            Icons.pause,
                                            size: 30,
                                            color: AppColors.white,
                                          )
                                        : Icon(
                                            Icons.play_arrow,
                                            size: 30,
                                            color: AppColors.white,
                                          ),
                                  ),
                                ),
                              ),
                            )
                          : const Offstage();
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: Get.height / 4,
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.transparent,
                            AppColors.black.withOpacity(0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 100),
                      height: Get.height,
                      child: Column(
                        children: [
                          const Spacer(),
                          Obx(
                            () {
                              return SizedBox(
                                height: 50,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: isShowLikeIconAnimation.value ? 15 : 50,
                                  width: isShowLikeIconAnimation.value ? 15 : 50,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      onClickLike();
                                    },
                                    child: Image.asset(
                                      AppAsset.icLike,
                                      color: medClipsController.getMainReels[widget.index].isLike == true
                                          ? AppColors.notificationTitle2
                                          : isLike.value
                                              ? AppColors.notificationTitle2
                                              : AppColors.white,
                                      height: 36,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Obx(
                            () {
                              return Text(
                                customChanges["like"].toString(),
                                style: FontStyle.fontStyleW700(
                                  fontColor: AppColors.white,
                                  fontSize: 16,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              onClickComment(
                                isCommentAllowed: medClipsController.getMainReels[widget.index].isCommentAllowed ?? true,
                              );
                            },
                            child: Image.asset(
                              AppAsset.icComment,
                              height: 38,
                            ),
                          ),
                          Obx(
                            () {
                              return Text(
                                customChanges["comment"].toString(),
                                style: FontStyle.fontStyleW700(
                                  fontColor: AppColors.white,
                                  fontSize: 16,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              onClickShare();
                            },
                            child: Image.asset(
                              AppAsset.icShare1,
                              color: AppColors.white,
                              height: 36,
                            ),
                          ),
                          Text(
                            medClipsController.getMainReels[widget.index].shareCount.toString(),
                            style: FontStyle.fontStyleW700(
                              fontColor: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isReelsPage.value = false;

                            Get.toNamed(
                              AppRoutes.specialistDetail,
                              arguments: [
                                medClipsController.getMainReels[widget.index].doctorId ?? "",
                                "",
                              ],
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 46,
                                width: 46,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.asset(AppAsset.icDoctorPlaceholder),
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: PreviewNetworkImageUi(
                                        image: medClipsController.getMainReels[widget.index].image ?? "",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width / 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          maxLines: 1,
                                          medClipsController.getMainReels[widget.index].name ?? "",
                                          style: FontStyle.fontStyleW600(
                                            fontColor: AppColors.white,
                                            fontSize: 16.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width / 2,
                                    child: Text(
                                      maxLines: 1,
                                      medClipsController.getMainReels[widget.index].degree?.join(",") ?? "",
                                      style: FontStyle.fontStyleW500(
                                        fontColor: AppColors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text(
                            medClipsController.getMainReels[widget.index].description ?? "",
                            maxLines: 3,
                            style: FontStyle.fontStyleW400(
                              fontColor: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
