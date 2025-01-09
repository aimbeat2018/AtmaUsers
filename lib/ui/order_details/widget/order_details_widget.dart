import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class OrderDetailsAppBarView extends StatelessWidget {
  const OrderDetailsAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtOrderDetails.name.tr,
      showLeadingIcon: true,
    );
  }
}

class OrderSuccessfulTitle extends StatelessWidget {
  const OrderSuccessfulTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 254,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAsset.orderTitleBackImg),
            ),
          ),
          child: Column(
            children: [
              Image.asset(AppAsset.icCheckGreen, height: 70)
                  .paddingOnly(top: 50),
              Text(
                EnumLocale.txtThanksForOrder.name.tr,
                style: FontStyle.fontStyleW400(
                  fontSize: 18,
                  fontColor: AppColors.white,
                ),
              ).paddingOnly(top: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderSummaryView extends StatelessWidget {
  const OrderSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Expected Date",
                    style: FontStyle.fontStyleW400(
                      fontSize: 14,
                      fontColor: AppColors.textGrey,
                    ),
                  ),
                  Text(
                    "12 Jan 2024",
                    style: FontStyle.fontStyleW500(
                      fontSize: 16,
                      fontColor: AppColors.black,
                    ),
                  ),
                ],
              ),
              VerticalDivider(
                indent: 2,
                endIndent: 2,
                color: AppColors.black,
              ),
              Column(
                children: [
                  Text(
                    "Expected Date",
                    style: FontStyle.fontStyleW400(
                      fontSize: 14,
                      fontColor: AppColors.textGrey,
                    ),
                  ),
                  Text(
                    "12 Jan 2024",
                    style: FontStyle.fontStyleW500(
                      fontSize: 16,
                      fontColor: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(top: 50),
        ),
        IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                VerticalDivider(
                  indent: 14,
                  endIndent: 2,
                  thickness: 3,
                  color: AppColors.primaryAppColor1,
                ).paddingOnly(left: 15),
                Text(
                  EnumLocale.txtOrderSummary.name.tr,
                  style: FontStyle.fontStyleW600(
                    fontSize: 17,
                    fontColor: AppColors.black,
                  ),
                ).paddingOnly(top: 15, left: 5),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          // height: 100,
          decoration: BoxDecoration(
              color: AppColors.containerBg,
              borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.containerBg2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                  // borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      EnumLocale.txtProducts.name.tr,
                      style: FontStyle.fontStyleW600(
                        fontSize: 14,
                        fontColor: AppColors.primaryAppColor1,
                      ),
                    ),
                    Text(
                      EnumLocale.txtPrice.name.tr,
                      style: FontStyle.fontStyleW600(
                        fontSize: 14,
                        fontColor: AppColors.primaryAppColor1,
                      ),
                    ),
                  ],
                ).paddingOnly(top: 3, left: 10, right: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Moov Cool Therapy Gel",
                    style: FontStyle.fontStyleW600(
                      fontSize: 14,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ),
                  Text(
                    "₹${200}",
                    style: FontStyle.fontStyleW600(
                      fontSize: 14,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ),
                ],
              ).paddingOnly(top: 7, left: 10, right: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Revital H for Women Tablet",
                    style: FontStyle.fontStyleW600(
                      fontSize: 14,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ),
                  Text(
                    "₹${310}",
                    style: FontStyle.fontStyleW600(
                      fontSize: 14,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ),
                ],
              ).paddingOnly(top: 7, left: 10, right: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Revital H for Women Tablet",
                    style: FontStyle.fontStyleW600(
                      fontSize: 14,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ),
                  Text(
                    "₹${310}",
                    style: FontStyle.fontStyleW600(
                      fontSize: 14,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ),
                ],
              ).paddingOnly(top: 7, left: 10, right: 10),
              Divider(
                indent: 10,
                endIndent: 10,
                color: AppColors.dividerGrey2,
              ).paddingOnly(top: 10),
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
              ).paddingOnly(top: 10, left: 15, right: 15, bottom: 5),
            ],
          ),
        ).paddingOnly(top: 15, left:15, right:15),
      ],
    );
  }
}
