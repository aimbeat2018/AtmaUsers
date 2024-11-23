import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/ui/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class ForgotPasswordAppBarView extends StatelessWidget {
  const ForgotPasswordAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtForgetPasswordTitle.name.tr,
      showLeadingIcon: true,
      gradientColor: [AppColors.appBarBg, AppColors.appBarBg],
      iconColor: AppColors.title,
      textColor: AppColors.title,
    );
  }
}

/// =================== Description =================== ///
class ForgotPasswordDesView extends StatelessWidget {
  const ForgotPasswordDesView({super.key});

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

/// =================== Email =================== ///
class ForgotPasswordEmailView extends StatelessWidget {
  const ForgotPasswordEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: CustomTitle(
            title: EnumLocale.txtEnterEmail.name.tr,
            method: CustomTextField(
              controller: logic.emailController,
              filled: true,
              fillColor: AppColors.categoryCircle,
              cursorColor: AppColors.title,
              fontColor: AppColors.title,
              fontSize: 16,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return EnumLocale.desEnterEmail.name.tr;
                } else if (!logic.isEmailValid(value)) {
                  return EnumLocale.desEnterValidEmailAddress.name.tr;
                }

                return null;
              },
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class ForgotPasswordBottomView extends StatelessWidget {
  const ForgotPasswordBottomView({super.key});

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
          GetBuilder<ForgotPasswordController>(
            builder: (logic) {
              return PrimaryAppButton(
                onTap: () {
                  logic.onContinueClick(context);
                },
                height: Get.height * 0.06,
                width: Get.width * 0.90,
                borderRadius: 11,
                gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
               
               
                text: EnumLocale.txtContinue.name.tr,
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
