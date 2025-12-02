import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/dialog/cancel_appointment_dialog.dart';
import 'package:doctor/custom/dialog/review_dialog.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class AppointmentAppBarView extends StatelessWidget {
  const AppointmentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: Get.height * 0.1 + statusBarHeight,
      width: Get.width,
      padding: EdgeInsets.only(top: statusBarHeight - 10),
      decoration: BoxDecoration(
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
        children: [
          Container(
            height: Get.height * 0.145,
            width: Get.width * 0.145,
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.placeholder,
              border: Border.all(color: AppColors.white, width: 1),
            ),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl: Constant.storage.read("userImage") ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Image.asset(AppAsset.icUserPlaceholder, color: AppColors.user).paddingAll(10);
              },
              errorWidget: (context, url, error) {
                return Image.asset(AppAsset.icUserPlaceholder, color: AppColors.user).paddingAll(10);
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${EnumLocale.txtHello.name.tr} ${Constant.storage.read("userName")}",
                style: FontStyle.fontStyleW700(
                  fontSize: 18,
                  fontColor: AppColors.white,
                ),
              ).paddingOnly(bottom: 3),
              SizedBox(
                width: Get.width * 0.55,
                child: Text(
                  EnumLocale.desToday.name.tr,
                  style: FontStyle.fontStyleW400(
                    fontSize: 13,
                    fontColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.notification);
            },
            child: Container(
              height: Get.height * 0.11,
              width: Get.width * 0.11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 15),
              child: Image.asset(AppAsset.icNotification),
            ),
          )
        ],
      ),
    );
  }
}

/// =================== Tab Bar =================== ///
class AppointmentTabView extends StatelessWidget {
  const AppointmentTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtViewAppointment.name.tr,
          style: FontStyle.fontStyleW600(
            fontSize: 16,
            fontColor: AppColors.title,
          ),
        ).paddingOnly(top: 10, left: 15),
        const AppointmentTabBarView(),
        const AppointmentTabBarItemView(),
      ],
    );
  }
}

class AppointmentTabBarView extends StatelessWidget {
  const AppointmentTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Tab(text: EnumLocale.txtPendingAppointment.name.tr),
      Tab(text: EnumLocale.txtCancelledAppointment.name.tr),
      Tab(text: EnumLocale.txtCompletedAppointment.name.tr),
    ];

    return GetBuilder<AppointmentScreenController>(
      builder: (logic) {
        return TabBar(
          controller: logic.tabController,
          tabs: tabs,
          labelStyle: FontStyle.fontStyleW500(
            fontSize: 13.5,
            fontColor: AppColors.white,
          ),
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          indicatorPadding: const EdgeInsets.all(5),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                AppColors.primaryAppColor1,
                AppColors.primaryAppColor2,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.white,
          unselectedLabelStyle: FontStyle.fontStyleW500(
            fontSize: 13.5,
            fontColor: AppColors.tabUnselectText,
          ),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
        );
      },
    );
  }
}

class AppointmentTabBarItemView extends StatelessWidget {
  const AppointmentTabBarItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      builder: (logic) {
        return Expanded(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: logic.tabController,
            children: const [
              PendingAppointment(),
              CancelAppointment(),
              CompleteAppointment(),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Pending Appointment =================== ///
class PendingAppointment extends StatelessWidget {
  const PendingAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.getPending.isEmpty
            ? logic.isLoading
                ? Shimmers.cancelAppointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundPendingAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onPendingRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: logic.getPending.length,
                        controller: logic.pendingScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getPending.length,
                            child: PendingAppointmentListItemView(index: index),
                          );
                        },
                      ),
                    ),
                    logic.isLoading2
                        ? CircularProgressIndicator(
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(bottom: 10)
                        : const SizedBox()
                  ],
                ),
              );
      },
    );
  }
}

class PendingAppointmentListItemView extends StatelessWidget {
  final int index;

