import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/dialog/payment_confirm_dialog.dart';
import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:doctor/ui/confirm_booking_screen/widget/confirm_booking_widget.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:intl/intl.dart';

class LabTestsAppBarView extends StatelessWidget {
  const LabTestsAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtAvailableLabs.name.tr,
      showLeadingIcon: true,
    );
  }
}

class DisplayAndEditAddressView extends StatelessWidget {
  const DisplayAndEditAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 20, top: 10.0, left: 10.0, right: 10.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, top: 12.0, bottom: 12.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.containerBg,
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            Image.asset(
                height: 18,
                AppAsset.icLocationFilled2,
                color: AppColors.primaryAppColor1),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                "1904, Haware Infotech Park, Vashi, Navi Mumbai, Maharashtra, 400703",
                style: FontStyle.fontStyleW400(
                  fontSize: 13,
                  fontColor: AppColors.black,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Image.asset(
                      height: 22,
                      AppAsset.icEditAdd,
                      color: AppColors.primaryAppColor1)
                  .paddingOnly(right: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}

class AvailableLabsItems extends StatelessWidget {
  const AvailableLabsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      shrinkWrap: true,
      itemCount: 2,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6.0 / 9,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryAppColor1,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  height: 120,
                  width: 250,
                  imageUrl: AppAsset.availableLabsImg,
                  // fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Image.asset(AppAsset.availableLabsImg)
                        .paddingAll(10);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppAsset.availableLabsImg)
                        .paddingAll(10);
                  },
                ),
              ),
              Text(
                "Metropolis Healthcare Ltd.",
                style: FontStyle.fontStyleW500(
                  fontSize: 12,
                  fontColor: AppColors.yellowTitle,
                ),
              ).paddingOnly(left: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    EnumLocale.txtBloodGlucoseTest.name.tr,
                    style: FontStyle.fontStyleW400(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                  Text(
                    "200",
                    style: FontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                ],
              ).paddingOnly(left: 4.0, right: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    EnumLocale.txtCortisolTest.name.tr,
                    style: FontStyle.fontStyleW400(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                  Text(
                    "200",
                    style: FontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                ],
              ).paddingOnly(left: 4.0, right: 4.0),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    EnumLocale.txtTotal.name.tr,
                    style: FontStyle.fontStyleW400(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                  Text(
                    "2148",
                    style: FontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      minimumSize: const Size(20, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const AvailableLabsBottomSheetView();
                      },
                    );
                  },
                  child: Text(
                    '${EnumLocale.txtBookNow.name.tr} ',
                    style: FontStyle.fontStyleW500(
                      fontSize: 12,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        // HomeCategoryItemView(index: index);
      },
    );
  }
}

class AvailableLabsBottomSheetView extends StatelessWidget {
  const AvailableLabsBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.33,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: AppColors.containerBg,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                EnumLocale.txtBloodGlucoseTest.name.tr,
                style: FontStyle.fontStyleW500(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
              Text(
                '₹ 2350',
                style: FontStyle.fontStyleW500(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
            ],
          ).paddingOnly(top: 20, left: 15, right: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                EnumLocale.txtCortisolTest.name.tr,
                style: FontStyle.fontStyleW500(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
              Text(
                '₹ 1475',
                style: FontStyle.fontStyleW500(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
            ],
          ).paddingOnly(top: 10, left: 15, right: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${EnumLocale.txtGst.name.tr} (18%)',
                style: FontStyle.fontStyleW500(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
              Text(
                '₹ 1475',
                style: FontStyle.fontStyleW500(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
            ],
          ).paddingOnly(top: 10, left: 15, right: 15),
          Divider(
            indent: 10,
            endIndent: 10,
            color: AppColors.dividerGrey2,
          ).paddingOnly(top: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                EnumLocale.txtTotal.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 16,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
              Text(
                '₹ 1475',
                style: FontStyle.fontStyleW600(
                  fontSize: 16,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
            ],
          ).paddingOnly(top: 10, left: 15, right: 15),
          GetBuilder<ConfirmBookingController>(
              id: Constant.idProgressView,
              builder: (logic) {
              return PrimaryAppButton(
                onTap: () {
                  // if (/*walletAmount!*/300< (logic.withDiscountAmount ?? 0)) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const ConfirmBookingBottomSheetView(isRecharge: false);
                    },
                  );
                  // }
                },
                height: Get.height * 0.06,
                width: Get.width * 0.90,
                borderRadius: 11,
                gradientColor: [
                  AppColors.primaryAppColor1,
                  AppColors.primaryAppColor1
                ],
                text: EnumLocale.txtPayNow.name.tr,
                textStyle: FontStyle.fontStyleW600(
                  fontSize: 16,
                  fontColor: AppColors.white,
                ),
              ).paddingOnly(top: 20.0, bottom: 15.0);
            }
          ),
        ],
      ),
    );
  }
}


