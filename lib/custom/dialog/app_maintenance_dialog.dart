import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMaintenanceDialog extends StatelessWidget {
  const AppMaintenanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.52,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(115),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Image.asset(
              AppAsset.icAppMaintenance,
              height: 200,
            ),
            Text(
              EnumLocale.txtUnderMaintenance.name.tr,
              textAlign: TextAlign.center,
              style: FontStyle.fontStyleW700(
                fontSize: 22,
                fontColor: AppColors.title,
              ),
            ).paddingOnly(top: 8),
            Text(
              EnumLocale.desEnterUnderAppMaintenance.name.tr,
              textAlign: TextAlign.center,
              style: FontStyle.fontStyleW400(
                fontSize: 15,
                fontColor: AppColors.degreeText,
              ),
            ).paddingOnly(top: 8, bottom: 13, left: 15, right: 15),
            const Spacer(),
            PrimaryAppButton(
              onTap: () {
                Get.back();
              },
              height: Get.height * 0.06,
              width: Get.width * 0.93,
              color: AppColors.notificationTitle2,
              borderRadius: 54,
              text: EnumLocale.txtCloseApp.name.tr,
              textStyle: FontStyle.fontStyleW600(
                fontSize: 15.5,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(top: 20, bottom: 15, left: 15, right: 15),
          ],
        ).paddingAll(15),
      ),
    );
  }
}
