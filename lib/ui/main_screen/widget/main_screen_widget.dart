import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/main_screen/controller/main_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Description =================== ///
class MainDescriptionView extends StatelessWidget {
  const MainDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            width: Get.width,
            color: AppColors.primaryAppColor1,
            alignment: Alignment.bottomCenter,
            child: Image.asset(AppAsset.imDoctor, width: Get.height / 2.5),
          ),
        ),
        SizedBox(height: Get.height * 0.03),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Text(
                EnumLocale.desMultiVendorApp.name.tr,
                textAlign: TextAlign.center,
                style: FontStyle.fontStyleW700(
                  fontSize: 17,
                  fontColor: AppColors.bottomLabel,
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Text(
                EnumLocale.desFindDoctors.name.tr,
                textAlign: TextAlign.center,
                style: FontStyle.fontStyleW400(
                  fontSize: 14.5,
                  fontColor: AppColors.loginDes,
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              GetBuilder<MainScreenController>(
                id: Constant.idProgressView,
                builder: (logic) {
                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            logic.signInWithGoogle();
                          },
                          child: Container(
                            height: Get.height * 0.059,
                            decoration: BoxDecoration(
                              color: AppColors.loginBox,
                              border: Border.all(
                                color: AppColors.loginBorder,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: AppColors.google,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(AppAsset.icGoogle).paddingAll(8),
                                ).paddingOnly(left: 5),
                                const Spacer(),
                                Text(
                                  EnumLocale.txtGoogleLogIn.name.tr,
                                  textAlign: TextAlign.center,
                                  style: FontStyle.fontStyleW600(
                                    fontSize: 14,
                                    fontColor: AppColors.loginText,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.addNumber);
                        },
                        child: Container(
                          height: Get.height * 0.059,
                          decoration: BoxDecoration(
                            color: AppColors.loginBox,
                            border: Border.all(
                              color: AppColors.loginBorder,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                  color: AppColors.google,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(AppAsset.icMobile).paddingAll(8),
                              ).paddingOnly(left: 5),
                              const Spacer(),
                              Text(
                                EnumLocale.txtMobileLogIn.name.tr,
                                textAlign: TextAlign.center,
                                style: FontStyle.fontStyleW600(
                                  fontSize: 14,
                                  fontColor: AppColors.loginText,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      )),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height * 0.03),
      ],
    );
  }
}
