import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/dialog/cancel_appointment_dialog.dart';
import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpcomingAppointmentBottomSheet extends StatelessWidget {
  final String image;
  final String doctorName;
  final String designation;
  final String degree;
  final int appointmentType;
  final String formattedDate;
  final String time;
  final String appointmentId;
  final String doctorId;
  final bool isViewAll;

  const UpcomingAppointmentBottomSheet({
    super.key,
    required this.image,
    required this.doctorName,
    required this.designation,
    required this.degree,
    required this.appointmentType,
    required this.formattedDate,
    required this.time,
    required this.appointmentId,
    required this.doctorId,
    required this.isViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.46,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Appointment",
                style: FontStyle.fontStyleW600(
                  fontSize: 18,
                  fontColor: AppColors.title,
                ),
              ).paddingOnly(left: 8),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SizedBox(
                  width: 45,
                  child: Image.asset(
                    AppAsset.icClose,
                    height: Get.height * 0.07,
                  ).paddingOnly(right: 15),
                ),
              )
            ],
          ),
          Divider(height: 1.2, color: AppColors.bottomSheetDivider),
          Container(
            height: Get.height * 0.35,
            width: Get.width,
            margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.divider,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: Get.height * 0.125,
                      width: Get.width * 0.27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.placeholder,
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
                    ).paddingOnly(right: 12),
                    Container(
                      height: Get.height * 0.125,
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doctorName,
                            style: FontStyle.fontStyleW700(
                              fontSize: 15,
                              fontColor: AppColors.title,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.specialistBox,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              child: Text(
                                designation,
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.specialist,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            degree,
                            style: FontStyle.fontStyleW500(
                              fontSize: 14,
                              fontColor: AppColors.degreeText,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(top: 12, left: 12),
                const Spacer(),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.placeholder,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: appointmentType == 1 ? AppColors.call1 : AppColors.message1,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(9),
                            child: Image.asset(appointmentType == 1 ? AppAsset.icSend : AppAsset.icHome),
                          ).paddingOnly(right: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appointmentType == 1 ? EnumLocale.txtOnline.name.tr : EnumLocale.txtAtClinic.name.tr,
                                style: FontStyle.fontStyleW700(
                                  fontSize: 14,
                                  fontColor: appointmentType == 1 ? AppColors.call1 : AppColors.message1,
                                ),
                              ),
                              Text(
                                EnumLocale.txtAppointmentType.name.tr,
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 36,
                            width: 2,
                            color: AppColors.divider,
                          ),
                          const Spacer(),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: AppColors.primaryAppColor1,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(11),
                            child: Image.asset(AppAsset.icAppointmentFilled, color: AppColors.white),
                          ).paddingOnly(right: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$formattedDate $time",
                                style: FontStyle.fontStyleW700(
                                  fontSize: 13,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                              Text(
                                "Appointment Time",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingOnly(top: 5),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: GetBuilder<AppointmentScreenController>(
                              id: Constant.idProgressView,
                              builder: (logic) {
                                return PrimaryAppButton(
                                  onTap: () {
                                    Get.dialog(
                                      barrierColor: AppColors.black.withOpacity(0.8),
                                      ProgressDialog(
                                        inAsyncCall: logic.isLoading1,
                                        child: Dialog(
                                          backgroundColor: AppColors.transparent,
                                          shadowColor: Colors.transparent,
                                          surfaceTintColor: Colors.transparent,
                                          elevation: 0,
                                          child: CancelAppointmentDialog(
                                            appointmentId: appointmentId,
                                            isHomeScreen: true,
                                            isViewAll: isViewAll,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  height: Get.height * 0.059,
                                  borderRadius: 9,
                                  color: AppColors.notificationTitle2,
                                  text: EnumLocale.txtCancelAppointment.name.tr,
                                  textStyle: FontStyle.fontStyleW600(
                                    fontSize: 13,
                                    fontColor: AppColors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PrimaryAppButton(
                              onTap: () {
                                log("image :: $image");
                                log("doctorName :: $doctorName");
                                log("designation :: $designation");
                                log("degree :: $degree");
                                log("appointmentType :: $appointmentType");
                                log("formattedDate :: $formattedDate");
                                log("time :: $time");
                                log("appointmentId :: $appointmentId");
                                log("doctorId :: $doctorId");

                                id = doctorId;

                                Get.toNamed(
                                  AppRoutes.personalChat,
                                  arguments: [
                                    doctorId,
                                    "",
                                    doctorName,
                                    image,
                                    designation,
                                  ],
                                )?.then((value) {
                                  id = '';
                                  log("Id for notification :: $id");
                                });
                              },
                              height: Get.height * 0.059,
                              borderRadius: 9,
                              gradientColor: appointmentType == 1
                                  ? [AppColors.call1, AppColors.call2]
                                  : [AppColors.message1, AppColors.message2],
                              text: "Start Meeting",
                              textStyle: FontStyle.fontStyleW600(
                                fontSize: 13,
                                fontColor: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
