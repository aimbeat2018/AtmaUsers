import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/ui/set_password_screen/controller/set_password_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class SetPasswordAppBarView extends StatelessWidget {
  const SetPasswordAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtSetPassword.name.tr,
      showLeadingIcon: true,
      gradientColor: [AppColors.appBarBg, AppColors.appBarBg],
      iconColor: AppColors.title,
      textColor: AppColors.title,
    );
  }
}

/// =================== Description =================== ///
class SetPasswordDesView extends StatelessWidget {
  const SetPasswordDesView({super.key});

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

class SetPasswordReEnterPasswordView extends StatelessWidget {
  const SetPasswordReEnterPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetPasswordController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                title: EnumLocale.txtPassword.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.passwordController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  obscureText: logic.isObscure,
                  maxLines: 1,
                  suffixIcon: logic.isObscure
                      ? InkWell(
                          onTap: () {
                            logic.onClickObscure();
                          },
                          child: Image.asset(
                            AppAsset.icEyeUnVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        )
                      : InkWell(
                          onTap: () {
                            logic.onClickObscure();
                          },
                          child: Image.asset(
                            AppAsset.icEyeVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterPassword.name.tr;
                    } else if (value.length < 6) {
                      return EnumLocale.desPasswordCharacters.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtRePassword.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.rePasswordController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  obscureText: logic.isObscure1,
                  maxLines: 1,
                  suffixIcon: logic.isObscure1
                      ? InkWell(
                          onTap: () {
                            logic.onClickObscure1();
                          },
                          child: Image.asset(
                            AppAsset.icEyeUnVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        )
                      : InkWell(
                          onTap: () {
                            logic.onClickObscure1();
                          },
                          child: Image.asset(
                            AppAsset.icEyeVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desReEnterPassword.name.tr;
                    } else if (value != logic.passwordController.text) {
                      return EnumLocale.desPasswordNotMatch.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
            ],
          ).paddingOnly(top: 15),
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class SetPasswordBottomView extends StatelessWidget {
  const SetPasswordBottomView({super.key});

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
          GetBuilder<SetPasswordController>(
            builder: (logic) {
              return PrimaryAppButton(
                onTap: () {
                  logic.onConfirmClick(context);
                },
                height: Get.height * 0.06,
                width: Get.width * 0.90,
                borderRadius: 11,
                gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                text: EnumLocale.txtConfirm.name.tr,
                textStyle: FontStyle.fontStyleW600(
                  fontSize: 16,
                  fontColor: AppColors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
