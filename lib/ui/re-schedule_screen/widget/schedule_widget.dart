import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/ui/re-schedule_screen/controller/schedule_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_family.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:doctor/utils/utils.dart';
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
class ScheduleAppBarView extends StatelessWidget {
  const ScheduleAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtReSchedule.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Information =================== ///
class ScheduleInfoView extends StatelessWidget {
  const ScheduleInfoView({super.key});

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
      margin: const EdgeInsets.only(bottom: 12),
      child: GetBuilder<ScheduleController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEFT: Doctor Image
              Container(
                width: Get.width * 0.25,     // responsive
                height: Get.width * 0.25,    // make image square
                margin: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: AppColors.placeholder,
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: logic.doctorImage ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Image.asset(AppAsset.icDoctorPlaceholder, fit: BoxFit.cover),
                  errorWidget: (context, url, error) =>
                      Image.asset(AppAsset.icDoctorPlaceholder, fit: BoxFit.cover),
                ),
              ),

              /// RIGHT: Text Content (Flexible)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 13, bottom: 13, right: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// Doctor Name
                      Text(
                        logic.doctorName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FontStyle.fontStyleW700(
                          fontSize: 15,
                          fontColor: AppColors.title,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// Designation Box
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.specialistBox,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          logic.doctorDesignation ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FontStyle.fontStyleW500(
                            fontSize: 12,
                            fontColor: AppColors.specialist,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// Degree (wrap with ellipsis)
                      Text(
                        logic.doctorDegree ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: FontStyle.fontStyleW500(
                          fontSize: 14,
                          fontColor: AppColors.degreeText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}

/// =================== Select Date =================== ///
class ScheduleDateView extends StatelessWidget {
  const ScheduleDateView({super.key});

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
        GetBuilder<ScheduleController>(
          builder: (logic) {
            return EasyDateTimeLine(
              initialDate: DateFormat("yyyy-MM-dd").parse(logic.date ?? ""),
              disabledDates: logic.getDisabledDates(),
              onDateChange: (selectedDate) async {
                logic.selectedDate = selectedDate;
                logic.formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

                log("Selected Date :: ${logic.selectedDate}");

                await logic.onGetBookingApiCall(
                  date: logic.formattedDate,
                  doctorId: logic.doctorId ?? "",
                );

                ///TODO
                // logic.onSelectSlot();
                logic.onGetSlotsList();
                logic.onBookedSlot();

                if (logic.formattedDate != logic.date) {
                  logic.selectedSlotsList.clear();
                } else {
                  logic.selectedSlotsList.removeWhere((element) => element != logic.time);

                  log("Then SelectedSlot List :: ${logic.selectedSlotsList}");
                }
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
class ScheduleSlotView extends StatelessWidget {
  const ScheduleSlotView({super.key});

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
        GetBuilder<ScheduleController>(
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
        GetBuilder<ScheduleController>(
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
  ScheduleController scheduleController = Get.find<ScheduleController>();

  scheduleController.hasMorningSlots = slots.any((slot) {
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
    child: GetBuilder<ScheduleController>(
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

/// =================== Bottom View =================== ///
class ScheduleBottomView extends StatelessWidget {
  const ScheduleBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
      id: Constant.idProgressView,
      builder: (logic) {
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
              GestureDetector(
                onTap: () {
                  logic.onReScheduleClick();
                },
                child: PrimaryAppButton(
                  height: Get.height * 0.06,
                  width: Get.width * 0.90,
                  borderRadius: 11,
                  gradientColor: [AppColors.call1, AppColors.call2],
                  text: EnumLocale.txtReSchedule.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 16,
                    fontColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
