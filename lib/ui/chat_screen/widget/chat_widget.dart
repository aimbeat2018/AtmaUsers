import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/chat_screen/controller/chat_screen_controller.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class ChatAppBarView extends StatelessWidget {
  const ChatAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMessage.name.tr,
      showLeadingIcon: false,
    );
  }
}

/// =================== Chat ListView =================== ///
class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.getChatThumbListShimmer()
            : logic.getChatThumbListModel?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoChatFound,
                    imageHeight: 200,
                    text: EnumLocale.noDataFoundChat.name.tr,
                  )
                : ListView.builder(
                    itemCount: logic.getChatThumbListModel?.data?.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ChatListItemView(index: index);
                    },
                  ).paddingOnly(top: 12);
      },
    );
  }
}

class ChatListItemView extends StatelessWidget {
  final int index;

  const ChatListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Column(
          children: [
            InkWell(
              overlayColor: WidgetStatePropertyAll(AppColors.transparent),
              onTap: () {
                if (index == 0) {
                  Get.toNamed(
                    AppRoutes.chatBoat,
                    arguments: [logic.getChatThumbListModel?.data?[index].id],
                  );
                } else {
                  id = logic.getChatThumbListModel?.data?[index].sender;

                  Get.toNamed(
                    AppRoutes.personalChat,
                    arguments: [
                      logic.getChatThumbListModel?.data?[index].sender,
                      logic.getChatThumbListModel?.data?[index].chatTopic,
                      logic.getChatThumbListModel?.data?[index].senderName,
                      logic.getChatThumbListModel?.data?[index].senderImage,
                      logic.getChatThumbListModel?.data?[index].services?.first,
                    ],
                  )?.then((value) {
                    id = '';
                    log("Id for notification :: $id");
                  });
                }
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.15,
                      decoration: BoxDecoration(color: AppColors.placeholder, shape: BoxShape.circle),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: index == 0
                            ? "${ApiConstant.BASE_URL}storage/chatBoat.png"
                            : logic.getChatThumbListModel?.data?[index].senderImage ?? "",
                        fit: index == 0 ? null : BoxFit.cover,
                        placeholder: (context, url) {
                          return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                        },
                      ),
                    ).paddingOnly(left: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                index == 0 ? "Dr.Chat" : logic.getChatThumbListModel?.data?[index].senderName ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: FontStyle.fontStyleW700(
                                  fontSize: 16,
                                  fontColor: AppColors.title,
                                ),
                              ),
                              Text(
                                logic.getChatThumbListModel?.data?[index].time ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: FontStyle.fontStyleW500(
                                  fontSize: 11,
                                  fontColor: AppColors.chatDate,
                                ),
                              ),
                            ],
                          ).paddingOnly(bottom: 2),
                          SizedBox(
                            width: Get.width * 0.8,
                            child: Text(
                              index == 0 ? "How can i help you ?" : logic.getChatThumbListModel?.data?[index].message ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: FontStyle.fontStyleW400(
                                fontSize: 12,
                                fontColor: AppColors.ratingMessage,
                              ),
                            ),
                          )
                        ],
                      ).paddingOnly(left: 12, right: 13),
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 1.2, color: AppColors.border.withOpacity(0.3)).paddingOnly(top: 10, bottom: 10)
          ],
        );
      },
    );
  }
}