  const PendingAppointmentListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.bookingInformation,
              arguments: [
                logic.getPending[index].id,
              ],
            );
          },
          child: Container(
            height: logic.getPending[index].status == 2 ? Get.height * 0.215 : Get.height * 0.29,
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
                        height: Get.height * 0.125,
                        width: Get.width * 0.27,
                        decoration: BoxDecoration(
                          color: AppColors.placeholder,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: logic.getPending[index].doctor?.image ?? "",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  logic.getPending[index].doctor?.name ?? "",
                                  style: FontStyle.fontStyleW700(
                                    fontSize: 16,
                                    fontColor: AppColors.title,
                                  ),
                                ),
                                if (logic.getPending[index].status == 2) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.greenBox,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 7,
                                          width: 7,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.call2),
                                        ).paddingOnly(right: 3),
                                        Text(
                                          EnumLocale.txtWorkProgress.name.tr,
                                          style: FontStyle.fontStyleW500(
                                            fontSize: 9,
                                            fontColor: AppColors.call2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.specialistBox,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                child: Text(
                                  logic.getPending[index].doctor?.designation ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 11.5,
                                    fontColor: AppColors.specialist,
                                  ),
                                ),
                              ),
                            ),
                        Row(
                          children: [
                            /// DEGREE TEXT (Flexible to avoid overflow)
                            Expanded(
                              child: Text(
                                logic.getPending[index].doctor?.degree?.join(", ") ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyle.fontStyleW500(
                                  fontSize: 14,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            /// TYPE CONTAINER (fixed width based on text)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                color: logic.getPending[index].type == 1
                                    ? AppColors.online
                                    : AppColors.specialistBox,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                logic.getPending[index].type == 1
                                    ? EnumLocale.txtOnline.name.tr
                                    : EnumLocale.txtAtClinic.name.tr,
                                style: FontStyle.fontStyleW600(
                                  fontSize: 13,
                                  fontColor: logic.getPending[index].type == 1
                                      ? AppColors.onlineText
                                      : AppColors.tabUnselectText,
                                ),
                              ),
                            ),
                          ],
                        )

                        ],
                        ).paddingOnly(left: 10, top: 5, bottom: 5),
                      )
                    ],
                  ),
                ),
                Divider(
                  // height: 1.5,
                  color: AppColors.divider,
                )/*.paddingOnly(top: 12, bottom: 12)*/,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppAsset.icAppointmentOutline, height: 22, width: 22).paddingOnly(right: 5),
                        Text(
                          logic.formatedDate(logic.getPending[index].date ?? ''),
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
                          logic.getPending[index].time ?? "",
                          style: FontStyle.fontStyleW500(
                            fontSize: 13,
                            fontColor: AppColors.degreeText,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onLongPress: () {
                        Utils.copyText(logic.getPending[index].appointmentId ?? "");
                        Utils.showToast(Get.context!, "Copied ${logic.getPending[index].appointmentId}");
                      },
                      child: Row(
                        children: [
                          Image.asset(AppAsset.icId, height: 24, width: 24).paddingOnly(right: 5),
                          Text(
                            logic.getPending[index].appointmentId ?? "",
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
                logic.getPending[index].status == 2
                    ? const SizedBox()
                    : Row(
                        children: [
                          Expanded(
                            child: PrimaryAppButton(
                              onTap: () {
                                Get.dialog(
                                  barrierColor: AppColors.black.withOpacity(0.8),
                                  GetBuilder<AppointmentScreenController>(
                                    id: Constant.idProgressView,
                                    builder: (logic) {
                                      return ProgressDialog(
                                        inAsyncCall: logic.isLoading1,
                                        child: Dialog(
                                          backgroundColor: AppColors.transparent,
                                          shadowColor: Colors.transparent,
                                          surfaceTintColor: Colors.transparent,
                                          elevation: 0,
                                          child: CancelAppointmentDialog(
                                            appointmentId: logic.getPending[index].id ?? "",
                                            isHomeScreen: false,
                                            isViewAll: false,
                                          ),
                                        ),
                                      );
                                    },
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
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PrimaryAppButton(
                              onTap: () {
                                Get.toNamed(AppRoutes.schedule, arguments: [
                                  logic.getPending[index].doctor?.image,
                                  logic.getPending[index].doctor?.name,
                                  logic.getPending[index].doctor?.designation,
                                  logic.getPending[index].doctor?.degree?.join(", "),
                                  logic.getPending[index].date,
                                  logic.getPending[index].time,
                                  logic.getPending[index].type,
                                  logic.getPending[index].id,
                                  logic.getPending[index].doctor?.id,
                                ])?.then(
                                  (value) async {
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
                                  },
                                );
                              },
                              height: Get.height * 0.059,
                              borderRadius: 9,
                              gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                              text: EnumLocale.txtReSchedule.name.tr,
                              textStyle: FontStyle.fontStyleW600(
                                fontSize: 13,
                                fontColor: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ).paddingAll(12),
          ).paddingOnly(left: 12, right: 12, bottom: 18),
        );
      },
    );
  }
}

/// =================== Cancel Appointment =================== ///
class CancelAppointment extends StatelessWidget {
  const CancelAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.getCancel.isEmpty
            ? logic.isLoading
                ? Shimmers.cancelAppointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundCancelAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onCancelRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getCancel.length,
                        controller: logic.cancelScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getCancel.length,
                            child: CancelAppointmentListItemView(index: index),
                          );
                        },
                      ),
                    ),
                    logic.isLoading2
                        ? CircularProgressIndicator(
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(bottom: 10)
                        : const SizedBox()
                  ],
                ),
              );
      },
    );
  }
}

