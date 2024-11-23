import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/login_screen/controller/login_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Back Button =================== ///
class LoginBackView extends StatelessWidget {
  const LoginBackView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        AppAsset.icArrowRight,
        height: 23,
        width: 23,
      ).paddingOnly(top: 43, left: 20),
    );
  }
}

/// =================== Background Image =================== ///
class LoginImageView extends StatelessWidget {
  const LoginImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAsset.imDoctor1,
      height: 400,
      width: 400,
    ).paddingOnly(top: Get.height * 0.12, left: 15, right: 15);
  }
}

/// =================== Information =================== ///
class LoginAddInfoView extends StatelessWidget {
  const LoginAddInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.5,
        width: Get.width,
        color: AppColors.white,
        padding: const EdgeInsets.all(15),
        child: const Column(
          children: [
            LoginInfoView(),
            LoginForgotPasswordView(),
            LoginButtonView(),
            Spacer(),
            LoginTncAndPolicyView(),
          ],
        ),
      ),
    );
  }
}

/// =================== Add Information(TextFormField) =================== ///
class LoginInfoView extends StatelessWidget {
  const LoginInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
            children: [
              CustomTitle(
                title: EnumLocale.txtEmail.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.emailController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 14,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterEmail.name.tr;
                    } else if (!logic.isEmailValid(value)) {
                      return EnumLocale.desEnterValidEmailAddress.name.tr;
                    }

                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20, top: 10),
              CustomTitle(
                title: EnumLocale.txtPassword.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.passwordController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 14,
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
                      return EnumLocale.desReEnterPassword.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 10),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Forgot Password =================== ///
class LoginForgotPasswordView extends StatelessWidget {
  const LoginForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.forgotPassword);
        },
        child: Text(
          EnumLocale.txtForgetPassword.name.tr,
          style: FontStyle.fontStyleW600(
            fontSize: 15,
            fontColor: AppColors.bottomLabel,
          ),
        ).paddingOnly(right: 5),
      ),
    );
  }
}

/// =================== Button =================== ///
class LoginButtonView extends StatelessWidget {
  const LoginButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
      id: Constant.idLogIn,
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onLogInClick();

          },
          height: Get.height * 0.065,
          width: Get.width,
          borderRadius: 10,
          text: EnumLocale.txtLogIn.name.tr,
          textStyle: FontStyle.fontStyleW600(
            fontSize: 16,
            fontColor: AppColors.white,
          ),
          gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
        ).paddingOnly(left: 17, right: 17, top: 20);
      },
    );
  }
}

/// =================== Terms-Condition & Policy =================== ///
class LoginTncAndPolicyView extends StatelessWidget {
  const LoginTncAndPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        Utils.launchURL(tnc ?? "");
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: EnumLocale.desByProceedingForward.name.tr,
          style: FontStyle.fontStyleW400(
            fontSize: 14,
            fontColor: AppColors.accountLogin,
          ),
          children: [
            TextSpan(
              text: '\n${EnumLocale.txtPrivacyPolicy.name.tr}',
              style: FontStyle.fontStyleW600(
                  fontSize: 14,
                  fontColor: AppColors.bottomLabel,
                  textDecoration: TextDecoration.underline,
                  decorationColor: AppColors.bottomLabel),
            ),
            TextSpan(
              text: ' ${EnumLocale.txtAnd.name.tr} ',
              style: FontStyle.fontStyleW400(
                fontSize: 14,
                fontColor: AppColors.accountLogin,
              ),
            ),
            TextSpan(
              text: EnumLocale.txtTermsCondition.name.tr,
              style: FontStyle.fontStyleW600(
                  fontSize: 14,
                  fontColor: AppColors.bottomLabel,
                  textDecoration: TextDecoration.underline,
                  decorationColor: AppColors.bottomLabel),
            ),
          ],
        ),
      ).paddingOnly(bottom: 10),
    );
  }
}
