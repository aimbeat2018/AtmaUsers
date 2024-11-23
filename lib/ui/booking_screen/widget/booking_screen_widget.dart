import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/booking_screen/controller/booking_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_family.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:doctor/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:doctor/custom/date_time_picker/src/properties/date_formatter.dart';
import 'package:doctor/custom/date_time_picker/src/properties/day_style.dart';
import 'package:doctor/custom/date_time_picker/src/properties/easy_day_props.dart';
import 'package:doctor/custom/date_time_picker/src/properties/easy_header_props.dart';
import 'package:doctor/custom/date_time_picker/src/widgets/easy_date_timeline_widget/easy_date_timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// =================== App Bar =================== ///
class BookingAppBarView extends StatelessWidget {
  const BookingAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtBooking.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Bottom View =================== ///
class BookingBottomView extends StatelessWidget {
  const BookingBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<BookingScreenController>(
            id: Constant.idProgressView,
            builder: (logic) {
              return GestureDetector(
                onTap: () async {
                  await logic.onGetTaxApiCall(
                    amount: logic.charge.toString(),
                  );

                  if (logic.getTaxModel?.status == true) {
                    logic.tax = logic.getTaxModel?.data?.tax;
                    logic.taxPercent = logic.getTaxModel?.data?.taxPercent;
                    logic.finalAmount = logic.getTaxModel?.data?.finalAmount;

                    log("Tax :: ${logic.tax}");
                    log("Tax Percent :: ${logic.taxPercent}");
                    log("Booking Final Amount :: ${logic.finalAmount}");

                    if (logic.problemController.text.isEmpty == true) {
                      Utils.showToast(Get.context!, EnumLocale.desEnterProblem.name.tr);
                    }

                    if (logic.formKey1.currentState!.validate() && logic.selectedSlotsList.isNotEmpty) {
                      Get.toNamed(
                        AppRoutes.confirmBooking,
                        arguments: [
                          logic.doctorId,
                          logic.doctorName,
                          logic.doctorImage,
                          logic.doctorDesignation,
                          logic.doctorDegree,
                          logic.selectedSlotsList.join(),
                          logic.selectedDate,
                          logic.selectAppointmentType! + 1,
                          logic.appointmentType,
                          logic.patientName == "My Self" ? "self" : logic.patientName,
                          logic.problemController.text,
                          logic.imageFileList,
                          logic.tax,
                          logic.taxPercent,
                          logic.charge,
                          logic.finalAmount,
                          logic.serviceId,
                          logic.patientId,
                          0,
                          logic.clinicName,
                          logic.address,
                        ],
                      );
                    } else {
                      if (logic.selectedSlotsList.isEmpty) {
                        Utils.showToast(Get.context!, EnumLocale.toastSelectTime.name.tr);
                      }
                    }
                  } else {
                    Utils.showToast(Get.context!, logic.getTaxModel?.message ?? "");
                  }
                },
                child: PrimaryAppButton(
                  height: Get.height * 0.06,
                  width: Get.width * 0.90,
                  borderRadius: 11,
                  gradientColor: [AppColors.call1, AppColors.call2],
                  text: EnumLocale.txtConfirmBooking.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// =================== Information =================== ///
class BookingInfoView extends StatelessWidget {
  const BookingInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingScreenController>(
      builder: (logic) {
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
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.125,
                width: Get.width * 0.27,
                margin: const EdgeInsets.all(13),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
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
                      logic.doctorName.toString(),
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
                          logic.doctorDesignation.toString(),
                          style: FontStyle.fontStyleW500(
                            fontSize: 12,
                            fontColor: AppColors.specialist,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      logic.doctorDegree.toString(),
                      style: FontStyle.fontStyleW500(
                        fontSize: 14,
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
    );
  }
}

/// =================== Select Date =================== ///
class BookingDateView extends StatelessWidget {
  const BookingDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtSelectDate.name.tr,
          style: FontStyle.fontStyleW600(
            fontSize: 16.5,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(left: 12),
        GetBuilder<BookingScreenController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return EasyDateTimeLine(
              initialDate: DateTime.now(),
              disabledDates: logic.getDisabledDates(),
              onDateChange: (selectedDate) async {
                logic.formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                logic.selectedDate = selectedDate;

                log("Selected Date :: ${logic.selectedDate}");

                await logic.onGetBookingApiCall(
                  date: logic.formattedDate ?? "",
                  doctorId: logic.doctorId ?? "",
                );

                logic.onGetSlotsList();

                ///TODO
                // logic.onSelectSlot();
              },
              headerProps: EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                showMonthPicker: true,
                dateFormatter: const DateFormatter.fullDateDayAsStrMY(),
                monthStyle: TextStyle(
                  color: AppColors.title,
                  fontFamily: FontFamily.sfProDisplayBold,
                  fontSize: 16,
                ),
                selectedDateStyle: TextStyle(
                  color: AppColors.degreeText,
                  fontSize: 16,
                  fontFamily: FontFamily.sfProDisplay,
                ),
              ),
              dayProps: EasyDayProps(
                height: 75,
                borderColor: Colors.transparent,
                todayHighlightColor: Colors.transparent,
                dayStructure: DayStructure.dayStrDayNum,
                disabledDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    color: AppColors.disableSlotText,
                    fontSize: 16,
                    fontFamily: FontFamily.sfProDisplayRegular,
                  ),
                  dayStrStyle: TextStyle(
                    color: AppColors.disableSlotText,
                    fontSize: 16,
                    fontFamily: FontFamily.sfProDisplayRegular,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.disableSlot,
                  ),
                ),
                todayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    color: AppColors.degreeText,
                    fontSize: 16,
                    fontFamily: FontFamily.sfProDisplay,
                  ),
                  dayStrStyle: TextStyle(
                    color: AppColors.degreeText,
                    fontSize: 16,
                    fontFamily: FontFamily.sfProDisplay,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.specialistBox,
                  ),
                ),
                activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontFamily: FontFamily.sfProDisplay,
                  ),
                  dayStrStyle: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontFamily: FontFamily.sfProDisplay,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryAppColor1,
                        AppColors.primaryAppColor2,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                inactiveDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    color: AppColors.degreeText,
                    fontSize: 16,
                    fontFamily: FontFamily.sfProDisplayMedium,
                  ),
                  dayStrStyle: TextStyle(
                    color: AppColors.degreeText,
                    fontSize: 16,
                    fontFamily: FontFamily.sfProDisplayMedium,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.specialistBox,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ).paddingOnly(left: 5, right: 12, bottom: 12);
          },
        ),
      ],
    );
  }
}

