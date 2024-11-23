import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/dialog/appointment_required_dialog.dart';
import 'package:doctor/custom/dialog/image_view_dialog.dart';
import 'package:doctor/custom/dialog/no_video_meeting_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/socket/socket_constants.dart';
import 'package:doctor/socket/socket_manager.dart';
import 'package:doctor/ui/personal_chat_screen/controller/personal_chat_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// =================== Top View =================== ///
class PersonalChatTopView extends StatelessWidget {
  const PersonalChatTopView({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: Get.height * 0.1 + statusBarHeight,
      width: Get.width,
      padding: EdgeInsets.only(top: statusBarHeight - 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryAppColor1,
            AppColors.primaryAppColor2,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: GetBuilder<PersonalChatController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(AppAsset.icArrowRight, height: 24, width: 24),
              ),
              Container(
                height: Get.height * 0.155,
                width: Get.width * 0.155,
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white,
                    width: 0.5,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.placeholder,
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: logic.senderImage ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(AppAsset.icImagePlaceholder).paddingAll(10);
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(AppAsset.icImagePlaceholder).paddingAll(10);
                    },
                  ),
                ).paddingAll(2),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    logic.senderName ?? "",
                    style: FontStyle.fontStyleW600(
                      fontSize: 17,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(bottom: 3),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColors.chatBox),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      logic.serviceName ?? "",
                      style: FontStyle.fontStyleW500(
                        fontSize: 10,
                        fontColor: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              logic.callEnableModel?.callEnable == true
                  ? logic.currentTime.isAfter(logic.comparisonTime!)
                      ? GestureDetector(
                          onTap: () {
                            Map<String, dynamic> messageMap = {
                              'doctorId': logic.doctor ?? "",
                              'userId': Constant.storage.read("userId"),
                              'role': "user",
                            };
                            SocketManager.emit(SocketConstants.makeCall, messageMap);
                          },
                          child: Image.asset(AppAsset.icVideoCall, height: 40, width: 40),
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.dialog(
                              barrierColor: AppColors.black.withOpacity(0.8),
                              barrierDismissible: false,
                              Dialog(
                                backgroundColor: AppColors.transparent,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                elevation: 0,
                                child: const NoVideoMeetingDialog(),
                              ),
                            );
                          },
                          child: Image.asset(
                            AppAsset.icVideoCall,
                            height: 40,
                            width: 40,
                            color: AppColors.grey,
                          ),
                        )
                  : GestureDetector(
                      onTap: () {
                        Get.dialog(
                          barrierColor: AppColors.black.withOpacity(0.8),
                          barrierDismissible: false,
                          Dialog(
                            backgroundColor: AppColors.transparent,
                            shadowColor: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            elevation: 0,
                            child: const AppointmentRequiredDialog(),
                          ),
                        );
                      },
                      child: Image.asset(
                        AppAsset.icVideoCall,
                        height: 40,
                        width: 40,
                        color: AppColors.grey,
                      ),
                    )
            ],
          ).paddingOnly(left: 12, right: 12);
        },
      ),
    );
  }
}

