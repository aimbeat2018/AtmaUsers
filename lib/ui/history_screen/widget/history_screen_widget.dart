import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/ui/history_screen/controller/history_screen_controller.dart';
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

/// =================== App Bar =================== ///
class HistoryAppBarView extends StatelessWidget {
  const HistoryAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtHistory.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Title =================== ///
class HistoryTitleView extends StatelessWidget {
  const HistoryTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              EnumLocale.txtPaymentHistory.name.tr,
              style: FontStyle.fontStyleW700(
                fontSize: 18,
                fontColor: AppColors.title,
              ),
            ),
            GetBuilder<HistoryScreenController>(
              id: Constant.idSelectMonth,
              builder: (logic) {
                return GestureDetector(
                  onTap: () {
                    logic.onClickMonth();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.specialistBox,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          logic.selectedDate.toString(),
                          style: FontStyle.fontStyleW600(
                            fontSize: 15,
                            fontColor: AppColors.degreeText,
                          ),
                        ).paddingOnly(right: 5),
                        Image.asset(
                          AppAsset.icArrowDown,
                          height: 22,
                          color: AppColors.degreeText,
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        )
      ],
    ).paddingOnly(top: 15, left: 15, right: 15);
  }
}

/// =================== List View =================== ///
class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.getHistory.isEmpty
            ? logic.isLoading
                ? Shimmers.walletHistoryShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundHistory.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onHistoryRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getHistory.length,
                        controller: logic.historyScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getHistory.length,
                            child: HistoryListItemView(index: index),
                          );
                        },
                      ).paddingOnly(bottom: 15),
                    ),
                    logic.isLoading1
                        ? CircularProgressIndicator(
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(bottom: 10)
                        : const SizedBox()
                  ],
                ),
              );
      },
    );
  }
}

class HistoryListItemView extends StatelessWidget {
  final int index;

  const HistoryListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height * 0.1,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 0.8, color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.15),
            offset: const Offset(
              0.0,
              0.0,
            ),
            blurRadius: 1,
          ), //BoxShadow
        ],
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: GetBuilder<HistoryScreenController>(
        id: Constant.idProgressView,
        builder: (logic) {
          DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(logic.getHistory[index].date ?? "");
          logic.historyDate = DateFormat("dd/MM/yyyy").format(parsedDate);
          logic.date.add(logic.historyDate);

          return Row(
            children: [
              Container(
                height: Get.height * 0.08,
                width: Get.width * 0.16,
                decoration: BoxDecoration(
                  color: logic.getHistory[index].type == 1 ? AppColors.greenBox : AppColors.redBox,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  logic.getHistory[index].type == 1 ? AppAsset.icWalletAdd : AppAsset.icWalletMinus,
                ).paddingAll(7),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    logic.getHistory[index].type == 1 ? EnumLocale.txtAddWallet.name.tr : EnumLocale.txtPayDoctor.name.tr,
                    style: FontStyle.fontStyleW600(
                      fontSize: 15,
                      fontColor: logic.getHistory[index].type == 1 ? AppColors.walletGreen : AppColors.notificationTitle2,
                    ),
                  ),
                  Text(
                    "#${logic.getHistory[index].uniqueId}",
                    style: FontStyle.fontStyleW500(
                      fontSize: 14,
                      fontColor: AppColors.degreeText,
                    ),
                  ),
                  Text(
                    "${logic.date[index]} ${logic.getHistory[index].time}",
                    style: FontStyle.fontStyleW500(
                      fontSize: 12,
                      fontColor: AppColors.degreeText,
                    ),
                  ),
                ],
              ).paddingOnly(top: 10, bottom: 10, left: 10),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                decoration: BoxDecoration(
                  color: logic.getHistory[index].type == 1 ? AppColors.greenBox : AppColors.redBox,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  logic.getHistory[index].type == 1
                      ? "+ ${logic.getHistory[index].amount}"
                      : "- ${logic.getHistory[index].amount}",
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: logic.getHistory[index].type == 1 ? AppColors.walletGreen : AppColors.notificationTitle2,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
