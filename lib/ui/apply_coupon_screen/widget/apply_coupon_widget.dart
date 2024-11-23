import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/ui/apply_coupon_screen/controller/apply_coupon_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class ApplyCouponAppBarView extends StatelessWidget {
  const ApplyCouponAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtApplyCoupon.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Bottom View =================== ///
class ApplyCouponBottomView extends StatelessWidget {
  const ApplyCouponBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 8.0,
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<ApplyCouponController>(
            id: Constant.idProgressView,
            builder: (logic) {
              return GestureDetector(
                onTap: () {
                  logic.onCouponDiscountAmount();
                },
                child: PrimaryAppButton(
                  height: Get.height * 0.06,
                  width: Get.width * 0.90,
                  borderRadius: 11,
                  gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                  text: EnumLocale.txtApplyCouponCode.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 16,
                    fontColor: AppColors.white,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

/// =================== List View =================== ///
class ApplyCouponListView extends StatelessWidget {
  const ApplyCouponListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.applyCouponShimmer()
            : logic.couponData?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundCoupon.name.tr,
                    padding: const EdgeInsets.only(top: 10),
                    textSize: 14,
                  )
                : ListView.builder(
                    itemCount: logic.couponData?.data?.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ApplyCouponListItemView(index: index);
                    },
                  ).paddingOnly(top: 20, bottom: 20);
      },
    );
  }
}

class ApplyCouponListItemView extends StatelessWidget {
  final int index;

  const ApplyCouponListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onApplyCoupon(index);

            logic.couponId = logic.couponData?.data?[index].code ?? "";
          },
          child: Container(
            height: Get.height * 0.17,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(AppAsset.imCouponBox),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      logic.couponData?.data?[index].title ?? "",
                      style: FontStyle.fontStyleW700(
                        fontSize: 16,
                        fontColor: AppColors.green,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(color: AppColors.yellowBg, borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Image.asset(
                            AppAsset.icCoupon1,
                            height: 22,
                            width: 22,
                          ).paddingOnly(right: 8),
                          Text(
                            logic.couponData?.data?[index].code ?? "",
                            style: FontStyle.fontStyleW600(
                              fontSize: 13,
                              fontColor: AppColors.rating,
                            ),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${EnumLocale.txtOfferValidity.name.tr}  ',
                        style: FontStyle.fontStyleW600(
                          fontSize: 13,
                          fontColor: AppColors.degreeText,
                        ),
                        children: [
                          TextSpan(
                            text: logic.date[index],
                            style: FontStyle.fontStyleW600(
                              fontSize: 13,
                              fontColor: AppColors.sortByBorder,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.6,
                      child: Text(
                        "* ${logic.couponData?.data?[index].description}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: FontStyle.fontStyleW500(
                          fontSize: 12.5,
                          fontColor: AppColors.sortByBorder,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(top: 13, bottom: 13, left: 28),
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.applyCoupon == index ? AppColors.sortByBorder : AppColors.border,
                      width: 1.2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: logic.applyCoupon == index
                      ? Container(
                          height: Get.height * 0.05,
                          width: Get.width * 0.05,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                            ),
                            shape: BoxShape.circle,
                          ),
                        )
                      : const SizedBox.shrink(),
                ).paddingOnly(right: Get.width * 0.07)
              ],
            ),
          ).paddingOnly(bottom: 15),
        );
      },
    );
  }
}