/// =================== Select Time =================== ///
class BookingSlotView extends StatelessWidget {
  const BookingSlotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtSelectTime.name.tr,
          style: FontStyle.fontStyleW600(
            fontSize: 16.5,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(left: 12, top: 5, bottom: 10),
        GetBuilder<BookingScreenController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColors.specialistBox,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.08),
                    offset: const Offset(
                      0.5,
                      0.8,
                    ),
                    blurRadius: 3.0,
                    spreadRadius: 0.2,
                  ),
                ],
              ),
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: !(logic.hasMorningSlots) ? false : true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        logic.startTimeShop ?? "--",
                        style: FontStyle.fontStyleW600(
                          fontSize: 17,
                          fontColor: AppColors.title,
                        ),
                      ),
                      Text(
                        "TO",
                        style: FontStyle.fontStyleW600(
                          fontSize: 17,
                          fontColor: AppColors.degreeText,
                        ),
                      ),
                      Text(
                        logic.startTimeBreak ?? "--",
                        style: FontStyle.fontStyleW600(
                          fontSize: 17,
                          fontColor: AppColors.title,
                        ),
                      ),
                    ],
                  ).paddingOnly(right: 12),
                  trailing: Image.asset(
                    AppAsset.icArrowDown,
                    height: 25,
                    width: 25,
                    color: AppColors.degreeText,
                  ),
                  children: [
                    Container(
                      width: Get.width,
                      color: AppColors.white,
                      child: logic.isLoading
                          ? Shimmers.selectSlotShimmer()
                          : buildSlotCategory(
                              logic.morningSlots,
                              logic.formattedDate.toString(),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        GetBuilder<BookingScreenController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return logic.getBookingModel?.allSlot?.evening?.isEmpty == true
                ? const SizedBox()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: AppColors.specialistBox,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.08),
                          offset: const Offset(
                            0.5,
                            0.8,
                          ),
                          blurRadius: 3.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: !(logic.hasMorningSlots) ? true : false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              logic.endTimeBreak ?? "--",
                              style: FontStyle.fontStyleW600(
                                fontSize: 17,
                                fontColor: AppColors.title,
                              ),
                            ),
                            Text(
                              "TO",
                              style: FontStyle.fontStyleW600(
                                fontSize: 17,
                                fontColor: AppColors.degreeText,
                              ),
                            ),
                            Text(
                              logic.closeTimeShop ?? "--",
                              style: FontStyle.fontStyleW600(
                                fontSize: 17,
                                fontColor: AppColors.title,
                              ),
                            ),
                          ],
                        ).paddingOnly(right: 12),
                        trailing: Image.asset(
                          AppAsset.icArrowDown,
                          height: 25,
                          width: 25,
                          color: AppColors.degreeText,
                        ),
                        children: [
                          Container(
                            width: Get.width,
                            color: AppColors.white,
                            child: logic.isLoading
                                ? Shimmers.selectSlotShimmer()
                                : buildSlotCategory(
                                    logic.afternoonSlots,
                                    logic.formattedDate.toString(),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}

Widget buildSlotCategory(List<String> slots, String selectedDate) {
  BookingScreenController bookingScreenController = Get.find<BookingScreenController>();

  bookingScreenController.hasMorningSlots = slots.any((slot) {
    DateTime currentTime = DateTime.now();
    DateTime currentDate = DateTime.now();
    DateTime slotDateTime = DateFormat('yyyy-MM-dd').parse(selectedDate);

    DateTime currentTimeWithDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      currentTime.hour,
      currentTime.minute,
    );

    DateTime slotTime = DateFormat('hh:mm a').parse(slot);
    DateTime slotTimeWithDate = DateTime(
      slotDateTime.year,
      slotDateTime.month,
      slotDateTime.day,
      slotTime.hour,
      slotTime.minute,
    );

    return !currentDate.isAfter(slotDateTime) || !currentTimeWithDate.isAfter(slotTimeWithDate);
  });

  return SafeArea(
    child: GetBuilder<BookingScreenController>(
      id: Constant.idUpdateSlots,
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimationLimiter(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 0.10,
                ),
                itemCount: slots.length,
                itemBuilder: (context, index) {
                  DateTime currentTime = DateTime.now();
                  DateTime currentDate = DateTime.now();
                  DateTime slotDateTime = DateFormat('yyyy-MM-dd').parse(selectedDate);

                  DateTime currentTimeWithDate =
                      DateTime(currentDate.year, currentDate.month, currentDate.day, currentTime.hour, currentTime.minute);

                  DateTime slotTime = DateFormat('hh:mm a').parse(slots[index]);
                  DateTime slotTimeWithDate =
                      DateTime(slotDateTime.year, slotDateTime.month, slotDateTime.day, slotTime.hour, slotTime.minute);

                  List<String>? timeSlots = logic.getBookingModel?.busySlots;

                  bool isSlotBooked = timeSlots != null && timeSlots.contains(slots[index]);
                  bool isSelected = logic.selectedSlotsList.contains(slots[index]);

                  bool isSlotTimePassed = currentDate.isAfter(slotDateTime) && currentTimeWithDate.isAfter(slotTimeWithDate);

                  logic.isFirstTap = true;

                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 400),
                    columnCount: slots.length,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            if (isSlotBooked) {
                              if (logic.isFirstTap) {
                                logic.isFirstTap = false;
                                Utils.showToast(Get.context!, EnumLocale.toastAlreadyBooked.name.tr);
                                Future.delayed(
                                  const Duration(seconds: 5),
                                  () {
                                    logic.isFirstTap = true;
                                  },
                                );
                              }
                            } else if (isSlotTimePassed) {
                              if (logic.isFirstTap) {
                                logic.isFirstTap = false;
                                Utils.showToast(Get.context!, EnumLocale.toastPreviousTime.name.tr);
                                Future.delayed(
                                  const Duration(seconds: 5),
                                  () {
                                    logic.isFirstTap = true;
                                  },
                                );
                              }
                            } else {
                              if (logic.isFirstTap) {
                                logic.isFirstTap = false;

                                logic.selectSlot(slots[index]);
                                log("Select Slot Time :: ${logic.selectedSlotsList}");

                                /// if already booked slot within selected slot
                                List selectSlot = logic.selectedSlotsList;
                                List<String>? alreadyBookedSlot = logic.getBookingModel?.busySlots;

                                List commonElements = selectSlot.toSet().intersection(alreadyBookedSlot!.toSet()).toList();

                                log("Booked Slot is :: ${logic.getBookingModel?.busySlots}");
                                log("Select Slot is :::: ${logic.selectedSlotsList}");
                                log("Common element :: $commonElements");

                                if (commonElements.isNotEmpty) {
                                  Utils.showToast(Get.context!, EnumLocale.toastInvalidTime.name.tr);
                                }

                                /// if already booked slot within break time
                                List slotSelected = logic.selectedSlotsList;
                                String breakTimes = logic.breakStartTimes.trim();

                                if (slotSelected.contains(breakTimes)) {
                                  Utils.showToast(Get.context!, EnumLocale.toastInvalidTime.name.tr);
                                }

                                ///TODO
                                /// if already booked slot within shop close time
                                // log("The Shop Close time :: ${logic.getBookingModel?.appointmentDay?.endTime}");
                                //
                                // if (slotSelected.contains(logic.getBookingModel?.appointmentDay?.endTime)) {
                                //   Utils.showToast(Get.context!, EnumLocale.toastInvalidTime.name.tr);
                                // }

                                Future.delayed(
                                  const Duration(seconds: 5),
                                  () {
                                    logic.isFirstTap = true;
                                  },
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 3, right: 3),
                            child: Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? isSlotBooked
                                        ? AppColors.specialistBox
                                        : AppColors.primaryAppColor1
                                    : isSlotTimePassed || isSlotBooked
                                        ? AppColors.disableSlot
                                        : AppColors.specialistBox,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  slots[index],
                                  style: TextStyle(
                                    fontFamily: isSlotBooked || isSlotTimePassed
                                        ? FontFamily.sfProDisplayRegular
                                        : FontFamily.sfProDisplay,
                                    decoration:
                                        isSlotBooked || isSlotTimePassed ? TextDecoration.lineThrough : TextDecoration.none,
                                    decorationColor: AppColors.disableSlotText,
                                    fontSize: 14.5,
                                    color: isSelected
                                        ? isSlotBooked
                                            ? AppColors.degreeText
                                            : AppColors.white
                                        : isSlotTimePassed || isSlotBooked
                                            ? AppColors.disableSlotText
                                            : AppColors.degreeText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}

/// =================== Appointment Type =================== ///
class BookingAppointmentView extends StatelessWidget {
  const BookingAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtAppointmentType.name.tr,
          style: FontStyle.fontStyleW600(
            fontSize: 16.5,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(left: 12, bottom: 12, top: 5),
        GetBuilder<BookingScreenController>(
          id: Constant.idSelectAppointmentType,
          builder: (logic) {
            return Row(
              children: [
                if (logic.type == 1)
                  GestureDetector(
                    onTap: () {
                      logic.onSelectAppointmentType(0);
                    },
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: logic.selectAppointmentType == 0
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
                                  AppColors.transparent,
                                  AppColors.transparent,
                                ],
                              ),
                        border: Border.all(
                          color: logic.selectAppointmentType == 0 ? AppColors.transparent : AppColors.border,
                          width: logic.selectAppointmentType == 0 ? 0 : 1.2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          EnumLocale.txtOnline.name.tr,
                          style: FontStyle.fontStyleW500(
                            fontSize: 14.5,
                            fontColor: logic.selectAppointmentType == 0 ? AppColors.white : AppColors.tabUnselectText,
                          ),
                        ),
                      ),
                    ).paddingOnly(right: 10),
                  )
                else ...[
                  if (logic.type == 2)
                    GestureDetector(
                      onTap: () {
                        logic.onSelectAppointmentType(1);
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: logic.selectAppointmentType == 1
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
                                    AppColors.transparent,
                                    AppColors.transparent,
                                  ],
                                ),
                          border: Border.all(
                            color: logic.selectAppointmentType == 1 ? AppColors.transparent : AppColors.border,
                            width: logic.selectAppointmentType == 1 ? 0 : 1.2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            EnumLocale.txtAtClinic.name.tr,
                            style: FontStyle.fontStyleW500(
                              fontSize: 14,
                              fontColor: logic.selectAppointmentType == 1 ? AppColors.white : AppColors.tabUnselectText,
                            ),
                          ),
                        ),
                      ),
                    )
                  else ...[
                    GestureDetector(
                      onTap: () {
                        logic.onSelectAppointmentType(0);
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: logic.selectAppointmentType == 0
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
                                    AppColors.transparent,
                                    AppColors.transparent,
                                  ],
                                ),
                          border: Border.all(
                            color: logic.selectAppointmentType == 0 ? AppColors.transparent : AppColors.border,
                            width: logic.selectAppointmentType == 0 ? 0 : 1.2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            EnumLocale.txtOnline.name.tr,
                            style: FontStyle.fontStyleW500(
                              fontSize: 14.5,
                              fontColor: logic.selectAppointmentType == 0 ? AppColors.white : AppColors.tabUnselectText,
                            ),
                          ),
                        ),
                      ).paddingOnly(right: 10),
                    ),
                    GestureDetector(
                      onTap: () {
                        logic.onSelectAppointmentType(1);
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: logic.selectAppointmentType == 1
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
                                    AppColors.transparent,
                                    AppColors.transparent,
                                  ],
                                ),
                          border: Border.all(
                            color: logic.selectAppointmentType == 1 ? AppColors.transparent : AppColors.border,
                            width: logic.selectAppointmentType == 1 ? 0 : 1.2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            EnumLocale.txtAtClinic.name.tr,
                            style: FontStyle.fontStyleW500(
                              fontSize: 14,
                              fontColor: logic.selectAppointmentType == 1 ? AppColors.white : AppColors.tabUnselectText,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                ]
              ],
            ).paddingOnly(left: 13, bottom: 13);
          },
        ),
      ],
    );
  }
}

