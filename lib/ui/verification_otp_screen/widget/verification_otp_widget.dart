import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/ui/verification_otp_screen/controller/verification_otp_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

/// =================== App Bar =================== ///
class VerificationOtpAppBarView extends StatelessWidget {
  const VerificationOtpAppBarView({super.key});

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
class VerificationOtpDesView extends StatelessWidget {
  const VerificationOtpDesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.desPleaseFillDetail.name.tr,
      textAlign: TextAlign.center,
      style: FontStyle.fontStyleW400(
        fontSize: 15,
        fontColor: AppColors.registrationDes,
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== OTP =================== ///
class VerificationOtpView extends StatelessWidget {
  const VerificationOtpView({super.key});

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

    return GetBuilder<VerificationOtpController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: CustomTitle(
            title: EnumLocale.txtEnterOTP.name.tr,
            method: Center(
              child: Pinput(
                length: 4,
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
class VerificationOtpResendOtpView extends StatelessWidget {
  const VerificationOtpResendOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationOtpController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              logic.onResendOtpClick(context);
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
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class VerificationOtpBottomView extends StatelessWidget {
  const VerificationOtpBottomView({super.key});

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
          GetBuilder<VerificationOtpController>(
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
