import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/ui/call_connect_screen/controller/call_connect_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

/// =================== Call Connect View =================== ///
class CallConnectView extends StatelessWidget {
  const CallConnectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CallConnectController>(
        builder: (logic) {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.imChatBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
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
                      imageUrl: logic.receiverImage ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      EnumLocale.txtConnecting.name.tr,
                      style: FontStyle.fontStyleW600(
                        fontSize: 20,
                        fontColor: AppColors.title,
                      ),
                    ),
                    Lottie.asset(AppAsset.loadingLottie, height: 20).paddingOnly(top: 10),
                  ],
                ).paddingOnly(bottom: Get.height * 0.12),
                GestureDetector(
                  onTap: () {
                    DateTime now = DateTime.now();
                    String time = DateFormat("M/dd/yyyy, HH:mm:ss a").format(now);

                    Map<String, dynamic> callCancelMap = {
                      'role': 'user',
                      'callId': logic.callId,
                      'time': time,
                      'doctorId': logic.doctor ?? "",
                      'userId': Constant.storage.read("userId"),
                    };
                    SocketManager.emit(SocketConstants.callCancel, callCancelMap);
                  },
                  child: Container(
                    height: Get.height * 0.17,
                    width: Get.width * 0.17,
                    decoration: BoxDecoration(
                      color: AppColors.notificationTitle2,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(AppAsset.icCallCut).paddingAll(14),
                  ).paddingOnly(bottom: Get.height * 0.05),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
