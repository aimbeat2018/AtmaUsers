import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/dialog/payment_confirm_dialog.dart';
import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/shimmers.dart';

import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// =================== App Bar =================== ///
class ConfirmBookingAppBarView extends StatelessWidget {
  const ConfirmBookingAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtConfirmBooking.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Bottom View =================== ///
class ConfirmBookingBottomView extends StatelessWidget {
  const ConfirmBookingBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.115,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 8.0,
          ), //BoxShadow
        ],
      ),
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<ConfirmBookingController>(
                id: Constant.idProgressView,
                builder: (logic) {
                  return GestureDetector(
                    onTap: () {
                      if (walletAmount! < (logic.withDiscountAmount ?? 0)) {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return const ConfirmBookingBottomSheetView(isRecharge: false);
                          },
                        );
                      } else {
                        Get.dialog(
                          barrierColor: AppColors.black.withOpacity(0.8),
                          GetBuilder<ConfirmBookingController>(
                            id: Constant.idProgressView,
                            builder: (logic) {
                              return ProgressDialog(
                                inAsyncCall: logic.isLoading1,
                                child: Dialog(
                                  backgroundColor: AppColors.transparent,
                                  shadowColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  elevation: 0,
                                  child: PaymentConfirmDialog(
                                    userId: Constant.storage.read("userId"),
                                    patient:
                                        logic.patientId?.isEmpty == true ? (logic.patientName ?? "") : (logic.patientId ?? ""),
                                    serviceId: logic.serviceId ?? "",
                                    doctorId: logic.doctorId ?? "",
                                    amount: logic.withDiscountAmount.toString(),
                                    date: DateFormat('yyyy-MM-dd').format(logic.selectedDate!),
                                    time: logic.selectedSlotsList ?? "",
                                    withoutTax: logic.consultingFees.toString(),
                                    duration: logic.duration.toString(),
                                    type: logic.selectAppointmentType.toString(),
                                    details: logic.problemController ?? "",
                                    image: logic.imageFileList ?? [],
                                    doctorName: logic.doctorName ?? "",
                                    doctorImage: logic.doctorImage ?? "",
                                    doctorDesignation: logic.doctorDesignation ?? "",
                                    doctorDegree: logic.doctorDegree ?? "",
                                    clinicName: logic.clinicName ?? "",
                                    address: logic.address ?? "",
                                    appointmentType: logic.appointmentType ?? "",
                                    bookingDate: logic.bookingDate ?? "",
                                    coupon: logic.couponId ?? "",
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: PrimaryAppButton(
                      height: Get.height * 0.06,
                      width: Get.width * 0.90,
                      borderRadius: 11,
                      gradientColor: [AppColors.call1, AppColors.call2],
                      text: EnumLocale.txtPayNow.name.tr,
                      textStyle: FontStyle.fontStyleW600(
                        fontSize: 16,
                        fontColor: AppColors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ).paddingOnly(top: 15, bottom: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "* Current Available Balance",
                overflow: TextOverflow.ellipsis,
                style: FontStyle.fontStyleW400(
                  fontSize: 11,
                  fontColor: AppColors.degreeText,
                ),
              ).paddingOnly(right: 5),
              GetBuilder<ConfirmBookingController>(
                id: Constant.idProgressView,
                builder: (logic) {
                  return Text(
                    "$currency ${walletAmount?.toStringAsFixed(2)}",
                    style: FontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.title,
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// =================== Bottom Sheet =================== ///
class ConfirmBookingBottomSheetView extends StatelessWidget {
  final bool isRecharge;

  const ConfirmBookingBottomSheetView({super.key, required this.isRecharge});

  @override
  Widget build(BuildContext context) {
    List price = [
      EnumLocale.txtAddAmount.name.tr,
      EnumLocale.txtDiscount.name.tr,
    ];

    return GetBuilder<ConfirmBookingController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Container(
          height: logic.getWalletCouponModel?.data?.isEmpty == true ? Get.height * 0.48 : Get.height * 0.75,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            color: AppColors.white,
          ),
          child: ProgressDialog(
            inAsyncCall: logic.isLoading1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        isRecharge == true ? EnumLocale.txtRechargeWallet.name.tr : EnumLocale.txtInsufficientBalance.name.tr,
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
                  Text(
                    EnumLocale.txtAddMoney.name.tr,
                    style: FontStyle.fontStyleW700(
                      fontSize: 18,
                      fontColor: AppColors.bottomTitle,
                    ),
                  ).paddingOnly(top: 10),
                  Text(
                    EnumLocale.desEnoughFundsWallet.name.tr,
                    style: FontStyle.fontStyleW400(
                      fontSize: 13,
                      fontColor: AppColors.degreeText,
                    ),
                  ).paddingOnly(top: 5),
                  GetBuilder<ConfirmBookingController>(
                    id: Constant.idSelectAmount,
                    builder: (logic) {
                      return Row(
                        children: [
                          SizedBox(
                            height: Get.height * 0.065,
                            width: Get.width * 0.05,
                            child: Center(
                              child: Text(
                                currency ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 37,
                                  fontColor: AppColors.bottomTitle,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Get.height * 0.065,
                              width: Get.width,
                              padding: const EdgeInsets.only(bottom: 27),
                              child: TextFormField(
                                controller: logic.amountController,
                                onChanged: (text) {
                                  logic.printLatestValue(text.trim().toString());
                                  return;
                                },
                                cursorColor: AppColors.bottomTitle,
                                style: FontStyle.fontStyleW500(
                                  fontSize: 37,
                                  fontColor: AppColors.bottomTitle,
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: AppColors.transparent),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: AppColors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: AppColors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(color: AppColors.transparent),
                                  ),
                                ),
                              ),
                            ).paddingOnly(right: 15),
                          )
                        ],
                      ).paddingOnly(top: 10, bottom: 5);
                    },
                  ),
                  Text(
                    EnumLocale.desRechargeForBooking.name.tr,
                    style: FontStyle.fontStyleW400(
                      fontSize: 13,
                      fontColor: AppColors.degreeText,
                    ),
                  ).paddingOnly(top: 5),
                  GetBuilder<ConfirmBookingController>(
                    id: Constant.idMoneyOffer,
                    builder: (logic) {
                      return logic.moneyOffer == -1
                          ? const SizedBox()
                          : Container(
                              height: Get.height * 0.272,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  width: 1.5,
                                  color: AppColors.boxBorder,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: Get.height * 0.065,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: AppColors.scheduleBox,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppAsset.icCoupon,
                                          height: 28,
                                          width: 28,
                                        ).paddingOnly(left: 12, right: 15),
                                        Text(
                                          EnumLocale.txtAddMoneyOffer.name.tr,
                                          style: FontStyle.fontStyleW700(
                                            fontSize: 15,
                                            fontColor: AppColors.title,
                                          ),
                                        )
                                      ],
                                    ),
                                  ).paddingOnly(bottom: 3),
                                  for (int i = 0; i < logic.discountPrice.length; i++)
                                    Container(
                                      height: Get.height * 0.063,
                                      decoration: BoxDecoration(
                                        color: i.isOdd ? AppColors.specialistBox2 : AppColors.specialistBox,
                                      ),
                                      margin: const EdgeInsets.only(bottom: 3),
                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            price[i],
                                            overflow: TextOverflow.ellipsis,
                                            style: FontStyle.fontStyleW400(
                                              fontSize: 15,
                                              fontColor: AppColors.degreeText,
                                            ),
                                          ),
                                          Text(
                                            "$currency ${logic.discountPrice[i]}",
                                            style: FontStyle.fontStyleW600(
                                              fontSize: 16,
                                              fontColor: AppColors.title,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  Container(
                                    height: Get.height * 0.065,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryAppColor1,
                                          AppColors.primaryAppColor2,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          EnumLocale.txtPayableAmount.name.tr,
                                          style: FontStyle.fontStyleW500(
                                            fontSize: 14,
                                            fontColor: AppColors.white,
                                          ),
                                        ),
                                        Text(
                                          "$currency ${logic.payablePrice ?? ""}",
                                          style: FontStyle.fontStyleW700(
                                            fontSize: 16,
                                            fontColor: AppColors.white,
                                          ),
                                        )
                                      ],
                                    ).paddingOnly(left: 15, right: 15),
                                  ),
                                ],
                              ),
                            ).paddingOnly(right: 15, top: 15);
                    },
                  ),
                  Text(
                    EnumLocale.txtSelectDirectAmount.name.tr,
                    style: FontStyle.fontStyleW600(
                      fontSize: 17,
                      fontColor: AppColors.title,
                    ),
                  ).paddingOnly(top: 10, bottom: 5),
                  SizedBox(
                    height: Get.width * 0.128,
                    child: GetBuilder<ConfirmBookingController>(
                      id: Constant.idSelectAmount,
                      builder: (logic) {
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1.8,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 0.10,
                          ),
                          itemCount: logic.directAmount.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                logic.onSelectAmount(index);
                                await logic.onGetWalletCouponApiCall(
                                  userId: Constant.storage.read("userId"),
                                  amount: logic.directAmount[index],
                                  type: "1",
                                );
                              },
                              child: Container(
                                height: Get.height * 0.58,
                                width: Get.width * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1.2,
                                    color: logic.selectAmountIndex == index ? AppColors.transparent : AppColors.border,
                                  ),
                                  gradient: logic.selectAmountIndex == index
                                      ? LinearGradient(
                                          colors: [
                                            AppColors.primaryAppColor1,
                                            AppColors.primaryAppColor2,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        )
                                      : LinearGradient(
                                          colors: [
                                            AppColors.white,
                                            AppColors.white,
                                          ],
                                        ),
                                ),
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                margin: const EdgeInsets.only(bottom: 2.5, right: 10, top: 10),
                                child: Center(
                                  child: Text(
                                    logic.directAmount[index],
                                    style: FontStyle.fontStyleW500(
                                      fontSize: 15,
                                      fontColor: logic.selectAmountIndex == index ? AppColors.white : AppColors.tabUnselectText,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  logic.getWalletCouponModel?.data?.isEmpty == true
                      ? const SizedBox()
                      : Text(
                          EnumLocale.txtAddMoneyOffer.name.tr,
                          style: FontStyle.fontStyleW600(
                            fontSize: 17,
                            fontColor: AppColors.title,
                          ),
                        ).paddingOnly(top: 12, bottom: 12),
                  GetBuilder<ConfirmBookingController>(
                    id: Constant.idProgressView,
                    builder: (logic) {
                      return logic.isLoading
                          ? Shimmers.moneyOfferShimmer()
                          : logic.getWalletCouponModel?.data?.isEmpty == true
                              ? const SizedBox()
                              : SizedBox(
                                  height: Get.height * 0.16,
                                  width: Get.width * 0.95,
                                  child: ListView.builder(
                                    itemCount: logic.getWalletCouponModel?.data?.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      DateTime offerValidity = DateFormat("dd-MM-yyyy")
                                          .parse(logic.getWalletCouponModel?.data?[index].expiryDate ?? "${DateTime.now()}");
                                      logic.expiryDate = DateFormat('dd MMM yyyy').format(offerValidity);
                                      log("ExpiryDate :: ${logic.expiryDate}");

                                      return GestureDetector(
                                        onTap: () {
                                          logic.onGetCouponPrice(index);

                                          couponId = logic.getWalletCouponModel?.data?[index].code;
                                          log("Coupon ID :: $couponId");
                                        },
                                        child: Container(
                                          height: Get.height * 0.16,
                                          width: Get.width * 0.8,
                                          margin: const EdgeInsets.only(right: 12),
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(AppAsset.imCouponBox),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    logic.getWalletCouponModel?.data?[index].title ?? "",
                                                    style: FontStyle.fontStyleW700(
                                                      fontSize: 15,
                                                      fontColor: AppColors.green,
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '${EnumLocale.txtOfferValidity.name.tr}  ',
                                                      style: FontStyle.fontStyleW600(
                                                        fontSize: 13,
                                                        fontColor: AppColors.degreeText,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: logic.expiryDate,
                                                          style: FontStyle.fontStyleW600(
                                                            fontSize: 13,
                                                            fontColor: AppColors.sortByBorder,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.5,
                                                    child: Text(
                                                      logic.getWalletCouponModel?.data?[index].description ?? "",
                                                      style: FontStyle.fontStyleW500(
                                                        fontSize: 12.5,
                                                        fontColor: AppColors.sortByBorder,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ).paddingOnly(top: 13, bottom: 13, left: 28),
                                              Container(
                                                height: Get.height * 0.06,
                                                width: Get.width * 0.06,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: logic.moneyOffer == index ? AppColors.sortByBorder : AppColors.border,
                                                    width: 1.2,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: const EdgeInsets.all(1.5),
                                                child: logic.moneyOffer == index
                                                    ? Container(
                                                        height: Get.height * 0.05,
                                                        width: Get.width * 0.05,
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                                                          ),
                                                          shape: BoxShape.circle,
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ).paddingOnly(right: Get.width * 0.07)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                    },
                  ),
                  GetBuilder<ConfirmBookingController>(
                    id: Constant.idProgressView,
                    builder: (logic) {
                      return PrimaryAppButton(
                        onTap: () {
                          logic.onRechargeNowClick();
                        },
                        height: Get.height * 0.065,
                        width: Get.width * 0.93,
                        gradientColor: [
                          AppColors.call1,
                          AppColors.call2,
                        ],
                        borderRadius: 12,
                        text: EnumLocale.txtRechargeNow.name.tr,
                        textStyle: FontStyle.fontStyleW600(
                          fontSize: 16,
                          fontColor: AppColors.white,
                        ),
                      ).paddingOnly(top: 25, bottom: 20);
                    },
                  )
                ],
              ).paddingOnly(left: 12.5),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Information =================== ///
class ConfirmBookingInfoView extends StatelessWidget {
  const ConfirmBookingInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      child: GetBuilder<ConfirmBookingController>(
        builder: (logic) {
          return Row(
            children: [
              Container(
                height: Get.height * 0.125,
                width: Get.width * 0.27,
                margin: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.placeholder,
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
              ),
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
              ).paddingOnly(top: 15, bottom: 15)
            ],
          );
        },
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== Appointment Schedule =================== ///
class ConfirmBookingAppointmentView extends StatelessWidget {
  const ConfirmBookingAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.18,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.specialistBox,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.boxBorder,
          width: 1.5,
        ),
      ),
      child: GetBuilder<ConfirmBookingController>(
        builder: (logic) {
          return Column(
            children: [
              Container(
                height: Get.height * 0.062,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.scheduleBox,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppAsset.icAppointmentFilled,
                      height: 28,
                      width: 28,
                    ).paddingOnly(left: 12, right: 15),
                    Text(
                      EnumLocale.txtAppointmentSchedule.name.tr,
                      style: FontStyle.fontStyleW700(
                        fontSize: 15,
                        fontColor: AppColors.title,
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 3, color: AppColors.white),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        EnumLocale.txtDate.name.tr,
                        style: FontStyle.fontStyleW500(
                          fontSize: 14,
                          fontColor: AppColors.degreeText,
                        ),
                      ).paddingOnly(bottom: 8),
                      Text(
                        logic.bookingDate ?? "",
                        style: FontStyle.fontStyleW600(
                          fontSize: 15,
                          fontColor: AppColors.sortByBorder,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        EnumLocale.txtTime.name.tr,
                        style: FontStyle.fontStyleW500(
                          fontSize: 14,
                          fontColor: AppColors.degreeText,
                        ),
                      ).paddingOnly(bottom: 8),
                      Text(
                        logic.selectedSlotsList ?? "",
                        style: FontStyle.fontStyleW600(
                          fontSize: 15,
                          fontColor: AppColors.sortByBorder,
                        ),
                      )
                    ],
                  ),
                  Column(
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
              ).paddingOnly(left: 18, right: 18, top: 18)
            ],
          );
        },
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 20);
  }
}

/// =================== Payment Amount =================== ///
class ConfirmBookingPaymentView extends StatelessWidget {
  const ConfirmBookingPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    List amount = [
      EnumLocale.txtConsultingFees.name.tr,
      EnumLocale.txtTaxCharges.name.tr,
      EnumLocale.txtDiscount.name.tr,
    ];

    return GetBuilder<ConfirmBookingController>(
      id: Constant.idDiscountAmount,
      builder: (logic) {
        return Container(
          height: logic.price.length == 3 ? Get.height * 0.336 : Get.height * 0.27,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1.5,
              color: AppColors.boxBorder,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.055,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.scheduleBox,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppAsset.icWallet,
                      height: 28,
                      width: 28,
                    ).paddingOnly(left: 12, right: 15),
                    Text(
                      EnumLocale.txtPaymentAmount.name.tr,
                      style: FontStyle.fontStyleW700(
                        fontSize: 15,
                        fontColor: AppColors.title,
                      ),
                    )
                  ],
                ),
              ).paddingOnly(bottom: 3),
              for (int i = 0; i < logic.price.length; i++)
                Container(
                  height: Get.height * 0.063,
                  decoration: BoxDecoration(
                    color: i.isOdd ? AppColors.specialistBox2 : AppColors.specialistBox,
                  ),
                  margin: const EdgeInsets.only(bottom: 3),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        amount[i],
                        overflow: TextOverflow.ellipsis,
                        style: FontStyle.fontStyleW400(
                          fontSize: 15,
                          fontColor: AppColors.degreeText,
                        ),
                      ),
                      Text(
                        "$currency ${logic.price[i]}",
                        style: FontStyle.fontStyleW600(
                          fontSize: 16,
                          fontColor: AppColors.title,
                        ),
                      )
                    ],
                  ),
                ),
              Container(
                height: Get.height * 0.065,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryAppColor1,
                      AppColors.primaryAppColor2,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EnumLocale.txtPayableAmount.name.tr,
                      style: FontStyle.fontStyleW500(
                        fontSize: 14,
                        fontColor: AppColors.white,
                      ),
                    ),
                    Text(
                      "$currency ${logic.withDiscountAmount}",
                      style: FontStyle.fontStyleW700(
                        fontSize: 16,
                        fontColor: AppColors.white,
                      ),
                    )
                  ],
                ).paddingOnly(left: 15, right: 15),
              ),
            ],
          ),
        ).paddingOnly(left: 15, right: 15);
      },
    );
  }
}

/// =================== Apply Coupon =================== ///
class ConfirmBookingCouponView extends StatelessWidget {
  const ConfirmBookingCouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfirmBookingController>(
      builder: (logic) {
        return InkWell(
          onTap: () {
            Get.toNamed(
              AppRoutes.applyCoupon,
              arguments: [logic.withoutDiscountAmount],
            )?.then((value) {
              logic.update([Constant.idDiscountAmount]);
            });
          },
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                AppAsset.icCoupon,
                height: 25,
                width: 25,
              ),
              Text(
                EnumLocale.txtApplyCoupon.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 12.5,
                  fontColor: AppColors.title,
                ),
              ).paddingOnly(left: 10, right: 25)
            ],
          ).paddingOnly(top: 15, bottom: 20),
        );
      },
    );
  }
}
