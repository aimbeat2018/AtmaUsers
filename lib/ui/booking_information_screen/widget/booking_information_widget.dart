import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/information/custom_info_box.dart';
import 'package:doctor/ui/booking_information_screen/controller/booking_information_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// =================== App Bar =================== ///
class BookingInfoAppBarView extends StatelessWidget {
  const BookingInfoAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtBookingInformation.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Doctor Information =================== ///
class BookingInfoDoctorDataView extends StatelessWidget {
  const BookingInfoDoctorDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtDoctorInformation.name.tr,
          style: FontStyle.fontStyleW700(
            fontSize: 17,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(top: 12, left: 15),
        GetBuilder<BookingInformationController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return logic.isLoading
                ? Shimmers.informationShimmer()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          offset: const Offset(
                            0.8,
                            0.8,
                          ),
                          blurRadius: 5.0,
                        ),
                      ],
                      color: AppColors.white,
                    ),
                    margin: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.125,
                          width: Get.width * 0.27,
                          margin: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: AppColors.placeholder,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl: logic.getAppointmentInformationModel?.data?.doctor?.image ?? "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                            },
                            errorWidget: (context, url, error) {
                              return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                            },
                          ),
                        ),
                        Container(
                          height: Get.height * 0.125,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                logic.getAppointmentInformationModel?.data?.doctor?.name ?? "",
                                style: FontStyle.fontStyleW700(
                                  fontSize: 16,
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
                                    logic.getAppointmentInformationModel?.data?.doctor?.designation ?? "",
                                    style: FontStyle.fontStyleW500(
                                      fontSize: 12,
                                      fontColor: AppColors.specialist,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                logic.getAppointmentInformationModel?.data?.doctor?.degree?.join(", ") ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 15,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ],
                          ),
                        ).paddingOnly(top: 15, bottom: 15)
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }
}

/// =================== Location =================== ///
class BookingInfoLocationView extends StatelessWidget {
  const BookingInfoLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingInformationController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              EnumLocale.txtServiceLocation.name.tr,
              style: FontStyle.fontStyleW700(
                fontSize: 17,
                fontColor: AppColors.title,
              ),
            ).paddingOnly(left: 15, top: 5),
            logic.isLoading
                ? Shimmers.informationShimmer()
                : GestureDetector(
                    onTap: () {
                      logic.launchMaps();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            offset: const Offset(
                              0.8,
                              0.8,
                            ),
                            blurRadius: 5.0,
                          ),
                        ],
                        color: AppColors.white,
                      ),
                      margin: const EdgeInsets.all(13),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Image.asset(AppAsset.imLocation).paddingOnly(bottom: 10),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(AppAsset.icLocationFilled, height: 20, width: 20),
                                  Text(
                                    logic.getAppointmentInformationModel?.data?.doctor?.clinicName ?? "",
                                    style: FontStyle.fontStyleW600(
                                      fontSize: 14.5,
                                      fontColor: AppColors.title,
                                    ),
                                  ).paddingOnly(left: 8),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  logic.getAppointmentInformationModel?.data?.doctor?.address ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 13,
                                    fontColor: AppColors.title,
                                  ),
                                ).paddingOnly(left: 27),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

/// =================== Booking Information =================== ///
class BookingInfoDataView extends StatelessWidget {
  const BookingInfoDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtBookingInformation.name.tr,
          style: FontStyle.fontStyleW700(
            fontSize: 17,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(left: 15, top: 5),
        GetBuilder<BookingInformationController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return logic.isLoading
                ? Shimmers.bookingInformationShimmer()
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          offset: const Offset(
                            0.8,
                            0.8,
                          ),
                          blurRadius: 5.0,
                        ),
                      ],
                      color: AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInfoBox(
                          title: EnumLocale.txtBookingDate.name.tr,
                          isIndex: false,
                          text: logic.getAppointmentInformationModel?.data?.date,
                        ).paddingOnly(top: 15),
                        CustomInfoBox(
                          title: EnumLocale.txtBookingTime.name.tr,
                          isIndex: false,
                          text: logic.getAppointmentInformationModel?.data?.time,
                        ),
                        GestureDetector(
                          onLongPress: () {
                            Utils.copyText(logic.getAppointmentInformationModel?.data?.appointmentId ?? "");
                            Utils.showToast(Get.context!, "Copied ${logic.getAppointmentInformationModel?.data?.appointmentId}");
                          },
                          child: CustomInfoBox(
                            title: EnumLocale.txtAppointmentID.name.tr,
                            isIndex: false,
                            text: logic.getAppointmentInformationModel?.data?.appointmentId,
                          ),
                        ),
                        CustomInfoBox(
                          title: EnumLocale.txtBookingType.name.tr,
                          isIndex: true,
                          widget: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.categoryCircle,
                            ),
                            child: Text(
                              logic.getAppointmentInformationModel?.data?.type == 1
                                  ? EnumLocale.txtOnline.name.tr
                                  : EnumLocale.txtAtClinic.name.tr,
                              style: FontStyle.fontStyleW600(
                                fontSize: 13,
                                fontColor: AppColors.tabUnselectText,
                              ),
                            ),
                          ),
                        ),
                        CustomInfoBox(
                          title: "Details",
                          isIndex: true,
                          widget: Container(
                            width: (logic.getAppointmentInformationModel?.data?.details?.length ?? 0) <= 20
                                ? Get.width * 0.25
                                : Get.width * 0.5,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              logic.getAppointmentInformationModel?.data?.details ?? "",
                              textAlign: (logic.getAppointmentInformationModel?.data?.details?.length ?? 0) <= 20
                                  ? TextAlign.center
                                  : TextAlign.left,
                              style: FontStyle.fontStyleW600(
                                fontSize: 13,
                                fontColor: AppColors.tabUnselectText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }
}

/// =================== Patient Information =================== ///
class BookingInfoPatientView extends StatelessWidget {
  const BookingInfoPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Patient Information",
          style: FontStyle.fontStyleW700(
            fontSize: 17,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(left: 15, top: 5),
        GetBuilder<BookingInformationController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return logic.isLoading
                ? Shimmers.bookingInformationShimmer()
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          offset: const Offset(
                            0.8,
                            0.8,
                          ),
                          blurRadius: 5.0,
                        ),
                      ],
                      color: AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInfoBox(
                          title: EnumLocale.txtFullName.name.tr,
                          isIndex: false,
                          text: logic.getAppointmentInformationModel?.data?.patient?.name,
                        ).paddingOnly(top: 15),
                        CustomInfoBox(
                          title: EnumLocale.txtAge.name.tr,
                          isIndex: false,
                          text: logic.getAppointmentInformationModel?.data?.patient?.age.toString(),
                        ),
                        CustomInfoBox(
                          title: EnumLocale.txtGender.name.tr,
                          isIndex: false,
                          text: logic.getAppointmentInformationModel?.data?.patient?.gender,
                        ),
                        CustomInfoBox(
                          title: EnumLocale.txtRelation.name.tr,
                          isIndex: false,
                          text: logic.getAppointmentInformationModel?.data?.patient?.relation,
                        ),
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }
}