class CancelAppointmentListItemView extends StatelessWidget {
  final int index;

  const CancelAppointmentListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.bookingInformation,
              arguments: [
                logic.getCancel[index].id,
              ],
            );
          },
          child: Container(
            height: Get.height * 0.29,
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
                  height: Get.height * 0.125,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height * 0.125,
                        width: Get.width * 0.27,
                        decoration: BoxDecoration(
                          color: AppColors.placeholder,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: logic.getCancel[index].doctor?.image ?? "",
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
                              logic.getCancel[index].doctor?.name ?? "",
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
                                  logic.getCancel[index].doctor?.designation ?? "",
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
                                  logic.getCancel[index].doctor?.degree?.join(", ") ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 14,
                                    fontColor: AppColors.degreeText,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: logic.getCancel[index].type == 1 ? AppColors.online : AppColors.specialistBox,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    child: Text(
                                      logic.getCancel[index].type == 1
                                          ? EnumLocale.txtOnline.name.tr
                                          : EnumLocale.txtAtClinic.name.tr,
                                      style: FontStyle.fontStyleW600(
                                        fontSize: 13,
                                        fontColor:
                                            logic.getCancel[index].type == 1 ? AppColors.onlineText : AppColors.tabUnselectText,
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
                ).paddingOnly(top: 12, bottom: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppAsset.icAppointmentOutline, height: 22, width: 22).paddingOnly(right: 5),
                        Text(
                          logic.formatedDate(logic.getCancel[index].date ?? ''),
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
                          logic.getCancel[index].time ?? "",
                          style: FontStyle.fontStyleW500(
                            fontSize: 13,
                            fontColor: AppColors.degreeText,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onLongPress: () {
                        Utils.copyText(logic.getCancel[index].appointmentId ?? "");
                        Utils.showToast(Get.context!, "Copied ${logic.getCancel[index].appointmentId}");
                      },
                      child: Row(
                        children: [
                          Image.asset(AppAsset.icId, height: 24, width: 24).paddingOnly(right: 5),
                          Text(
                            logic.getCancel[index].appointmentId ?? "",
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
                  color: AppColors.disableSlot,
                  text: EnumLocale.desThisAppointmentCancelled.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 13,
                    fontColor: AppColors.disableSlotText,
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

/// =================== Complete Appointment =================== ///
class CompleteAppointment extends StatelessWidget {
  const CompleteAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.getComplete.isEmpty
            ? logic.isLoading
                ? Shimmers.cancelAppointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundCompleteAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onCompleteRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getComplete.length,
                        controller: logic.completeScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getComplete.length,
                            child: CompleteAppointmentListItemView(index: index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class CompleteAppointmentListItemView extends StatelessWidget {
  final int index;

  const CompleteAppointmentListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.bookingInformation,
              arguments: [
                logic.getComplete[index].id,
              ],
            );
          },
          child: Container(
            height: Get.height * 0.34,
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
                          imageUrl: logic.getComplete[index].doctor?.image ?? "",
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
                              logic.getComplete[index].doctor?.name ?? "",
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
                                  logic.getComplete[index].doctor?.designation ?? "",
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
                                  logic.getComplete[index].doctor?.degree?.join(", ") ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 14,
                                    fontColor: AppColors.degreeText,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: logic.getComplete[index].type == 1 ? AppColors.online : AppColors.specialistBox,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    child: Text(
                                      logic.getComplete[index].type == 1
                                          ? EnumLocale.txtOnline.name.tr
                                          : EnumLocale.txtAtClinic.name.tr,
                                      style: FontStyle.fontStyleW600(
                                        fontSize: 13,
                                        fontColor:
                                            logic.getComplete[index].type == 1 ? AppColors.onlineText : AppColors.tabUnselectText,
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
                ).paddingOnly(top: 12, bottom: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppAsset.icAppointmentOutline, height: 22, width: 22).paddingOnly(right: 5),
                        Text(
                          logic.formatedDate(logic.getComplete[index].date ?? ''),
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
                          logic.getComplete[index].time ?? "",
                          style: FontStyle.fontStyleW500(
                            fontSize: 13,
                            fontColor: AppColors.degreeText,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onLongPress: () {
                        Utils.copyText(logic.getComplete[index].appointmentId ?? "");
                        Utils.showToast(Get.context!, "Copied ${logic.getComplete[index].appointmentId}");
                      },
                      child: Row(
                        children: [
                          Image.asset(AppAsset.icId, height: 24, width: 24).paddingOnly(right: 5),
                          Text(
                            logic.getComplete[index].appointmentId ?? "",
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
                logic.getComplete[index].isReviewed == true
                    ? PrimaryAppButton(
                        height: Get.height * 0.06,
                        borderRadius: 9,
                        gradientColor: [AppColors.call1, AppColors.call2],
                        text: "Completed",
                        textStyle: FontStyle.fontStyleW600(
                          fontSize: 14,
                          fontColor: AppColors.white,
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: PrimaryAppButton(
                              height: Get.height * 0.059,
                              borderRadius: 9,
                              gradientColor: [AppColors.call1, AppColors.call2],
                              text: "Completed",
                              textStyle: FontStyle.fontStyleW600(
                                fontSize: 11.5,
                                fontColor: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PrimaryAppButton(
                              onTap: () {
                                Get.dialog(
                                  barrierColor: AppColors.black.withOpacity(0.8),
                                  Dialog(
                                    backgroundColor: AppColors.transparent,
                                    shadowColor: Colors.transparent,
                                    surfaceTintColor: Colors.transparent,
                                    elevation: 0,
                                    child: ReviewDialog(
                                      appointmentId: logic.getComplete[index].appointmentId ?? "",
                                      doctorId: logic.getComplete[index].doctor?.id ?? "",
                                    ),
                                  ),
                                );
                              },
                              height: Get.height * 0.059,
                              borderRadius: 9,
                              color: AppColors.review,
                              text: EnumLocale.txtGiveReview.name.tr,
                              textStyle: FontStyle.fontStyleW600(
                                fontSize: 13,
                                fontColor: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ).paddingAll(12),
          ).paddingOnly(left: 18, right: 18, bottom: 18),
        );
      },
    );
  }
}
