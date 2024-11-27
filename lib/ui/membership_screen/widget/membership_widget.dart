// ignore_for_file: must_be_immutable

import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:doctor/ui/confirm_booking_screen/widget/confirm_booking_widget.dart';
import 'package:doctor/ui/my_wallet_screen/controller/my_wallet_controller.dart';
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
class MembershipBarView extends StatelessWidget {
  const MembershipBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMembership.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Membership packages =================== ///
class MembershipPackagesWidget extends StatelessWidget {
  const MembershipPackagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWalletController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Container(
          // height: Get.height * 0.12,
          width: Get.width,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.categoryCircle,
            border: Border.all(
              width: 1.2,
              color: AppColors.border.withOpacity(0.3),
            ),
            image: const DecorationImage(
              image: AssetImage(AppAsset.imWalletBox),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                EnumLocale.txtAvailableBalance.name.tr,
                style: FontStyle.fontStyleW500(
                  fontSize: 16,
                  fontColor: AppColors.tabUnselectText,
                ),
              ),
              logic.isLoading
                  ? Shimmers.getAmountShimmer()
                  : Text(
                      "$currency $walletAmount",
                      style: FontStyle.fontStyleW700(
                        fontSize: 27,
                        fontColor: AppColors.title,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Button =================== ///
class MembershipCardWidget extends StatelessWidget {
  MembershipCardWidget({super.key});

  ConfirmBookingController confirmBookingController =
      Get.put(ConfirmBookingController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryAppButton(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const ConfirmBookingBottomSheetView(isRecharge: true);
                },
              );
            },
            height: Get.height * 0.065,
            color: AppColors.notificationTitle2,
            borderRadius: 10,
            text: EnumLocale.txtAddAmount.name.tr,
            textStyle: FontStyle.fontStyleW600(
              fontSize: 15,
              fontColor: AppColors.white,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: PrimaryAppButton(
            onTap: () {
              Get.toNamed(AppRoutes.history);
            },
            height: Get.height * 0.065,
            gradientColor: [
              AppColors.primaryAppColor1,
              AppColors.primaryAppColor2,
            ],
            borderRadius: 10,
            text: EnumLocale.txtHistory.name.tr,
            textStyle: FontStyle.fontStyleW600(
              fontSize: 15,
              fontColor: AppColors.white,
            ),
          ),
        )
      ],
    ).paddingOnly(left: 15, right: 15);
  }
}
