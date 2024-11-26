import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/dialog/select_date_dialog.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/my_appointment_screen/controller/my_appointment_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// =================== App Bar =================== ///
class MyAppointmentAppBarView extends StatelessWidget {
  const MyAppointmentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyAppointment.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Title =================== ///
class MyAppointmentTitleView extends StatelessWidget {
  const MyAppointmentTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          EnumLocale.txtAppointmentDetails.name.tr,
          style: FontStyle.fontStyleW600(
            fontSize: 16.5,
            fontColor: AppColors.bottomLabel,
          ),
        ),
        GetBuilder<MyAppointmentController>(
          id: Constant.idSelectDateRange,
          builder: (logic) {
            return GestureDetector(
              onTap: () {
                Get.dialog(
                  Dialog(
                    backgroundColor: AppColors.transparent,
                    surfaceTintColor: AppColors.transparent,
                    shadowColor: AppColors.transparent,
                    elevation: 0,
                    child: const SelectDateDialog(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                decoration: BoxDecoration(
                  color: AppColors.specialistBox,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    logic.startDateFormatted == null ? "ALL" : "${logic.startDateFormatted} TO\n${logic.endDateFormatted}",
                    style: FontStyle.fontStyleW600(
                      fontColor: AppColors.degreeText,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    ).paddingAll(15);
  }
}

/// =================== List View =================== ///
class MyAppointmentListView extends StatelessWidget {
  const MyAppointmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.getMyAppointment.isEmpty
            ? logic.isLoading
                ? Shimmers.cancelAppointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  ).paddingOnly(bottom: Get.height * 0.05, left: 15, right: 15)
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: logic.scrollController,
                      itemCount: logic.getMyAppointment.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 800),
                          columnCount: logic.getMyAppointment.length,
                          child: MyAppointmentListItemView(index: index),
                        );
                      },
                    ),
                  ),
                  logic.isLoading1
                      ? CircularProgressIndicator(
                          color: AppColors.primaryAppColor1,
                        ).paddingOnly(bottom: 10)
                      : const SizedBox()
                ],
              );
      },
    );
  }
}

class MyAppointmentListItemView extends StatelessWidget {
  final int index;

  const MyAppointmentListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentController>(
      builder: (logic) {
        DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(logic.getMyAppointment[index].date ?? "");
        logic.expiryDate = DateFormat("dd MMM yyyy").format(parsedDate);
        logic.date.add(logic.expiryDate);

        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.bookingInformation,
              arguments: [
                logic.getMyAppointment[index].id,
              ],
            );
          },
          child: Container(
            height: Get.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                width: 1.5,
                color: AppColors.appointmentBorder,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  // height: Get.height * 0.125,
                  child: Row(
                    children: [
                      Container(
                        // height: Get.height * 0.125,
                        width: Get.width * 0.27,
                        decoration: BoxDecoration(
                          color: AppColors.placeholder,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: logic.getMyAppointment[index].doctor?.image ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              logic.getMyAppointment[index].doctor?.name ?? "",
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
                                  logic.getMyAppointment[index].doctor?.designation ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 11.5,
                                    fontColor: AppColors.specialist,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  logic.getMyAppointment[index].doctor?.degree?.join(", ") ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 14,
                                    fontColor: AppColors.degreeText,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: logic.getMyAppointment[index].type == 1 ? AppColors.online : AppColors.specialistBox,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    child: Text(
                                      logic.getMyAppointment[index].type == 1
                                          ? EnumLocale.txtOnline.name.tr
                                          : EnumLocale.txtAtClinic.name.tr,
                                      style: FontStyle.fontStyleW600(
                                        fontSize: 13,
                                        fontColor: logic.getMyAppointment[index].type == 1
                                            ? AppColors.onlineText
                                            : AppColors.tabUnselectText,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ).paddingOnly(left: 10, top: 5, bottom: 5),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1.5,
                  color: AppColors.divider,
                ).paddingOnly(top: 2, bottom: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppAsset.icAppointmentOutline, height: 22, width: 22).paddingOnly(right: 5),
                        Text(
                          logic.date[index],
                          style: FontStyle.fontStyleW500(
                            fontSize: 13,
                            fontColor: AppColors.degreeText,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(AppAsset.icClock, height: 22, width: 22).paddingOnly(right: 5),
                        Text(
                          logic.getMyAppointment[index].time ?? "",
                          style: FontStyle.fontStyleW500(
                            fontSize: 13,
                            fontColor: AppColors.degreeText,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onLongPress: () {
                        Utils.copyText(logic.getMyAppointment[index].appointmentId ?? "");
                        Utils.showToast(Get.context!, "Copied ${logic.getMyAppointment[index].appointmentId}");
                      },
                      child: Row(
                        children: [
                          Image.asset(AppAsset.icId, height: 24, width: 24).paddingOnly(right: 5),
                          Text(
                            logic.getMyAppointment[index].appointmentId ?? "",
                            style: FontStyle.fontStyleW500(
                              fontSize: 13,
                              fontColor: AppColors.degreeText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                PrimaryAppButton(
                  height: Get.height * 0.06,
                  width: Get.width * 0.85,
                  borderRadius: 9,
                  color: logic.getMyAppointment[index].status == 1
                      ? AppColors.pendingBox
                      : logic.getMyAppointment[index].status == 3
                          ? AppColors.call1
                          : AppColors.disableSlot,
                  text: logic.getMyAppointment[index].status == 1
                      ? EnumLocale.desThisAppointmentPending.name.tr
                      : logic.getMyAppointment[index].status == 3
                          ? "Completed"
                          : EnumLocale.desThisAppointmentCancelled.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 13,
                    fontColor: logic.getMyAppointment[index].status == 1
                        ? AppColors.tabUnselectText
                        : logic.getMyAppointment[index].status == 3
                            ? AppColors.white
                            : AppColors.disableSlotText,
                  ),
                ),
              ],
            ).paddingAll(12),
          ).paddingOnly(left: 18, right: 18, bottom: 18),
        );
      },
    );
  }
}