/// =================== Message View =================== ///
class PersonalChatMessageView extends StatelessWidget {
  const PersonalChatMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAsset.imChatBg),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<PersonalChatController>(
                  id: Constant.idProgressView,
                  builder: (controller) {
                    return controller.isLoading
                        ? Shimmers.getOldChatShimmer()
                        : Obx(
                            () {
                              SocketManager.onChatUpdate();

                              return SingleChildScrollView(
                                controller: SocketManager.scrollController,
                                child: ListView.builder(
                                  itemCount: SocketManager.setMessageList.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    String inputDateString = SocketManager.setMessageList[index].date ?? "";
                                    DateTime parsedDateTime = DateFormat("M/dd/yyyy, HH:mm:ss a").parse(inputDateString);
                                    String formattedTime = DateFormat("h:mm").format(parsedDateTime);

                                    return SocketManager.setMessageList[index].role == "user"
                                        ? SocketManager.setMessageList[index].messageType == "1" ||
                                                SocketManager.setMessageList[index].messageType == "5"
                                            ? Align(
                                                alignment: Alignment.centerRight,
                                                child: SizedBox(
                                                  width: Get.width / 1.6,
                                                  child: Stack(
                                                    alignment: Alignment.centerRight,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.only(left: 12, right: 30, top: 6, bottom: 18),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.senderBox,
                                                          borderRadius: const BorderRadius.only(
                                                            topLeft: Radius.circular(10),
                                                            topRight: Radius.circular(10),
                                                            bottomLeft: Radius.circular(10),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: AppColors.black.withOpacity(0.08),
                                                              blurRadius: 2,
                                                              spreadRadius: 1.5,
                                                              offset: const Offset(0.3, 0.4),
                                                            )
                                                          ],
                                                        ),
                                                        child: Text(
                                                          SocketManager.setMessageList[index].message ?? "",
                                                          style: FontStyle.fontStyleW500(
                                                            fontSize: 15,
                                                            fontColor: AppColors.white,
                                                          ),
                                                        ).paddingOnly(bottom: 5),
                                                      ),
                                                      Positioned(
                                                        bottom: 2,
                                                        right: 8,
                                                        child: Text(
                                                          formattedTime,
                                                          style: FontStyle.fontStyleW500(
                                                            fontSize: 11,
                                                            fontColor: AppColors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ).paddingOnly(bottom: 8, right: 15),
                                              )
                                            : SocketManager.setMessageList[index].messageType == "2"
                                                ? Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Container(
                                                      padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.only(
                                                          topRight: Radius.circular(18),
                                                          topLeft: Radius.circular(18),
                                                          bottomLeft: Radius.circular(18),
                                                        ),
                                                        color: AppColors.senderBox,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: AppColors.black.withOpacity(0.08),
                                                            blurRadius: 2,
                                                            spreadRadius: 1.5,
                                                            offset: const Offset(0.3, 0.4),
                                                          )
                                                        ],
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Get.dialog(
                                                                barrierColor: AppColors.black.withOpacity(0.8),
                                                                Stack(
                                                                  children: [
                                                                    Dialog(
                                                                      backgroundColor: AppColors.transparent,
                                                                      shadowColor: Colors.transparent,
                                                                      surfaceTintColor: Colors.transparent,
                                                                      elevation: 0,
                                                                      child: ImageViewDialog(
                                                                        image: SocketManager.setMessageList[index].image ?? "",
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        Get.back();
                                                                      },
                                                                      child: Align(
                                                                        alignment: Alignment.topRight,
                                                                        child: Image.asset(
                                                                          AppAsset.icClose,
                                                                          height: 35,
                                                                        ),
                                                                      ).paddingOnly(right: 20),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              height: Get.height * 0.2,
                                                              width: Get.width * 0.36,
                                                              decoration: BoxDecoration(
                                                                color: AppColors.placeholder,
                                                                borderRadius: const BorderRadius.only(
                                                                  topRight: Radius.circular(15),
                                                                  topLeft: Radius.circular(15),
                                                                  bottomLeft: Radius.circular(15),
                                                                ),
                                                              ),
                                                              clipBehavior: Clip.hardEdge,
                                                              child: CachedNetworkImage(
                                                                imageUrl: SocketManager.setMessageList[index].image ?? "",
                                                                fit: BoxFit.cover,
                                                                placeholder: (context, url) {
                                                                  return Image.asset(AppAsset.icImagePlaceholder).paddingAll(15);
                                                                },
                                                                errorWidget: (context, url, error) {
                                                                  return Image.asset(AppAsset.icImagePlaceholder).paddingAll(15);
                                                                },
                                                              ),
                                                            ).paddingOnly(bottom: 5),
                                                          ),
                                                          Text(
                                                            "${EnumLocale.txtSendOn.name.tr} $formattedTime",
                                                            style: FontStyle.fontStyleW500(
                                                              fontSize: 10,
                                                              fontColor: AppColors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ).paddingOnly(right: 15, bottom: 8),
                                                  )
                                                : Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Container(
                                                      padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.only(
                                                          topRight: Radius.circular(18),
                                                          topLeft: Radius.circular(18),
                                                          bottomLeft: Radius.circular(18),
                                                        ),
                                                        color: AppColors.senderBox,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: AppColors.black.withOpacity(0.08),
                                                            blurRadius: 2,
                                                            spreadRadius: 1.5,
                                                            offset: const Offset(0.3, 0.4),
                                                          )
                                                        ],
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Get.toNamed(AppRoutes.videoPlayer,
                                                                  arguments: [SocketManager.setMessageList[index].video]);
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  height: Get.height * 0.2,
                                                                  width: Get.width * 0.36,
                                                                  decoration: BoxDecoration(
                                                                    color: AppColors.placeholder,
                                                                    borderRadius: const BorderRadius.only(
                                                                      topRight: Radius.circular(15),
                                                                      topLeft: Radius.circular(15),
                                                                      bottomLeft: Radius.circular(15),
                                                                    ),
                                                                  ),
                                                                  clipBehavior: Clip.hardEdge,
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: SocketManager.setMessageList[index].thumbnail ?? "",
                                                                    fit: BoxFit.cover,
                                                                    placeholder: (context, url) {
                                                                      return Image.asset(AppAsset.icImagePlaceholder)
                                                                          .paddingAll(15);
                                                                    },
                                                                    errorWidget: (context, url, error) {
                                                                      return Image.asset(AppAsset.icImagePlaceholder)
                                                                          .paddingAll(15);
                                                                    },
                                                                  ),
                                                                ).paddingOnly(bottom: 5),
                                                                const Positioned(
                                                                  top: 25,
                                                                  bottom: 25,
                                                                  right: 25,
                                                                  left: 25,
                                                                  child: Icon(
                                                                    Icons.play_circle,
                                                                    color: Colors.white54,
                                                                    size: 50,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            "${EnumLocale.txtSendOn.name.tr} $formattedTime",
                                                            style: FontStyle.fontStyleW500(
                                                              fontSize: 10,
                                                              fontColor: AppColors.white,
                                                            ),
                                                          ).paddingOnly(right: 5),
                                                        ],
                                                      ),
                                                    ).paddingOnly(bottom: 8, right: 15),
                                                  )
                                        : SocketManager.setMessageList[index].messageType == "1" ||
                                                SocketManager.setMessageList[index].messageType == "5"
                                            ? Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width / 1.6,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Stack(
                                                        alignment: Alignment.centerLeft,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.only(left: 12, right: 30, top: 6, bottom: 18),
                                                            decoration: BoxDecoration(
                                                              color: AppColors.receiverBox,
                                                              borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(10),
                                                                topRight: Radius.circular(10),
                                                                bottomRight: Radius.circular(10),
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: AppColors.black.withOpacity(0.08),
                                                                  blurRadius: 2,
                                                                  spreadRadius: 1.5,
                                                                  offset: const Offset(0.3, 0.4),
                                                                )
                                                              ],
                                                            ),
                                                            child: Text(
                                                              SocketManager.setMessageList[index].message ?? "",
                                                              style: FontStyle.fontStyleW500(
                                                                fontSize: 15,
                                                                fontColor: AppColors.receiveMsg,
                                                              ),
                                                            ).paddingOnly(bottom: 5),
                                                          ),
                                                          Positioned(
                                                            bottom: 2,
                                                            right: 10,
                                                            child: Text(
                                                              formattedTime,
                                                              style: FontStyle.fontStyleW500(
                                                                fontSize: 11,
                                                                fontColor: AppColors.receiveMsgDate,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ).paddingOnly(bottom: 10, left: 15),
                                                ],
                                              )
                                            : SocketManager.setMessageList[index].messageType == "2"
                                                ? Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Container(
                                                      padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.only(
                                                          topRight: Radius.circular(18),
                                                          topLeft: Radius.circular(18),
                                                          bottomRight: Radius.circular(18),
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: AppColors.black.withOpacity(0.08),
                                                            blurRadius: 2,
                                                            spreadRadius: 1.5,
                                                            offset: const Offset(0.3, 0.4),
                                                          )
                                                        ],
                                                        color: AppColors.receiverBox,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Get.dialog(
                                                                barrierColor: AppColors.black.withOpacity(0.8),
                                                                Stack(
                                                                  children: [
                                                                    Dialog(
                                                                      backgroundColor: AppColors.transparent,
                                                                      shadowColor: Colors.transparent,
                                                                      surfaceTintColor: Colors.transparent,
                                                                      elevation: 0,
                                                                      child: ImageViewDialog(
                                                                        image: SocketManager.setMessageList[index].image ?? "",
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment: Alignment.topRight,
                                                                      child: Image.asset(
                                                                        AppAsset.icClose,
                                                                        height: 35,
                                                                      ),
                                                                    ).paddingOnly(top: 30, right: 20),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              height: Get.height * 0.2,
                                                              width: Get.width * 0.36,
                                                              decoration: BoxDecoration(
                                                                color: AppColors.placeholder,
                                                                borderRadius: const BorderRadius.only(
                                                                  topRight: Radius.circular(15),
                                                                  topLeft: Radius.circular(15),
                                                                  bottomRight: Radius.circular(15),
                                                                ),
                                                              ),
                                                              clipBehavior: Clip.hardEdge,
                                                              child: CachedNetworkImage(
                                                                imageUrl: SocketManager.setMessageList[index].image ?? "",
                                                                fit: BoxFit.cover,
                                                                placeholder: (context, url) {
                                                                  return Image.asset(AppAsset.icImagePlaceholder).paddingAll(15);
                                                                },
                                                                errorWidget: (context, url, error) {
                                                                  return Image.asset(AppAsset.icImagePlaceholder).paddingAll(15);
                                                                },
                                                              ),
                                                            ).paddingOnly(bottom: 5),
                                                          ),
                                                          Text(
                                                            "${EnumLocale.txtSendOn.name.tr} $formattedTime",
                                                            style: FontStyle.fontStyleW500(
                                                              fontSize: 10,
                                                              fontColor: AppColors.primaryAppColor1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ).paddingOnly(left: 15, bottom: 10),
                                                  )
                                                : Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Container(
                                                      padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.only(
                                                          topRight: Radius.circular(18),
                                                          topLeft: Radius.circular(18),
                                                          bottomRight: Radius.circular(18),
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: AppColors.black.withOpacity(0.08),
                                                            blurRadius: 2,
                                                            spreadRadius: 1.5,
                                                            offset: const Offset(0.3, 0.4),
                                                          )
                                                        ],
                                                        color: AppColors.receiverBox,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Get.toNamed(AppRoutes.videoPlayer,
                                                                  arguments: [SocketManager.setMessageList[index].video]);
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  height: Get.height * 0.2,
                                                                  width: Get.width * 0.36,
                                                                  decoration: BoxDecoration(
                                                                    color: AppColors.placeholder,
                                                                    borderRadius: const BorderRadius.only(
                                                                      topRight: Radius.circular(15),
                                                                      topLeft: Radius.circular(15),
                                                                      bottomRight: Radius.circular(15),
                                                                    ),
                                                                  ),
                                                                  clipBehavior: Clip.hardEdge,
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: SocketManager.setMessageList[index].thumbnail ?? "",
                                                                    fit: BoxFit.cover,
                                                                    placeholder: (context, url) {
                                                                      return Image.asset(AppAsset.icImagePlaceholder)
                                                                          .paddingAll(15);
                                                                    },
                                                                    errorWidget: (context, url, error) {
                                                                      return Image.asset(AppAsset.icImagePlaceholder)
                                                                          .paddingAll(15);
                                                                    },
                                                                  ),
                                                                ).paddingOnly(bottom: 5),
                                                                const Positioned(
                                                                  top: 25,
                                                                  bottom: 25,
                                                                  right: 25,
                                                                  left: 25,
                                                                  child: Icon(
                                                                    Icons.play_circle,
                                                                    color: Colors.white54,
                                                                    size: 50,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            "${EnumLocale.txtSendOn.name.tr} $formattedTime",
                                                            style: FontStyle.fontStyleW500(
                                                              fontSize: 10,
                                                              fontColor: AppColors.primaryAppColor1,
                                                            ),
                                                          ).paddingOnly(right: 5),
                                                        ],
                                                      ),
                                                    ).paddingOnly(left: 15, bottom: 10),
                                                  );
                                  },
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
              const PersonalChatBottomView(),
            ],
          ),
        )
      ],
    );
  }
}

