import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewDialog extends StatelessWidget {
  final String appointmentId;
  final String doctorId;

  const ReviewDialog({super.key, required this.appointmentId, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.55,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(115),
          ),
        ),
        color: AppColors.white,
        child: GetBuilder<AppointmentScreenController>(
          id: Constant.idSelectStar,
          builder: (logic) {
            return Column(
              children: [
                Text(
                  EnumLocale.txtGiveReview.name.tr,
                  style: FontStyle.fontStyleW700(
                    fontSize: 21,
                    fontColor: AppColors.title,
                  ),
                ).paddingOnly(top: 8),
                Text(
                  EnumLocale.desEnterGiveReview.name.tr,
                  textAlign: TextAlign.center,
                  style: FontStyle.fontStyleW400(
                    fontSize: 12,
                    fontColor: AppColors.degreeText,
                  ),
                ).paddingOnly(top: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          logic.onSelectedStar(index);
                        },
                        child: Image.asset(
                          index <= logic.selectedStarIndex ? AppAsset.icStarFilled : AppAsset.icStarOutline,
                          height: 30,
                          width: 30,
                        ).paddingOnly(left: 8, right: 8),
                      );
                    },
                  ),
                ),
                CustomTextField(
                  controller: logic.reviewController,
                  filled: true,
                  fillColor: AppColors.specialistBox,
                  maxLines: 5,
                  hintText: EnumLocale.txtExplainYourServices.name.tr,
                  hintTextSize: 12,
                  hintTextColor: AppColors.hintText,
                ).paddingOnly(bottom: 20),
                PrimaryAppButton(
                  onTap: () async {
                    if (logic.selectedStarIndex == -1) {
                      Utils.showToast(Get.context!, EnumLocale.toastEnterDetails.name.tr);
                    } else {
                      await logic.onPostReviewApiCall(
                        appointmentId: appointmentId,
                        rating: logic.selectedStarIndex + 1,
                        review: logic.reviewController.text,
                        type: appointmentId.isNotEmpty ? 1 : 2,
                        doctorId: doctorId,
                        userId: Constant.storage.read("userId"),
                      );

                      Utils.showToast(Get.context!, logic.postReviewModel?.message ?? "");

                      if (logic.postReviewModel?.status == true) {
                        Get.back();
                        logic.startCompleted = 0;
                        logic.getComplete = [];

                        await logic.onGetAppointmentApiCall(
                          userId: Constant.storage.read("userId"),
                          status: "3",
                          start: logic.startCompleted.toString(),
                          limit: logic.limitCompleted.toString(),
                          startDate: 'ALL',
                          endDate: 'ALL',
                        );
                      }
                    }
                  },
                  height: Get.height * 0.06,
                  width: Get.width * 0.93,
                  gradientColor: [AppColors.call1, AppColors.call2],
                  borderRadius: 54,
                  text: EnumLocale.txtSubmit.name.tr,
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
                  width: Get.width * 0.90,
                  color: AppColors.specialistBox,
                  borderRadius: 54,
                  text: EnumLocale.txtBackHomePage.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 16,
                    fontColor: AppColors.specialist,
                  ),
                ).paddingOnly(bottom: 5)
              ],
            ).paddingAll(15);
          },
        ),
      ),
    );
  }
}
