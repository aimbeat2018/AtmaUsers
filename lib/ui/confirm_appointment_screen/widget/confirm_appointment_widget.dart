import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/confirm_appointment_screen/controller/confirm_appointment_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Payment Top view =================== ///
class ConfirmAppointmentPaymentView extends StatelessWidget {
  const ConfirmAppointmentPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: AppColors.confirmBg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAsset.icConfirm,
            height: 220,
            width: 240,
          ).paddingOnly(top: Get.height * 0.075, bottom: 15),
          Text(
            EnumLocale.txtAppointmentConfirm.name.tr,
            style: FontStyle.fontStyleW700(
              fontSize: 24,
              fontColor: AppColors.green,
            ),
          ).paddingOnly(top: 10, bottom: 10),
          Text(
            EnumLocale.txtPaymentSuccessful.name.tr,
            style: FontStyle.fontStyleW500(
              fontSize: 16,
              fontColor: AppColors.green,
            ),
          ).paddingOnly(bottom: 30)
        ],
      ),
    );
  }
}

/// =================== Appointment Information =================== ///
class ConfirmAppointmentInfoView extends StatelessWidget {
  const ConfirmAppointmentInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.5),
              offset: const Offset(
                6.0,
                6.0,
              ),
              blurRadius: 6.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: GetBuilder<ConfirmAppointmentController>(
          builder: (logic) {
            return Column(
              children: [
                Container(
                  height: Get.height * 0.15,
                  width: Get.width,
                  decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.05),
                      offset: const Offset(
                        3.0,
                        3.0,
                      ),
                      blurRadius: 8.0,
                    ),
                  ]),
                  child: Row(
                    children: [
                      Container(
                        height: Get.height * 0.127,
                        width: Get.width * 0.27,
                        decoration: BoxDecoration(
                          color: AppColors.placeholder,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: logic.doctorImage ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                          },
                        ),
                      ).paddingOnly(left: 15, right: 15),
                      Container(
                        height: Get.height * 0.125,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              logic.doctorName ?? "",
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
                                  logic.doctorDesignation ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 12,
                                    fontColor: AppColors.specialist,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              logic.doctorDegree ?? "",
                              style: FontStyle.fontStyleW500(
                                fontSize: 14,
                                fontColor: AppColors.degreeText,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppAsset.icAppointmentFilled,
                            height: 28,
                            width: 28,
                          ).paddingOnly(right: 15),
                          Text(
                            EnumLocale.txtAppointmentSchedule.name.tr,
                            style: FontStyle.fontStyleW700(
                              fontSize: 15,
                              fontColor: AppColors.title,
                            ),
                          )
                        ],
                      ).paddingOnly(top: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                EnumLocale.txtDate.name.tr,
                                style: FontStyle.fontStyleW500(
                                  fontSize: 14,
                                  fontColor: AppColors.degreeText,
                                ),
                              ).paddingOnly(bottom: 8),
                              Text(
                                logic.date ?? "",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 15,
                                  fontColor: AppColors.sortByBorder,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                EnumLocale.txtTime.name.tr,
                                style: FontStyle.fontStyleW500(
                                  fontSize: 14,
                                  fontColor: AppColors.degreeText,
                                ),
                              ).paddingOnly(bottom: 8),
                              Text(
                                logic.time ?? "",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 15,
                                  fontColor: AppColors.sortByBorder,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                EnumLocale.txtType.name.tr,
                                style: FontStyle.fontStyleW500(
                                  fontColor: AppColors.degreeText,
                                  fontSize: 14,
                                ),
                              ).paddingOnly(bottom: 8),
                              Text(
                                logic.appointmentType ?? "",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 15,
                                  fontColor: AppColors.sortByBorder,
                                ),
                              )
                            ],
                          ),
                        ],
                      ).paddingOnly(right: 35, top: 20),
                      Row(
                        children: [
                          Image.asset(
                            AppAsset.icLocationFilled,
                            height: 28,
                            width: 28,
                          ).paddingOnly(right: 15),
                          Text(
                            EnumLocale.txtServiceLocation.name.tr,
                            style: FontStyle.fontStyleW700(
                              fontSize: 15,
                              fontColor: AppColors.title,
                            ),
                          )
                        ],
                      ).paddingOnly(top: 18),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Get.height * 0.017,
                            width: Get.width * 0.017,
                            margin: const EdgeInsets.only(right: 10, top: 4),
                            decoration: BoxDecoration(
                              color: AppColors.sortByBorder,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.8,
                            child: Text(
                              "${logic.clinicName}\n${logic.address}",
                              style: FontStyle.fontStyleW500(
                                fontSize: 14,
                                fontColor: AppColors.sortByBorder,
                              ),
                            ),
                          ),
                        ],
                      ).paddingOnly(top: 15, right: 15)
                    ],
                  ),
                ).paddingSymmetric(horizontal: 15),
                const Spacer(),
                PrimaryAppButton(
                  onTap: () {
                    Get.offAllNamed(AppRoutes.bottom);
                  },
                  height: Get.height * 0.063,
                  width: Get.width * 0.90,
                  gradientColor: [
                    AppColors.primaryAppColor1,
                    AppColors.primaryAppColor2,
                  ],
                  borderRadius: 10,
                  text: EnumLocale.txtBackHomePage.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 16,
                    fontColor: AppColors.white,
                  ),
                ).paddingOnly(bottom: 25)
              ],
            );
          },
        ),
      ),
    );
  }
}
