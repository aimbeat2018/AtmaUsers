import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelAppointmentDialog extends StatelessWidget {
  final String appointmentId;
  final bool isHomeScreen;
  final bool isViewAll;

  const CancelAppointmentDialog({
    super.key,
    required this.appointmentId,
    required this.isHomeScreen,
    required this.isViewAll,
  });

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.find<HomeScreenController>();

    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height * 0.65,
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
                AppAsset.icCancel,
                height: 90,
                width: 90,
              ),
              Text(
                EnumLocale.txtCancelAppointment.name.tr,
                style: FontStyle.fontStyleW700(
                  fontSize: 22,
                  fontColor: AppColors.title,
                ),
              ).paddingOnly(top: 8),
              Text(
                EnumLocale.desDoCancelAppointment.name.tr,
                textAlign: TextAlign.center,
                style: FontStyle.fontStyleW400(
                  fontSize: 15,
                  fontColor: AppColors.degreeText,
                ),
              ).paddingOnly(top: 8, bottom: 13),
              GetBuilder<AppointmentScreenController>(
                builder: (logic) {
                  return CustomTextField(
                    controller: logic.reasonController,
                    filled: true,
                    fillColor: AppColors.specialistBox,
                    maxLines: 5,
                    hintText: EnumLocale.txtEnterCancellationReason.name.tr,
                    hintTextSize: 12,
                    hintTextColor: AppColors.hintText,
                  );
                },
              ).paddingOnly(bottom: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '${EnumLocale.desIfConfirmAccept.name.tr}  ',
                  style: FontStyle.fontStyleW400(
                    fontSize: 12,
                    fontColor: AppColors.dialogDes,
                  ),
                  children: [
                    TextSpan(
                      text: EnumLocale.txtTermsCondition.name.tr,
                      style: FontStyle.fontStyleW500(
                        fontSize: 12,
                        fontColor: AppColors.title,
                        textDecoration: TextDecoration.underline,
                        decorationColor: AppColors.title,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GetBuilder<AppointmentScreenController>(
                id: Constant.idProgressView,
                builder: (logic) {
                  return PrimaryAppButton(
                    onTap: () async {
                      if (logic.reasonController.text.isEmpty) {
                        Utils.showToast(Get.context!, "Please enter cancellation reason");
                      } else {
                        Utils.currentFocus(context);

                        await logic.onCancelAppointmentApiCall(
                          appointmentId: appointmentId,
                          reason: logic.reasonController.text,
                        );

                        if (logic.cancelAppointmentModel?.status == true) {
                          logic.reasonController.clear();

                          Utils.showToast(Get.context!, logic.cancelAppointmentModel?.message ?? "");
                          Get.back();

                          if (isHomeScreen) {
                            if (isViewAll) {
                              Get.back();
                              homeScreenController.onRefresh();
                            }
                            Get.back();
                            homeScreenController.onRefresh();
                          } else {
                            logic.startPending = 0;
                            logic.getPending = [];

                            await logic.onGetAppointmentApiCall(
                              userId: Constant.storage.read("userId"),
                              status: "1",
                              start: logic.startPending.toString(),
                              limit: logic.limitPending.toString(),
                              startDate: 'ALL',
                              endDate: 'ALL',
                            );
                          }
                        } else {
                          Utils.showToast(Get.context!, logic.cancelAppointmentModel?.message ?? "");
                        }
                      }
                    },
                    height: Get.height * 0.06,
                    width: Get.width * 0.93,
                    color: AppColors.notificationTitle2,
                    borderRadius: 54,
                    text: EnumLocale.txtCancelAppointment.name.tr,
                    textStyle: FontStyle.fontStyleW600(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(top: 20, bottom: 15, left: 15, right: 15);
                },
              ),
              PrimaryAppButton(
                onTap: () {
                  Get.back();
                },
                height: Get.height * 0.06,
                width: Get.width * 0.93,
                color: AppColors.specialistBox,
                borderRadius: 54,
                text: EnumLocale.txtClose.name.tr,
                textStyle: FontStyle.fontStyleW600(
                  fontSize: 15,
                  fontColor: AppColors.specialist,
                ),
              ).paddingOnly(bottom: 10, left: 15, right: 15)
            ],
          ).paddingAll(15),
        ),
      ),
    );
  }
}
