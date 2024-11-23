import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/ui/video_call_screen/controller/video_call_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// =================== Video Call View =================== ///
class VideoCallView extends StatelessWidget {
  const VideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryAppColor2.withOpacity(0.5),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: GetBuilder<VideoCallController>(
          id: Constant.idVideoCall,
          builder: (logic) {
            return Stack(
              children: [
                logic.remoteVideoOff == false
                    ? Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.user,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: logic.callerImage ?? "",
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(25);
                                },
                                errorWidget: (context, url, error) {
                                  return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(25);
                                },
                              ),
                            ).paddingOnly(bottom: 10),
                            logic.remoteMicMute == true && logic.remoteVideoOff == false
                                ? Text(
                                    "${logic.callerName}'s Camera off and on mute",
                                    style: FontStyle.fontStyleW500(
                                      fontSize: 17,
                                      fontColor: AppColors.white,
                                    ),
                                  )
                                : Text(
                                    "${logic.callerName}'s Camera off",
                                    style: FontStyle.fontStyleW500(
                                      fontSize: 17,
                                      fontColor: AppColors.white,
                                    ),
                                  )
                          ],
                        ),
                      )
                    : logic.remoteMicMute == true
                        ? Stack(
                            children: [
                              Center(
                                child: Center(
                                  child: logic.remoteView ??
                                      Image.asset(
                                        AppAsset.imMan,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: Get.width * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primaryAppColor2.withOpacity(0.55),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(AppAsset.icMicOff, height: 25).paddingOnly(right: 8),
                                      SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text(
                                          "${logic.callerName}'s Call on Mute",
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyle.fontStyleW600(fontSize: 18, fontColor: AppColors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : Center(
                            child: logic.remoteView ??
                                Image.asset(
                                  AppAsset.imMan,
                                  fit: BoxFit.cover,
                                ),
                          ),
                logic.cameraOff == true
                    ? Positioned(
                        top: 35,
                        right: 20,
                        child: Container(
                          height: Get.height * 0.2,
                          width: Get.width * 0.36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.primaryAppColor2,
                            border: Border.all(color: AppColors.user, width: 0.8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.user),
                                clipBehavior: Clip.hardEdge,
                                child: CachedNetworkImage(
                                  imageUrl: logic.receiverImage ?? "",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                                  },
                                  errorWidget: (context, url, error) {
                                    return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                                  },
                                ),
                              ).paddingOnly(bottom: 10),
                              SizedBox(
                                width: 110,
                                child: logic.cameraOff == true && logic.micMute == true
                                    ? Text(
                                        "${logic.receiverName}'s Camera off and on mute",
                                        style: FontStyle.fontStyleW500(
                                          fontSize: 12,
                                          fontColor: AppColors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        "${logic.receiverName}'s Camera off",
                                        style: FontStyle.fontStyleW500(
                                          fontSize: 12,
                                          fontColor: AppColors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                              )
                            ],
                          ),
                        ),
                      )
                    : logic.micMute == true
                        ? Positioned(
                            top: 35,
                            right: 20,
                            child: Container(
                              height: Get.height * 0.2,
                              width: Get.width * 0.36,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  logic.localView ?? Image.asset(AppAsset.imMan),
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.primaryAppColor2.withOpacity(0.55),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                      child: Row(
                                        children: [
                                          Image.asset(AppAsset.icMicOff, height: 15).paddingOnly(right: 8),
                                          Expanded(
                                            child: Text(
                                              "${logic.receiverName}'s Call on Mute",
                                              textAlign: TextAlign.center,
                                              style: FontStyle.fontStyleW600(fontSize: 10, fontColor: AppColors.white),
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(left: 8, right: 8),
                                    ).paddingOnly(left: 15, right: 15),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Positioned(
                            top: 35,
                            right: 20,
                            child: Container(
                              height: Get.height * 0.2,
                              width: Get.width * 0.36,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: logic.localView ?? Image.asset(AppAsset.imMan),
                            ),
                          ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BlurryContainer(
                    height: Get.height * 0.12,
                    width: Get.width,
                    blur: 2,
                    elevation: 0,
                    color: Colors.white60,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            logic.onMicMute();
                          },
                          child: Container(
                            height: Get.height * 0.14,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryAppColor1,
                                  AppColors.primaryAppColor2,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: logic.micMute == true
                                ? Image.asset(AppAsset.icMicOff).paddingAll(12.5)
                                : Image.asset(AppAsset.icMic).paddingAll(12.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            logic.onCameraOff();
                          },
                          child: Container(
                            height: Get.height * 0.14,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryAppColor1,
                                  AppColors.primaryAppColor2,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: logic.cameraOff == true
                                ? Image.asset(AppAsset.icVCallOff).paddingAll(12.5)
                                : Image.asset(AppAsset.icVCall).paddingAll(12.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            logic.onCameraTurn();
                          },
                          child: Container(
                            height: Get.height * 0.14,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryAppColor1,
                                  AppColors.primaryAppColor2,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Image.asset(AppAsset.icCameraTurn).paddingAll(12.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            DateTime now = DateTime.now();
                            String time = DateFormat("M/dd/yyyy, HH:mm:ss a").format(now);

                            Map<String, dynamic> callDisconnectMap = {
                              'role': 'user',
                              'callId': logic.callId,
                              'time': time,
                            };
                            SocketManager.emit(SocketConstants.callDisconnect, callDisconnectMap);
                          },
                          child: Container(
                            height: Get.height * 0.14,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.notificationTitle2,
                            ),
                            child: Image.asset(AppAsset.icCallCut).paddingAll(12.5),
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 10, right: 10),
                  ),
                ),
                BlurryContainer(
                  blur: 2,
                  elevation: 0,
                  color: Colors.white12,
                  height: 60,
                  width: 180,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.user),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: logic.callerImage ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                          },
                        ),
                      ).paddingOnly(right: 8, top: 3),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 95,
                            child: Text(
                              logic.callerName ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: FontStyle.fontStyleW600(fontSize: 15, fontColor: AppColors.white),
                            ),
                          ),
                          Text(
                            logic.formattedTime ?? "",
                            style: FontStyle.fontStyleW400(fontSize: 13, fontColor: AppColors.white),
                          ),
                        ],
                      ),
                    ],
                  ).paddingOnly(left: 10),
                ).paddingOnly(top: 35, bottom: 20, left: 20, right: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