/// =================== Patient Details =================== ///
class BookingPatientView extends StatelessWidget {
  const BookingPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtPatient.name.tr,
          style: FontStyle.fontStyleW600(
            fontSize: 16.5,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(left: 12, bottom: 5),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.categoryCircle,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                offset: const Offset(
                  0.5,
                  0.8,
                ),
                blurRadius: 3.0,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
            child: GetBuilder<BookingScreenController>(
              id: Constant.idSelectPatient,
              builder: (logic) {
                return ExpansionTile(
                  initiallyExpanded: false,
                  controller: logic.expansionTileController,
                  title: Text(
                    logic.patientName,
                    style: FontStyle.fontStyleW500(
                      fontSize: 15,
                      fontColor: AppColors.degreeText,
                    ),
                  ),
                  trailing: Image.asset(
                    AppAsset.icArrowDown,
                    height: 25,
                    width: 25,
                    color: AppColors.degreeText,
                  ),
                  children: [
                    for (int i = 0; i < (logic.getPatientModel?.data?.length ?? 0); i++)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              logic.onSelectPatient(logic.patientList![i]);
                              logic.onClosePatientSheet();
                            },
                            child: Container(
                              height: Get.height * 0.06,
                              width: Get.width,
                              color: AppColors.white,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  logic.getPatientModel?.data?[i].name ?? "My Self",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 15,
                                    fontColor: AppColors.sortByBorder,
                                  ),
                                ).paddingOnly(left: 15),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: AppColors.dividerBorder,
                          )
                        ],
                      ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.addPatient);
                      },
                      child: Container(
                        height: Get.height * 0.06,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAsset.icPlus,
                              height: 25,
                              width: 25,
                            ).paddingOnly(left: 12, right: 15),
                            Text(
                              EnumLocale.txtAddMorePatient.name.tr,
                              style: FontStyle.fontStyleW500(
                                fontSize: 15,
                                fontColor: AppColors.sortByBorder,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ).paddingOnly(left: 12, right: 12, bottom: 15),
      ],
    );
  }
}