/// =================== Bottom View =================== ///
class PersonalChatBottomView extends StatelessWidget {
  const PersonalChatBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.09,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 8.0,
          ), //BoxShadow
        ],
      ),
      padding: const EdgeInsets.only(
        left: 13.0,
        // bottom: Platform.isAndroid ? 8.0 : 28.0,
        right: 13.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<PersonalChatController>(
            builder: (logic) {
              return SizedBox(
                height: Get.height * 0.07,
                width: Get.width * 0.79,
                child: TextFormField(
                  controller: logic.chatController,
                  cursorColor: AppColors.ratingMessage,
                  style: FontStyle.fontStyleW600(
                    fontSize: 13,
                    fontColor: AppColors.ratingMessage,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (logic.chatController.text.isNotEmpty) {
                          logic.sendMessage(messageType: '1');
                          logic.chatController.clear();
                        }
                      },
                      child: Container(
                        height: Get.height * 0.12,
                        width: Get.width * 0.12,
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
                        child: Image.asset(AppAsset.icSend).paddingAll(9),
                      ).paddingOnly(right: 7),
                    ),
                    fillColor: AppColors.chatTextField,
                    filled: true,
                    hintText: EnumLocale.txtTypeSomething.name.tr,
                    hintStyle: FontStyle.fontStyleW400(
                      fontSize: 14,
                      fontColor: AppColors.ratingMessage,
                    ),
                  ),
                ),
              );
            },
          ),
          GetBuilder<PersonalChatController>(
            builder: (logic) {
              return SpeedDial(
                mini: false,
                openCloseDial: logic.isDialOpen,
                childPadding: EdgeInsets.zero,
                spaceBetweenChildren: 8,
                dialRoot: (ctx, open, toggleChildren) {
                  return GestureDetector(
                    onTap: toggleChildren,
                    child: Container(
                      height: Get.height * 0.12,
                      width: Get.width * 0.12,
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
                      child: logic.isDialOpen.value == true
                          ? Image.asset(AppAsset.icCross).paddingAll(11)
                          : Image.asset(AppAsset.icClip).paddingAll(12.5),
                    ),
                  );
                },
                elevation: 0,
                animationCurve: Curves.easeIn,
                isOpenOnStart: false,
                overlayOpacity: 0,
                children: [
                  SpeedDialChild(
                    elevation: 0,
                    backgroundColor: AppColors.transparent,
                    child: GetBuilder<PersonalChatController>(
                        id: Constant.idChatImage,
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () {
                              logic.onPickImage();
                            },
                            child: Container(
                              height: Get.height * 12.5,
                              width: Get.width * 12.5,
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
                              child: Image.asset(AppAsset.icImage).paddingAll(11),
                            ),
                          );
                        }),
                  ),
                  SpeedDialChild(
                    elevation: 0,
                    backgroundColor: AppColors.transparent,
                    child: GetBuilder<PersonalChatController>(
                      id: Constant.idChatVideo,
                      builder: (logic) {
                        return GestureDetector(
                          onTap: () {
                            logic.onPickVideo();
                          },
                          child: Container(
                            height: Get.height * 12.5,
                            width: Get.width * 12.5,
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
                            child: Image.asset(AppAsset.icVideo).paddingAll(11),
                          ),
                        );
                      },
                    ),
                  ),
                  SpeedDialChild(
                    elevation: 0,
                    backgroundColor: AppColors.transparent,
                    child: GetBuilder<PersonalChatController>(
                      id: Constant.idChatCameraPhoto,
                      builder: (logic) {
                        return GestureDetector(
                          onTap: () {
                            logic.onPickCameraImage();
                          },
                          child: Container(
                            height: Get.height * 12.5,
                            width: Get.width * 12.5,
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
                            child: Image.asset(AppAsset.icCamera).paddingAll(11.5),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
// Container(
//   height: Get.height * 0.047,
//   width: Get.width * 0.28,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(50),
//     color: AppColors.white,
//     border: Border.all(width: 1.3, color: AppColors.borderBox),
//   ),
//   child: Center(
//     child: Text(
//       "Today",
//       style: FontStyle.fontStyleW500(
//         fontSize: 13,
//         fontColor: AppColors.degreeText,
//       ),
//     ),
//   ),
// ).paddingOnly(top: 15, bottom: 20),