/// =================== Payment Information =================== ///
class BookingInfoPaymentView extends StatelessWidget {
  const BookingInfoPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtPaymentInformation.name.tr,
          style: FontStyle.fontStyleW700(
            fontSize: 17,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(left: 15, top: 5),
        GetBuilder<BookingInformationController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return logic.isLoading
                ? Shimmers.bookingInformationShimmer()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          offset: const Offset(
                            0.8,
                            0.8,
                          ),
                          blurRadius: 5.0,
                        ),
                      ],
                      color: AppColors.white,
                    ),
                    margin: const EdgeInsets.all(13),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomInfoBox(
                          title: EnumLocale.txtConsultingFees.name.tr,
                          isIndex: false,
                          text: "$currency ${logic.getAppointmentInformationModel?.data?.withoutTax}",
                        ).paddingOnly(top: 15),
                        CustomInfoBox(
                          title: EnumLocale.txtTaxCharges.name.tr,
                          isIndex: false,
                          text: "$currency ${logic.getAppointmentInformationModel?.data?.tax}",
                        ),
                        CustomInfoBox(
                          title: EnumLocale.txtDiscount.name.tr,
                          isIndex: false,
                          text: "$currency ${logic.getAppointmentInformationModel?.data?.discount}",
                        ),
                        CustomInfoBox(
                          title: EnumLocale.txtPayableAmount.name.tr,
                          isIndex: false,
                          text: "$currency ${logic.getAppointmentInformationModel?.data?.amount}",
                        ),
                        CustomInfoBox(
                          title: EnumLocale.txtPaymentStatus.name.tr,
                          isIndex: true,
                          widget: logic.getAppointmentInformationModel?.data?.status == 1
                              ? Text(
                                  "Pending",
                                  style: FontStyle.fontStyleW600(
                                    fontSize: 15,
                                    fontColor: AppColors.title,
                                  ),
                                )
                              : logic.getAppointmentInformationModel?.data?.status == 4
                                  ? Text(
                                      "Cancel",
                                      style: FontStyle.fontStyleW600(
                                        fontSize: 15,
                                        fontColor: AppColors.title,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Image.asset(
                                          AppAsset.icSuccess,
                                          height: 23,
                                          width: 23,
                                        ).paddingOnly(right: 5),
                                        Text(
                                          EnumLocale.txtSuccessfully.name.tr,
                                          style: FontStyle.fontStyleW600(
                                            fontSize: 13,
                                            fontColor: AppColors.success,
                                          ),
                                        )
                                      ],
                                    ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }
}

/// =================== Cancel Information =================== ///
class BookingInfoCancelView extends StatelessWidget {
  const BookingInfoCancelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtReasonCancellation.name.tr,
          style: FontStyle.fontStyleW700(
            fontSize: 17,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(left: 15, top: 5),
        GetBuilder<BookingInformationController>(
          id: Constant.idProgressView,
          builder: (logic) {
            String timeString = logic.getAppointmentInformationModel?.data?.cancel?.time ?? "";
            DateFormat inputFormat = DateFormat("HH:mm:ss");
            DateTime time = inputFormat.parse(timeString);
            logic.formattedTime = DateFormat('HH:mm').format(time);

            return logic.isLoading
                ? Shimmers.bookingInformationShimmer()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          offset: const Offset(
                            0.8,
                            0.8,
                          ),
                          blurRadius: 5.0,
                        ),
                      ],
                      color: AppColors.white,
                    ),
                    margin: const EdgeInsets.all(13),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInfoBox(
                          title: EnumLocale.txtReason.name.tr,
                          isIndex: false,
                          text: logic.getAppointmentInformationModel?.data?.cancel?.reason,
                        ).paddingOnly(top: 15),
                        Text(
                          "* Cancelled by ${logic.getAppointmentInformationModel?.data?.cancel?.person == "1" ? "Admin" : logic.getAppointmentInformationModel?.data?.cancel?.person == "2" ? "User" : "Doctor"} at ${logic.formattedTime}",
                          style: FontStyle.fontStyleW500(
                            fontSize: 15,
                            fontColor: AppColors.degreeText,
                          ),
                        ).paddingOnly(bottom: 10),
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }
}
