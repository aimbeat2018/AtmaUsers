import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/help_desk_history_screen/controller/help_desk_history_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HelpDeskHistoryAppBarView extends StatelessWidget {
  const HelpDeskHistoryAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtHelpDeskHistory.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== List View =================== ///
class HelpDeskHistoryListView extends StatelessWidget {
  const HelpDeskHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskHistoryController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.helpDeskHistoryShimmer()
            : logic.getComplainModel?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFound.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: logic.getComplainModel?.data?.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 800),
                          columnCount: logic.getComplainModel?.data?.length ?? 0,
                          child: HelpDeskHistoryListItemView(index: index),
                        );
                      },
                    ).paddingOnly(bottom: 15),
                  );
      },
    );
  }
}

class HelpDeskHistoryListItemView extends StatelessWidget {
  final int index;

  const HelpDeskHistoryListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskHistoryController>(
      id: Constant.idProgressView,
      builder: (logic) {
        logic.helpDeskDate = DateFormat("dd MMM yyyy").format(logic.getComplainModel?.data?[index].createdAt ?? DateTime.now());
        logic.helpDeskTime = DateFormat("hh:mm").format(logic.getComplainModel?.data?[index].createdAt ?? DateTime.now());
        logic.date = logic.helpDeskDate;
        logic.time = logic.helpDeskTime;

        return GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.complain, arguments: [
              logic.getComplainModel?.data?[index].details,
              logic.getComplainModel?.data?[index].appointmentId,
              logic.getComplainModel?.data?[index].image,
              logic.getComplainModel?.data?[index].isComplain,
              logic.getComplainModel?.data?[index].createdAt,
            ]);
          },
          child: Container(
            height: Get.height * 0.085,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.placeholder,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(width: 0.8, color: AppColors.helpDeskDivider),
            ),
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    AppAsset.icComplain,
                  ).paddingAll(9),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            logic.getComplainModel?.data?[index].isComplain == true
                                ? EnumLocale.txtComplain.name.tr
                                : EnumLocale.txtSuggestion.name.tr,
                            style: FontStyle.fontStyleW600(
                              fontSize: 15,
                              fontColor: AppColors.title,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: logic.getComplainModel?.data?[index].type == 1 ? AppColors.redBox : AppColors.greenBox,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: logic.getComplainModel?.data?[index].type == 1
                                        ? AppColors.notificationTitle2
                                        : AppColors.walletGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ).paddingOnly(right: 10),
                                Text(
                                  logic.getComplainModel?.data?[index].type == 1
                                      ? EnumLocale.txtPendingTask.name.tr
                                      : EnumLocale.txtIssueSolve.name.tr,
                                  style: FontStyle.fontStyleW600(
                                    fontSize: 13,
                                    fontColor: logic.getComplainModel?.data?[index].type == 1
                                        ? AppColors.notificationTitle2
                                        : AppColors.walletGreen,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(AppAsset.icAppointmentOutline, height: 22, width: 22).paddingOnly(right: 5),
                              Text(
                                logic.date ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(AppAsset.icClock, height: 22, width: 22).paddingOnly(right: 5, left: 20),
                              Text(
                                logic.time ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ).paddingOnly(top: 10, bottom: 10, left: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
