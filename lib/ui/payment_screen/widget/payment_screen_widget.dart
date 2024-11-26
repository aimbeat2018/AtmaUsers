import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/ui/payment_screen/controller/payment_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class PaymentAppBarView extends StatelessWidget {
  const PaymentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtPayment.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Title =================== ///
class PaymentTitleView extends StatelessWidget {
  const PaymentTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.txtSelectPaymentMethod.name.tr,
      style: FontStyle.fontStyleW600(
        fontSize: 16.5,
        fontColor: AppColors.title,
      ),
    ).paddingOnly(top: 15, left: 15, bottom: 15);
  }
}

/// =================== Payment List =================== ///
class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isRazorPay == true ? const RazorpayPaymentView() : const SizedBox(),
        isStripePay == true ? const StripePaymentView() : const SizedBox(),
        isFlutterWave == true ? const FlutterWavePaymentView() : const SizedBox(),

        CashView()
      ],
    );
  }
}

class RazorpayPaymentView extends StatelessWidget {
  const RazorpayPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idSelectPayment,
      builder: (logic) {
        return InkWell(
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          onTap: () {
            logic.onSelectPayment(0);
          },
          child: Container(
            height: Get.height * 0.085,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1,
                ), //BoxShadow
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.specialistBox,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAsset.icRazorpay).paddingAll(7),
                ).paddingOnly(right: 15),
                Text(
                  "Razorpay",
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.sortByBorder,
                  ),
                ),
                const Spacer(),
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.selectPayment == 0 ? AppColors.sortByBorder : AppColors.border,
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: logic.selectPayment == 0
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
                )
              ],
            ).paddingOnly(left: 15, right: 18),
          ).paddingOnly(bottom: 13, left: 15, right: 15),
        );
      },
    );
  }
}

class StripePaymentView extends StatelessWidget {
  const StripePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idSelectPayment,
      builder: (logic) {
        return InkWell(
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          onTap: () {
            logic.onSelectPayment(1);
          },
          child: Container(
            height: Get.height * 0.085,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1,
                ), //BoxShadow
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.specialistBox,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAsset.icStripe).paddingAll(7),
                ).paddingOnly(right: 15),
                Text(
                  "Stripe",
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.sortByBorder,
                  ),
                ),
                const Spacer(),
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.selectPayment == 1 ? AppColors.sortByBorder : AppColors.border,
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: logic.selectPayment == 1
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
                )
              ],
            ).paddingOnly(left: 15, right: 18),
          ).paddingOnly(bottom: 13, left: 15, right: 15),
        );
      },
    );
  }
}

class FlutterWavePaymentView extends StatelessWidget {
  const FlutterWavePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idSelectPayment,
      builder: (logic) {
        return InkWell(
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          onTap: () {
            logic.onSelectPayment(2);
          },
          child: Container(
            height: Get.height * 0.085,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1,
                ), //BoxShadow
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.specialistBox,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAsset.icFlutterWave).paddingAll(7),
                ).paddingOnly(right: 15),
                Text(
                  "Flutter Wave",
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.sortByBorder,
                  ),
                ),
                const Spacer(),
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.selectPayment == 2 ? AppColors.sortByBorder : AppColors.border,
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: logic.selectPayment == 2
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
                )
              ],
            ).paddingOnly(left: 15, right: 18),
          ).paddingOnly(bottom: 13, left: 15, right: 15),
        );
      },
    );
  }
}

class CashView extends StatelessWidget {
  const CashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentScreenController>(
      id: Constant.idSelectPayment,
      builder: (logic) {
        return InkWell(
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          onTap: () {
            logic.onSelectPayment(3);
          },
          child: Container(
            height: Get.height * 0.085,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1,
                ), //BoxShadow
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.specialistBox,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppAsset.icCash).paddingAll(7),
                ).paddingOnly(right: 15),
                Text(
                  "Cash",
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.sortByBorder,
                  ),
                ),
                const Spacer(),
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: logic.selectPayment == 3 ? AppColors.sortByBorder : AppColors.border,
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: logic.selectPayment == 3
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
                )
              ],
            ).paddingOnly(left: 15, right: 18),
          ).paddingOnly(bottom: 13, left: 15, right: 15),
        );
      },
    );
  }
}

/// =================== Bottom Bar =================== ///
class PaymentBottomView extends StatelessWidget {
  const PaymentBottomView({super.key});

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
            ), //BoxShadow
          ],
        ),
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: GetBuilder<PaymentScreenController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryAppButton(
                  onTap: () {
                    logic.onSelectPaymentMethod(context);
                  },
                  height: Get.height * 0.06,
                  width: Get.width * 0.90,
                  borderRadius: 11,
                  gradientColor: [AppColors.call1, AppColors.call2],
                  text: EnumLocale.txtPayNow.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 16,
                    fontColor: AppColors.white,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
