// ignore_for_file: must_be_immutable

import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:doctor/ui/confirm_booking_screen/widget/confirm_booking_widget.dart';
import 'package:doctor/ui/membership_screen/controller/membership_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../custom/no_data_found/no_data_found.dart';

/// =================== App Bar =================== ///
class MembershipBarView extends StatelessWidget {
  const MembershipBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtPrivilegeCard.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== List View =================== ///
class MembershipPackagesListView extends StatelessWidget {
  const MembershipPackagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.getMembershipList.isEmpty
            ? logic.isLoading
                ? Shimmers.membershipPackageShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  ).paddingOnly(bottom: Get.height * 0.05, left: 15, right: 15)
            : Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    scrollDirection: Axis.vertical,
                    itemCount: logic.getMembershipList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 800),
                        columnCount: logic.getMembershipList.length,
                        child: MembershipPackagesListItemView(index: index),
                      );
                    },
                  ),
                  // logic.isLoading1
                  //     ? CircularProgressIndicator(
                  //   color: AppColors.primaryAppColor1,
                  // ).paddingOnly(bottom: 10)
                  //     : const SizedBox()
                ],
              );
      },
    );
  }
}

class MembershipPackagesListItemView extends StatelessWidget {
  final int index;

  MembershipPackagesListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipController>(
      id: Constant.idProgressView,
      builder: (logic) {
        // DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(
        //     logic.getMyAppointment[index].date ?? "");
        // logic.expiryDate = DateFormat("dd MMM yyyy").format(parsedDate);
        // logic.date.add(logic.expiryDate);

        return Container(
          // height: Get.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(colors: [
              AppColors.receiverBox,
              AppColors.appBarBg,
              AppColors.notificationBox,
            ]),
            border: Border.all(
              width: 1.5,
              color: AppColors.appointmentBorder,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                logic.getMembershipList[index].title ?? "",
                style: FontStyle.fontStyleW700(
                  fontSize: 14,
                  fontColor: AppColors.title,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Html(
                  data: logic.getMembershipList[index].desc?.isNotEmpty == true
                      ? logic.getMembershipList[index].desc!
                      : "<p>No description available</p>",
                  style: {
                    "body": Style(
                      fontSize: FontSize(13),
                      color: AppColors.title,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  },
                ),
              ),
              Text(
                "$currency ${logic.getMembershipList[index].price}",
                style: FontStyle.fontStyleW700(
                  fontSize: 20,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MembershipCardWidget(index: index)
            ],
          ).paddingAll(12),
        ).paddingOnly(left: 18, right: 18, bottom: 18);
      },
    );
  }
}

/// =================== Button =================== ///
class MembershipCardWidget extends StatelessWidget {
  final int index;

  MembershipCardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipController>(
        id: Constant.idClickBuyMembership,
        builder: (logic) {
          return logic.isLoading && logic.selectedIndex == index
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : PrimaryAppButton(
                  onTap: () {
                    // print("index : " + index.toString());
                    logic.updateIndex(index);

                    logic.onBuyMembership(
                        context,
                        logic.getMembershipList[index].sId!.toString(),
                        "12345");
                  },
                  width: Get.width * 0.5,
                  height: Get.height * 0.045,
                  color: AppColors.primaryAppColor1,
                  borderRadius: 5,
                  text: EnumLocale.txtBuyNow.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 14,
                    fontColor: AppColors.white,
                  ),
                );
        });
  }
}
