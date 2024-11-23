import 'dart:developer';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/main_screen/controller/main_screen_controller.dart';
import 'package:doctor/ui/registration_screen/controller/registration_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    RegistrationController registrationController = Get.put(RegistrationController());
    MainScreenController mainScreenController = Get.put(MainScreenController());

    log("Gender is :: ${registrationController.gender}");

    return SizedBox(
      height: Get.height * 0.50,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(115),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Image.asset(AppAsset.icLogOut),
            Text(
              EnumLocale.txtLogOut.name.tr,
              style: FontStyle.fontStyleW700(
                fontSize: 22,
                fontColor: AppColors.title,
              ),
            ).paddingOnly(top: 8),
            Text(
              EnumLocale.desWantLogOut.name.tr,
              textAlign: TextAlign.center,
              style: FontStyle.fontStyleW400(
                fontSize: 15,
                fontColor: AppColors.degreeText,
              ),
            ).paddingOnly(top: 8, bottom: 13),
            const Spacer(),
            PrimaryAppButton(
              onTap: () {
                Constant.storage.erase();

                mainScreenController.googleSignIn.signOut();

                Get.offAllNamed(AppRoutes.initial);
              },
              height: Get.height * 0.06,
              width: Get.width * 0.90,
              color: AppColors.notificationTitle2,
              borderRadius: 54,
              text: EnumLocale.txtLogOut.name.tr,
              textStyle: FontStyle.fontStyleW600(
                fontSize: 15.5,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(top: 20, bottom: 15, left: 15, right: 15),
            PrimaryAppButton(
              onTap: () {
                Get.back();
              },
              height: Get.height * 0.06,
              width: Get.width * 0.90,
              color: AppColors.specialistBox,
              borderRadius: 54,
              text: EnumLocale.txtClose.name.tr,
              textStyle: FontStyle.fontStyleW600(
                fontSize: 15.5,
                fontColor: AppColors.specialist,
              ),
            ).paddingOnly(bottom: 10, left: 15, right: 15)
          ],
        ).paddingAll(15),
      ),
    );
  }
}
