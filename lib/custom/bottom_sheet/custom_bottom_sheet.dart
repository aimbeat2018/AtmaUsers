import 'dart:async';
import 'dart:developer';

import 'package:doctor/custom/network_image/network_image.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/ui/med_clips_screen/controller/med_clips_controller.dart';
import 'package:doctor/ui/med_clips_screen/model/get_all_comment_model.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CommentBottomSheetUi {
  static RxBool isLoading = false.obs;
  static GetAllCommentModel? commentModel;
  static RxList<GetAllComment> comments = <GetAllComment>[].obs;
  static TextEditingController commentController = TextEditingController();
  static ScrollController scrollController = ScrollController();
  static MedClipsController medClipsController = Get.find<MedClipsController>();

  static Future<void> onGetComments({
    required String videoId,
  }) async {
    log("Enter in onGetComments");
    isLoading.value = true;
    comments.clear();
    commentModel = await medClipsController.onGetAllCommentApiCall(
      userId: Constant.storage.read("userId"),
      videoId: videoId,
    );

    if (commentModel?.data != null) {
      isLoading.value = false;
      comments.addAll(commentModel?.data ?? []);
    }
  }

  static Future<void> onSendComment({
    required String videoId,
    required bool isCommentAllowed,
  }) async {
    if (commentController.text.trim().isNotEmpty) {
      final commentText = commentController.text;

      await medClipsController.onCreateCommentApiCall(
        userId: Constant.storage.read("userId"),
        videoId: videoId,
        commentText: commentController.text,
      );

      isCommentAllowed == false
          ? Utils.showToast(Get.context!, medClipsController.createCommentModel?.message ?? "")
          : comments.add(
              GetAllComment(
                commentText: commentText,
                time: "Now",
                name: Constant.storage.read("userName"),
                userImage: Constant.storage.read("userImage"),
                id: Constant.storage.read("userId"),
              ),
            );

      commentController.clear();

      if (comments.length > 4) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
        await 500.milliseconds.delay();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      }
    }
  }

  static String onFormatTime(String time) {
    List<String> parts = time.split(' ');

    if (parts.length == 3 && parts[2] == 'ago' && parts[1] == 'minutes' && parts[0].isNotEmpty) {
      return '${parts[0]}m';
    } else if (parts.length == 3 && parts[2] == 'ago' && parts[1] == 'hours' && parts[0].isNotEmpty) {
      return '${parts[0]}h';
    } else if (parts.length == 3 && parts[2] == 'ago' && parts[1] == 'seconds' && parts[0].isNotEmpty) {
      return '${parts[0]}s';
    } else {
      return time;
    }
  }

  static Future<int> show({
    required BuildContext context,
    required String videoId,
    required bool isCommentAllowed,
    required int totalComments,
  }) async {
    onGetComments(videoId: videoId);

    await showModalBottomSheet(
      isScrollControlled: true,
      scrollControlDisabledMaxHeightRatio: Get.height,
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 500,
            width: Get.width,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 4,
                            width: 35,
                            decoration: BoxDecoration(
                              color: AppColors.notificationBox2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Comment",
                            style: FontStyle.fontStyleW600(
                              fontSize: 18,
                              fontColor: AppColors.title,
                            ),
                          ),
                        ],
                      ).paddingOnly(left: 50),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          AppAsset.icClose,
                          height: Get.height * 0.07,
                          width: Get.width * 0.07,
                        ).paddingOnly(right: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.bottomSheetDivider,
                      width: 1,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: comments.isEmpty
                            ? NoDataFound(
                                image: AppAsset.icNoChatFound,
                                imageHeight: 130,
                                text: "No Comment yet !!",
                              ).paddingOnly(top: Get.height * 0.1)
                            : ListView.builder(
                                itemCount: comments.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(shape: BoxShape.circle),
                                          child: Stack(
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.asset(AppAsset.icUserPlaceholder),
                                              ),
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: PreviewNetworkImageUi(image: comments[index].userImage ?? ""),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: comments[index].name,
                                                  style: FontStyle.fontStyleW700(fontColor: AppColors.title, fontSize: 15),
                                                  children: [
                                                    TextSpan(
                                                      text: "   ${onFormatTime(comments[index].time ?? "")}",
                                                      style: FontStyle.fontStyleW600(
                                                          fontColor: AppColors.textFieldTitle, fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                comments[index].commentText ?? "",
                                                style: FontStyle.fontStyleW500(fontColor: AppColors.textFieldTitle, fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                  ),
                ),
                CommentTextFieldUi(
                  controller: commentController,
                  onSend: () {
                    onSendComment(
                      videoId: videoId,
                      isCommentAllowed: isCommentAllowed,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    return comments.isEmpty ? totalComments : comments.length;
  }
}

class CommentTextFieldUi extends StatelessWidget {
  const CommentTextFieldUi({
    super.key,
    required this.onSend,
    required this.controller,
  });

  final Callback onSend;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 5),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.border.withOpacity(0.3),
        border: Border.all(color: AppColors.bottomLabel.withOpacity(0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 22,
            width: 22,
            AppAsset.icComment,
            color: AppColors.degreeText,
          ),
          const SizedBox(width: 5),
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: AppColors.degreeText,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: AppColors.degreeText,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 3),
                hintText: "Type Comment...",
                hintStyle: FontStyle.fontStyleW400(
                  fontColor: AppColors.degreeText,
                  fontSize: 14.5,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 40,
              width: 40,
              color: AppColors.transparent,
              child: Center(
                child: Image.asset(
                  width: 25,
                  AppAsset.icSend,
                  color: AppColors.degreeText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
