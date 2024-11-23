import 'dart:async';
import 'dart:developer';

import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/ui/number_otp_screen/controller/number_otp_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

/// =================== App Bar =================== ///
class NumberOtpAppBarView extends StatelessWidget {
  const NumberOtpAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtVerification.name.tr,
      showLeadingIcon: true,
      gradientColor: [AppColors.appBarBg, AppColors.appBarBg],
      iconColor: AppColors.title,
      textColor: AppColors.title,
    );
  }
}

/// =================== Description =================== ///
class NumberOtpDesView extends StatelessWidget {
  const NumberOtpDesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          EnumLocale.desPleaseFillDetail.name.tr,
          textAlign: TextAlign.center,
          style: FontStyle.fontStyleW400(
            fontSize: 15,
            fontColor: AppColors.registrationDes,
          ),
        ).paddingOnly(bottom: 10),
        GetBuilder<NumberOtpController>(
          builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  EnumLocale.desSendOtpNumber.name.tr,
                  textAlign: TextAlign.center,
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.title,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "${logic.dialCode} ${logic.number}",
                  textAlign: TextAlign.center,
                  style: FontStyle.fontStyleW700(
                    fontSize: 15,
                    fontColor: AppColors.title,
                  ),
                ),
              ],
            ).paddingOnly(bottom: 20);
          },
        )
      ],
    );
  }
}

/// =================== OTP =================== ///
class NumberOtpView extends StatelessWidget {
  const NumberOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: FontStyle.fontStyleW600(
        fontSize: 20,
        fontColor: AppColors.otp,
      ),
      decoration: BoxDecoration(
        color: AppColors.categoryCircle,
        border: Border.all(color: AppColors.title),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return GetBuilder<NumberOtpController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: CustomTitle(
            title: EnumLocale.txtEnterOTP.name.tr,
            method: Center(
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                controller: logic.otpController,
                pinAnimationType: PinAnimationType.rotation,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return EnumLocale.desEnterOtp.name.tr;
                  }
                  return null;
                },
                errorPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.redBox,
                    border: Border.all(color: AppColors.notificationTitle2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                errorTextStyle: FontStyle.fontStyleW500(
                  fontSize: 11,
                  fontColor: AppColors.notificationTitle2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Resend OTP =================== ///
class NumberOtpResendOtpView extends StatelessWidget {
  const NumberOtpResendOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NumberOtpController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              overlayColor: WidgetStatePropertyAll(AppColors.transparent),
              child: Text(
                EnumLocale.txtChangeNumber.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 14,
                  fontColor: AppColors.notificationTitle2,
                  decorationColor: AppColors.notificationTitle2,
                  textDecoration: TextDecoration.underline,
                ),
              ).paddingOnly(top: 20),
            ),
            InkWell(
              onTap: () {
                log("Constant.storage.read( :: ${Constant.storage.read("isResendOtp")}");

                if (Constant.storage.read("isResendOtp") == true) {
                  logic.timer = Timer(const Duration(seconds: 30), () {
                    Constant.storage.write("isResendOtp", false);
                  });
                } else {
                  logic.onResendOtpClick(context);
                }
              },
              overlayColor: WidgetStatePropertyAll(AppColors.transparent),
              child: Text(
                EnumLocale.txtResendOTP.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 14,
                  fontColor: AppColors.otp,
                  decorationColor: AppColors.otp,
                  textDecoration: TextDecoration.underline,
                ),
              ).paddingOnly(top: 20),
            ),
          ],
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class NumberOtpBottomView extends StatelessWidget {
  const NumberOtpBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.085,
      width: Get.width,
      color: AppColors.transparent,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<NumberOtpController>(
            builder: (logic) {
              return PrimaryAppButton(
                onTap: () {
                  logic.onVerifyClick(context);
                },
                height: Get.height * 0.06,
                width: Get.width * 0.90,
                borderRadius: 11,
                gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                text: EnumLocale.txtVerify.name.tr,
                textStyle: FontStyle.fontStyleW600(
                  fontSize: 16,
                  fontColor: AppColors.white,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
