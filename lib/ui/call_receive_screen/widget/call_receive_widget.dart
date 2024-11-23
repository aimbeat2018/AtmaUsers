import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/ui/call_receive_screen/controller/call_receive_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CallReceiveView extends StatelessWidget {
  const CallReceiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAsset.imChatBg),
          fit: BoxFit.cover,
        ),
      ),
      child: GetBuilder<CallReceiveController>(
        builder: (logic) {
          return Column(
            children: [
              Text(
                EnumLocale.txtInComingCall.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 20,
                  fontColor: AppColors.title,
                ),
              ).paddingOnly(top: Get.height * 0.12),
              Text(
                logic.callerName ?? "",
                style: FontStyle.fontStyleW500(
                  fontSize: 17,
                  fontColor: AppColors.title,
                ),
              ).paddingOnly(top: 10),
              const Spacer(),
              Container(
                height: Get.height * 0.43,
                width: Get.width * 0.43,
                decoration: BoxDecoration(color: AppColors.primaryAppColor1, shape: BoxShape.circle),
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: Get.height * 0.4,
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(color: AppColors.placeholder, shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: logic.callerImage ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(15);
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(15);
                    },
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      DateTime now = DateTime.now();
                      String time = DateFormat("M/dd/yyyy, HH:mm:ss a").format(now);

                      Map<String, dynamic> callAnswerMap = {
                        'doctorId': logic.doctor ?? "",
                        'userId': Constant.storage.read("userId"),
                        'callId': logic.callId,
                        'role': 'user',
                        'isAccept': false,
                        'time': time,
                      };
                      SocketManager.emit(SocketConstants.callAnswer, callAnswerMap);
                    },
                    child: Container(
                      height: Get.height * 0.17,
                      width: Get.width * 0.17,
                      decoration: BoxDecoration(
                        color: AppColors.notificationTitle2,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppAsset.icCallCut).paddingAll(14),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      DateTime now = DateTime.now();
                      String time = DateFormat("M/dd/yyyy, HH:mm:ss a").format(now);

                      Map<String, dynamic> callAnswerMap = {
                        'doctorId': logic.doctor ?? "",
                        'userId': Constant.storage.read("userId"),
                        'callId': logic.callId,
                        'role': 'user',
                        'isAccept': true,
                        'time': time,
                      };
                      SocketManager.emit(SocketConstants.callAnswer, callAnswerMap);
                    },
                    child: Container(
                      height: Get.height * 0.17,
                      width: Get.width * 0.17,
                      decoration: BoxDecoration(
                        color: AppColors.callReceive,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppAsset.icCall).paddingAll(16),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: Get.height * 0.02, left: Get.width * 0.15, right: Get.width * 0.15)
            ],
          );
        },
      ),
    ));
  }
}
