import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentConfirmDialog extends StatelessWidget {
  final String userId;
  final String patient;
  final String serviceId;
  final String doctorId;
  final String amount;
  final String date;
  final String time;
  final String withoutTax;
  final String duration;
  final String type;
  final String details;
  final List<File> image;
  final String doctorName;
  final String doctorImage;
  final String doctorDesignation;
  final String doctorDegree;
  final String clinicName;
  final String address;
  final String appointmentType;
  final String bookingDate;
  final String coupon;

  const PaymentConfirmDialog({
    super.key,
    required this.userId,
    required this.patient,
    required this.serviceId,
    required this.doctorId,
    required this.amount,
    required this.date,
    required this.time,
    required this.withoutTax,
    required this.duration,
    required this.type,
    required this.details,
    required this.image,
    required this.doctorName,
    required this.doctorImage,
    required this.doctorDesignation,
    required this.doctorDegree,
    required this.clinicName,
    required this.address,
    required this.appointmentType,
    required this.bookingDate,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.73,
      child: Material(
        shape: const SquircleBorder(
          radius: BorderRadius.all(
            Radius.circular(115),
          ),
        ),
        color: AppColors.white,
        child: Column(
          children: [
            Image.asset(AppAsset.icWallet),
            Text(
              EnumLocale.txtConfirmPayment.name.tr,
              style: FontStyle.fontStyleW700(
                fontSize: 22,
                fontColor: AppColors.title,
              ),
            ).paddingOnly(top: 8),
            Text(
              EnumLocale.desConfirmAppointment.name.tr,
              textAlign: TextAlign.center,
              style: FontStyle.fontStyleW400(
                fontSize: 13.5,
                fontColor: AppColors.degreeText,
              ),
            ).paddingOnly(top: 8, bottom: 13),
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
                    imageUrl: doctorImage,
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
                            doctorDesignation,
                            style: FontStyle.fontStyleW500(
                              fontSize: 12,
                              fontColor: AppColors.specialist,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        doctorDegree,
                        style: FontStyle.fontStyleW500(
                          fontSize: 14,
                          fontColor: AppColors.degreeText,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ).paddingOnly(top: 13, bottom: 25),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${EnumLocale.desConditionAccept.name.tr}  ',
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
            GetBuilder<ConfirmBookingController>(
              id: Constant.idProgressView,
              builder: (logic) {
                return PrimaryAppButton(
                  onTap: () async {
                    log("userId :: $userId");
                    log("patient :: $patient");
                    log("serviceId :: $serviceId");
                    log("doctorId :: $doctorId");
                    log("amount :: $amount");
                    log("date :: $date");
                    log("time :: $time");
                    log("withoutTax :: $withoutTax");
                    log("duration :: $duration");
                    log("type :: $type");
                    log("details :: $details");
                    log("image :: $image");
                    log("Doctor Name :: $doctorName");
                    log("Doctor Image :: $doctorImage");
                    log("Doctor Designation :: $doctorDesignation");
                    log("Doctor Degree :: $doctorDegree");
                    log("Clinic Name :: $clinicName");
                    log("Address :: $address");
                    log("AppointmentType :: $appointmentType");
                    log("Coupon :: $coupon");

                    await logic.onCreateAppointmentApiCall(
                      userId: userId,
                      patient: patient,
                      serviceId: serviceId,
                      doctorId: doctorId,
                      amount: amount,
                      date: date,
                      time: time,
                      withoutTax: withoutTax,
                      type: type,
                      details: details,
                      images: image,
                      coupon: coupon,
                    );

                    if (logic.createAppointmentModel?.status == true) {
                      Get.toNamed(
                        AppRoutes.confirmAppointment,
                        arguments: [
                          doctorName,
                          doctorImage,
                          doctorDesignation,
                          doctorDegree,
                          bookingDate,
                          time,
                          appointmentType,
                          clinicName,
                          address,
                        ],
                      );
                    } else {
                      Utils.showToast(Get.context!, logic.createAppointmentModel?.message ?? "");
                    }
                  },
                  height: Get.height * 0.06,
                  width: Get.width * 0.93,
                  gradientColor: [
                    AppColors.call1,
                    AppColors.call2,
                  ],
                  borderRadius: 54,
                  text: EnumLocale.txtPayNow.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 16,
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
              width: Get.width * 0.90,
              color: AppColors.specialistBox,
              borderRadius: 54,
              text: EnumLocale.txtClose.name.tr,
              textStyle: FontStyle.fontStyleW600(
                fontSize: 16,
                fontColor: AppColors.specialist,
              ),
            ).paddingOnly(bottom: 10, left: 15, right: 15)
          ],
        ).paddingAll(15),
      ),
    );
  }
}
