import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/custom_bold_text/custom_bold_text.dart';
import 'package:doctor/ui/chat_boat_screen/controller/chat_boat_controller.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

/// =================== Top View =================== ///
class ChatBoatTopView extends StatelessWidget {
  const ChatBoatTopView({super.key});

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
      child: Row(
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
                imageUrl: "${ApiConstant.BASE_URL}storage/chatBoat.png",
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
                "Chat Boat",
                style: FontStyle.fontStyleW600(
                  fontSize: 17,
                  fontColor: AppColors.white,
                ),
              ).paddingOnly(bottom: 3),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColors.chatBox),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  "May I Help You?",
                  style: FontStyle.fontStyleW500(
                    fontSize: 10,
                    fontColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ).paddingOnly(left: 12, right: 12),
    );
  }
}

/// =================== Message View =================== ///
class ChatBoatMessageView extends StatelessWidget {
  const ChatBoatMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.imChatBg),
            fit: BoxFit.cover,
          ),
        ),
        child: GetBuilder<ChatBoatController>(
          id: Constant.idChatBoat,
          builder: (logic) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: logic.getAllMessages.length,
                    controller: logic.scrollController,
                    itemBuilder: (context, index) {
                      final message = logic.getAllMessages[index];
                      final isLastMessage = index == logic.getAllMessages.length - 1;
                      return ChatBoatGetMessageView(
                        isPatient: message.isSendByUser ?? true,
                        message: message.text ?? "",
                        date: message.time ?? "",
                        isLastMessage: isLastMessage,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    bottom: Platform.isAndroid ? 8.0 : 28.0,
                    right: 8.0,
                  ),
                  child: SizedBox(
                    height: Get.height * 0.07,
                    width: Get.width * 0.96,
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
                            logic.sendMessage();
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
                        hintText: "Message ChatBoat...",
                        hintStyle: FontStyle.fontStyleW400(
                          fontSize: 14,
                          fontColor: AppColors.ratingMessage,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// =================== Get Message View =================== ///
class ChatBoatGetMessageView extends StatelessWidget {
  final bool isPatient;
  final String message;
  final String date;
  final bool isLastMessage;

  ChatBoatGetMessageView({
    super.key,
    required this.isPatient,
    required this.message,
    required this.date,
    required this.isLastMessage,
  });
  final GlobalKey _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _widgetKey,
      child: isPatient
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
                        message,
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
                        date,
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
          : Row(
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
                          padding: const EdgeInsets.only(left: 12, right: 30, top: 6, bottom: 18),
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
                          child: message == 'loading'
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  size: 30,
                                  color: AppColors.receiveMsg,
                                )
                              : CustomBoldText(
                                  text: message,
                                  isLastMessage: isLastMessage,
                                ).paddingOnly(bottom: 5),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 10,
                          child: Text(
                            date,
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
            ),
    );
  }
}