/// =================== Explain Problem =================== ///
class BookingProblemView extends StatelessWidget {
  const BookingProblemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingScreenController>(
      builder: (logic) {
        return Form(
          key: logic.formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                EnumLocale.txtExplainProblem.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 16.5,
                  fontColor: AppColors.title,
                ),
              ).paddingOnly(left: 12, bottom: 12),
              CustomTextField(
                filled: true,
                fillColor: AppColors.categoryCircle,
                controller: logic.problemController,
                hintText: EnumLocale.txtEnterHere.name.tr,
                maxLines: 8,
                hintTextSize: 14,
                hintTextColor: AppColors.degreeText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return EnumLocale.desEnterProblem.name.tr;
                  }
                  return null;
                },
              ).paddingOnly(left: 12, right: 12, bottom: 10)
            ],
          ),
        );
      },
    );
  }
}

/// =================== Upload Images =================== ///
class BookingUploadPhotoView extends StatelessWidget {
  const BookingUploadPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<BookingScreenController>(
          id: Constant.idPickImage,
          builder: (logic) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (logic.imageFileList!.length >= 5) {
                      Utils.showToast(Get.context!, "You have reach limit !!");
                      log("You have reach limit..!!");
                      return;
                    }

                    logic.onMultiplePickImage();
                  },
                  child: DottedBorder(
                    color: AppColors.border,
                    dashPattern: const [3.5, 3.5],
                    radius: const Radius.circular(16),
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    child: Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.3,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAsset.icUpload,
                            height: 40,
                            width: 40,
                          ),
                          Text(
                            EnumLocale.txtUploadReport.name.tr,
                            textAlign: TextAlign.center,
                            style: FontStyle.fontStyleW500(
                              fontSize: 11,
                              fontColor: AppColors.border,
                            ),
                          )
                        ],
                      ),
                    ),
                  ).paddingOnly(left: 12),
                ),
                logic.imageFileList?.isEmpty == true
                    ? const SizedBox()
                    : SizedBox(
                        width: 230,
                        height: Get.height * 0.15,
                        child: ListView.builder(
                          itemCount: logic.imageFileList!.length >= 5 ? 5 : logic.imageFileList!.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  height: Get.height * 0.15,
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: FileImage(File(logic.imageFileList![index].path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ).paddingOnly(left: 5),
                                Positioned(
                                  left: Get.width * 0.23,
                                  top: 5,
                                  child: GetBuilder<BookingScreenController>(
                                    id: Constant.idRemoveImage,
                                    builder: (logic) {
                                      return InkWell(
                                        onTap: () {
                                          logic.onRemoveImage(index);
                                        },
                                        child: Image.asset(
                                          AppAsset.icClose,
                                          height: 25,
                                          width: 25,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
              ],
            );
          },
        ).paddingOnly(bottom: 12),
      ],
    );
  }
}

/// =================== Type Item View=================== ///
class DoctorRegistrationClinicTypeView extends StatelessWidget {
  final int index;
  final List type;

  const DoctorRegistrationClinicTypeView({super.key, required this.index, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingScreenController>(
      id: Constant.idGender,
      builder: (logic) {
        return InkWell(
          onTap: () {
            logic.onSelectType(index);
          },
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.035,
                width: Get.height * 0.035,
                decoration: BoxDecoration(
                  color: AppColors.categoryCircle,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: logic.genderType == index ? AppColors.title : AppColors.typeSelect,
                    width: 1.2,
                  ),
                ),
                child: logic.genderType == index ? Image.asset(AppAsset.icCheck).paddingAll(7) : const SizedBox(),
              ),
              Text(
                type[index],
                style: FontStyle.fontStyleW600(
                  fontSize: 15,
                  fontColor: AppColors.title,
                ),
              ).paddingOnly(left: 8)
            ],
          ).paddingOnly(right: 30, left: 5),
        );
      },
    );
  }
}
