import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/dialog/review_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallCutDialog extends StatelessWidget {
  final String image;
  final String name;
  final String designation;
  final String duration;
  final String doctorId;

  const CallCutDialog({
    super.key,
    required this.image,
    required this.name,
    required this.designation,
    required this.duration,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.6,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(115),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Container(
              height: Get.height * 0.15,
              width: Get.height * 0.15,
              decoration: BoxDecoration(color: AppColors.primaryAppColor1, shape: BoxShape.circle),
              padding: const EdgeInsets.all(3),
              child: Container(
                height: Get.height * 0.1,
                width: Get.height * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryAppColor1,
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                  },
                ),
              ),
            ).paddingOnly(top: 15, bottom: 7),
            Text(
              name,
              style: FontStyle.fontStyleW700(
                fontSize: 20,
                fontColor: AppColors.title,
              ),
            ).paddingOnly(top: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(color: AppColors.specialistBox, borderRadius: BorderRadius.circular(6)),
              child: Text(
                designation,
                style: FontStyle.fontStyleW500(
                  fontSize: 12,
                  fontColor: AppColors.dialogText,
                ),
              ),
            ).paddingOnly(top: 15, bottom: 13),
            Text(
              EnumLocale.txtCallDuration.name.tr,
              style: FontStyle.fontStyleW500(
                fontSize: 16,
                fontColor: AppColors.grey,
              ),
            ),
            Text(
              duration,
              style: FontStyle.fontStyleW700(
                fontSize: 23,
                fontColor: AppColors.title,
              ),
            ).paddingOnly(top: 8, bottom: 8),
            Text(
              EnumLocale.txtMinutes.name.tr,
              style: FontStyle.fontStyleW500(
                fontSize: 13,
                fontColor: AppColors.title,
              ),
            ),
            const Spacer(),
            PrimaryAppButton(
              onTap: () {
                Get.back();

                Get.dialog(
                  barrierColor: AppColors.black.withOpacity(0.8),
                  Dialog(
                    backgroundColor: AppColors.transparent,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    child: ReviewDialog(
                      appointmentId: '',
                      doctorId: doctorId,
                    ),
                  ),
                );
              },
              height: Get.height * 0.06,
              width: Get.width * 0.93,
              color: AppColors.rating,
              borderRadius: 54,
              text: EnumLocale.txtGiveReview.name.tr,
              textStyle: FontStyle.fontStyleW600(
                fontSize: 16,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(top: 20, bottom: 15),
            PrimaryAppButton(
              onTap: () {
                Get.offAllNamed(AppRoutes.bottom);
              },
              height: Get.height * 0.06,
              width: Get.width * 0.93,
              gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
              borderRadius: 54,
              text: EnumLocale.txtBackHomePage.name.tr,
              textStyle: FontStyle.fontStyleW600(
                fontSize: 16,
                fontColor: AppColors.white,
              ),
            ).paddingOnly(bottom: 5)
          ],
        ).paddingAll(15),
      ),
    );
  }
}
