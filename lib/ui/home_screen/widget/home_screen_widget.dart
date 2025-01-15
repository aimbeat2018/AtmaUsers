// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/bottom_sheet/upcoming_appointment_bottom_sheet.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/help_task_screen/controller/help_desk_screen_controller.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_service_model.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scroll_page_view/scroll_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// =================== App Bar =================== ///
class HomeAppBarView extends StatelessWidget {
  const HomeAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height * 0.185,
          width: Get.width,
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
                    return Image.asset(AppAsset.icUserPlaceholder,
                            color: AppColors.user)
                        .paddingAll(10);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppAsset.icUserPlaceholder,
                            color: AppColors.user)
                        .paddingAll(10);
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
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.search);
          },
          child: Container(
            height: Get.height * 0.063,
            width: Get.width,
            margin:
                EdgeInsets.only(left: 15, right: 15, top: Get.height * 0.155),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
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
            child: Row(
              children: [
                Image.asset(
                  AppAsset.icSearch,
                  height: Get.height * 0.065,
                  width: Get.width * 0.065,
                ).paddingOnly(left: 10, right: 10),
                Text(
                  EnumLocale.txtSearchDoctor.name.tr,
                  style: FontStyle.fontStyleW400(
                    fontSize: 14.5,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  AppAsset.icCategory,
                  height: Get.height * 0.065,
                  width: Get.width * 0.065,
                ).paddingOnly(right: 12)
              ],
            ),
          ),
        )
      ],
    );
  }
}

/// =================== Upcoming Appointment =================== ///
class MyAppointmentTitleView extends StatelessWidget {
  const MyAppointmentTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              EnumLocale.txtMyAppointment.name.tr,
              style: FontStyle.fontStyleW600(
                fontSize: 17,
                fontColor: AppColors.title,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.upcomingAppointment,
                );
              },
              child: Text(
                EnumLocale.txtViewMore.name.tr,
                style: FontStyle.fontStyleW500(
                  fontSize: 12,
                  fontColor: AppColors.tabUnselectText,
                  textDecoration: TextDecoration.underline,
                  decorationColor: AppColors.tabUnselectText,
                ),
              ),
            )
          ],
        ).paddingOnly(top: 15, left: 15, right: 15);
      },
    );
  }
}

class MyAppointmentItemView extends StatelessWidget {
  const MyAppointmentItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return SizedBox(
          height: 225,
          child: logic.isLoading
              ? Shimmers.upcomingAppointmentShimmer()
              : PageView.builder(
                  itemCount:
                      (logic.getUpcomingAppointmentModel?.data?.length ?? 0) > 5
                          ? 5
                          : logic.getUpcomingAppointmentModel?.data?.length ??
                              0,
                  scrollDirection: Axis.horizontal,
                  controller: logic.pageController,
                  itemBuilder: (context, index) {
                    DateTime date = DateTime.parse(
                        logic.getUpcomingAppointmentModel?.data?[index].date ??
                            "");
                    String formattedDate = DateFormat('dd MMMM').format(date);

                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return UpcomingAppointmentBottomSheet(
                              image: logic.getUpcomingAppointmentModel
                                      ?.data?[index].doctor?.image ??
                                  "",
                              doctorName: logic.getUpcomingAppointmentModel
                                      ?.data?[index].doctor?.name ??
                                  "",
                              designation: logic.getUpcomingAppointmentModel
                                      ?.data?[index].doctor?.designation ??
                                  "",
                              degree: logic.getUpcomingAppointmentModel
                                      ?.data?[index].doctor?.degree
                                      ?.join(", ") ??
                                  "",
                              appointmentType: logic.getUpcomingAppointmentModel
                                      ?.data?[index].type
                                      ?.toInt() ??
                                  0,
                              formattedDate: formattedDate,
                              time: logic.getUpcomingAppointmentModel
                                      ?.data?[index].time ??
                                  "",
                              appointmentId: logic.getUpcomingAppointmentModel
                                      ?.data?[index].id ??
                                  "",
                              doctorId: logic.getUpcomingAppointmentModel
                                      ?.data?[index].doctor?.id ??
                                  "",
                              isViewAll: false,
                            );
                          },
                        );
                      },
                      child: Container(
                        // height: 295,
                        width: Get.width,
                        margin:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: AppColors.divider,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Container(
                                    // height: Get.height * 0.125,
                                    width: Get.width * 0.27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.placeholder,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CachedNetworkImage(
                                      imageUrl: logic
                                              .getUpcomingAppointmentModel
                                              ?.data?[index]
                                              .doctor
                                              ?.image ??
                                          "",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Image.asset(
                                                AppAsset.icDoctorPlaceholder)
                                            .paddingAll(10);
                                      },
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                                AppAsset.icDoctorPlaceholder)
                                            .paddingAll(10);
                                      },
                                    ),
                                  ).paddingOnly(right: 12),
                                  Container(
                                    // height: Get.height * 0.125,
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          logic.getUpcomingAppointmentModel
                                                  ?.data?[index].doctor?.name ??
                                              "",
                                          style: FontStyle.fontStyleW700(
                                            fontSize: 15,
                                            fontColor: AppColors.title,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.specialistBox,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            child: Text(
                                              logic
                                                      .getUpcomingAppointmentModel
                                                      ?.data?[index]
                                                      .doctor
                                                      ?.designation ??
                                                  "",
                                              style: FontStyle.fontStyleW500(
                                                fontSize: 12,
                                                fontColor: AppColors.specialist,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          logic.getUpcomingAppointmentModel
                                                  ?.data?[index].doctor?.degree
                                                  ?.join(", ") ??
                                              "",
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
                            ),
                            // const Spacer(),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // height: 75,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: AppColors.placeholder,
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: logic.getUpcomingAppointmentModel
                                                    ?.data?[index].type ==
                                                1
                                            ? AppColors.call1
                                            : AppColors.message1,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(9),
                                    child: Image.asset(logic
                                                .getUpcomingAppointmentModel
                                                ?.data?[index]
                                                .type ==
                                            1
                                        ? AppAsset.icSend
                                        : AppAsset.icHome),
                                  ).paddingOnly(right: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          logic.getUpcomingAppointmentModel
                                                      ?.data?[index].type ==
                                                  1
                                              ? EnumLocale.txtOnline.name.tr
                                              : EnumLocale.txtAtClinic.name.tr,
                                          style: FontStyle.fontStyleW700(
                                            fontSize: 14,
                                            fontColor:
                                                logic.getUpcomingAppointmentModel
                                                            ?.data?[index].type ==
                                                        1
                                                    ? AppColors.call1
                                                    : AppColors.message1,
                                          ),
                                        ),
                                        Text(
                                          EnumLocale.txtAppointmentType.name.tr,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyle.fontStyleW500(
                                            fontSize: 12,
                                            fontColor: AppColors.degreeText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Container(
                                  //   height: 36,
                                  //   width: 2,
                                  //   color: AppColors.divider,
                                  // ),
                                  // const Spacer(),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryAppColor1,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(11),
                                    child: Image.asset(
                                        AppAsset.icAppointmentFilled,
                                        color: AppColors.white),
                                  ).paddingOnly(right: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$formattedDate ${logic.getUpcomingAppointmentModel?.data?[index].time}",
                                          style: FontStyle.fontStyleW700(
                                            fontSize: 13,
                                            fontColor:
                                                AppColors.primaryAppColor1,
                                          ),
                                        ),
                                        Text(
                                          "Appointment Time",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyle.fontStyleW500(
                                            fontSize: 12,
                                            fontColor: AppColors.degreeText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ).paddingOnly(top: 5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class MyAppointmentIndicator extends StatelessWidget {
  const MyAppointmentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? const SizedBox()
            : Center(
                child: SmoothPageIndicator(
                  controller: logic.pageController,
                  count:
                      (logic.getUpcomingAppointmentModel?.data?.length ?? 0) > 5
                          ? 5
                          : logic.getUpcomingAppointmentModel?.data?.length ??
                              0,
                  axisDirection: Axis.horizontal,
                  effect: SwapEffect(
                    spacing: 8,
                    radius: 6,
                    dotWidth: 10,
                    dotHeight: 10,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.2,
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.primaryAppColor1,
                  ),
                ).paddingOnly(top: 8),
              );
      },
    );
  }
}

/// =================== Category =================== ///
class HomeCategoryTitleView extends StatelessWidget {
  const HomeCategoryTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalDivider(
                indent: 14,
                endIndent: 2,
                thickness: 3,
                color: AppColors.primaryAppColor1,
              ).paddingOnly(left: 15),
              Text(
                "Book Appointment & Consultant",
                // EnumLocale.txtCategories.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 14,
                  fontColor: AppColors.black,
                ),
              ).paddingOnly(top: 15, left: 0, right: 15),
            ],
          ),
        );
      },
    );
  }
}

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idCategory,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeServiceShimmer()
            : GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: (logic.addMoreData?.length ?? 0) > 8
                    ? 8
                    : logic.addMoreData?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return HomeCategoryItemView(index: index);
                },
              ).paddingOnly(left: 11, right: 11, top: 12);
      },
    );
  }
}

class HomeCategoryItemView extends StatelessWidget {
  final int index;

  const HomeCategoryItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            if (index == 7) {
              Get.toNamed(AppRoutes.category);
            } else {
              log("The Category Name :: ${logic.addMoreData?[index].name?.toLowerCase()}");
              log("The Category Name :: ${logic.getAllServiceModel!.data?[index].name}");

              if (logic.addMoreData?[index].name?.toLowerCase() == "all") {
                Get.toNamed(
                  AppRoutes.categoryDetail,
                  arguments: [
                    logic.addMoreData?[index].name,
                    logic.addMoreData?[index].id,
                    logic.categoryDoctorList,
                    logic.getAllDoctorList,
                    true,
                  ],
                );
              } else {
                logic.categoryDoctorList = logic.getDoctorsByServiceId(
                    getFilteredDoctorModel: logic.getAllDoctorServiceModel,
                    serviceId: logic.addMoreData?[index].id);

                Get.toNamed(
                  AppRoutes.categoryDetail,
                  arguments: [
                    logic.addMoreData?[index].name,
                    logic.addMoreData?[index].id,
                    logic.categoryDoctorList,
                    logic.getAllDoctorList,
                    false,
                  ],
                );
              }
            }
          },
          child: Column(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.placeholder,
                ),
                padding: const EdgeInsets.all(15),
                // clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: logic.addMoreData?[index].image ?? "",
                  // fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Image.asset(AppAsset.icCategoryPlaceholder)
                        .paddingAll(10);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppAsset.icCategoryPlaceholder)
                        .paddingAll(10);
                  },
                ),
              ).paddingOnly(bottom: 10),
              Text(
                logic.addMoreData?[index].name ?? "",
                overflow: TextOverflow.ellipsis,
                style: FontStyle.fontStyleW500(
                  fontSize: 13,
                  fontColor: AppColors.categoryText,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

/// =================== Banner =================== ///
class HomeBannerView extends StatelessWidget {
  const HomeBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        logic.bannersImages =
            (logic.getAllBannerModel?.data?.map((item) => item.image).toList());

        logic.type =
            (logic.getAllBannerModel?.data?.map((item) => item.type).toList());

        return logic.getAllBannerModel?.data?.isEmpty == true
            ? const SizedBox.shrink()
            : logic.isLoading
                ? Shimmers.homeBannerShimmer()
                : Container(
                    height: Get.height * 0.25,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.bannerIndicator.withOpacity(0.01),
                    ),
                    child: ScrollPageView(
                      controller: ScrollPageController(),
                      indicatorColor: AppColors.bannerIndicator,
                      checkedIndicatorColor: AppColors.categoryText,
                      indicatorAlign: Alignment.bottomCenter,
                      indicatorPadding: const EdgeInsets.all(5),
                      indicatorRadius: 8,
                      children: logic.bannersImages?.asMap().entries.map(
                            (entry) {
                              int index = entry.key;
                              String image = entry.value;

                              return GestureDetector(
                                onTap: () {
                                  if (logic.type!.isNotEmpty &&
                                      index < logic.type!.length) {
                                    if (logic.type?[index] == 2) {
                                      Utils.launchURL(logic.getAllBannerModel
                                              ?.data?[index].url ??
                                          "");
                                    } else if (logic.type?[index] == 1) {
                                      logic.categoryDoctorList =
                                          logic.getDoctorsByServiceId(
                                              getFilteredDoctorModel: logic
                                                  .getAllDoctorServiceModel,
                                              serviceId:
                                                  logic.addMoreData?[index].id);

                                      Get.toNamed(AppRoutes.categoryDetail,
                                          arguments: [
                                            logic.getAllBannerModel
                                                ?.data?[index].service?.name,
                                            logic.getAllBannerModel
                                                ?.data?[index].service?.id,
                                            logic.categoryDoctorList,
                                          ]);
                                    }
                                  }
                                },
                                child: logic.imageView(image),
                              );
                            },
                          ).toList() ??
                          [],
                    ),
                  );
      },
    );
  }
}

/// =================== Lab test =================== ///
class LabTestView extends StatelessWidget {
  const LabTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.labTests);
        },
        child: Image.asset(AppAsset.labTestImg));
  }
}

/// =================== Pharmacy Booking =================== ///
class PharmacyBookingView extends StatelessWidget {
  const PharmacyBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.pharmacyBooking);
        },
        child: Image.asset(AppAsset.pharmacyBookingImg));
  }
}

/// =================== Medicine =================== ///
class MedicineTitleView extends StatelessWidget {
  const MedicineTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              VerticalDivider(
                indent: 2,
                endIndent: 1,
                thickness: 3,
                color: AppColors.primaryAppColor1,
              ),
              Text(
                "Medicine you are looking for",
                style: FontStyle.fontStyleW600(
                  fontSize: 15,
                  fontColor: AppColors.title,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.topSpecialist,
              // arguments: [logic.getAllServiceModel?.data],
            );
          },
          child: Text(
            "View All",
            style: FontStyle.fontStyleW500(
              fontSize: 12,
              fontColor: AppColors.tabUnselectText,
              decorationColor: AppColors.tabUnselectText,
            ),
          ),
        )
      ],
    ).paddingOnly(top: 15, left: 15, right: 15);
    ;
  }
}

class MedicineItemView extends StatelessWidget {
  const MedicineItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.24,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return MedicineListView(index: index);
        },
      ),
    ).paddingOnly(bottom: 20);
  }
}

class MedicineListView extends StatelessWidget {
  final int index;

  const MedicineListView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.medicineDetails);
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.primaryAppColor1,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Image.asset(AppAsset.medicineImg1, height: 60),
            ).paddingOnly(left: 8, right: 8, top: 8),
            Text(
              "Crocin Advance (500 mg)",
              style: FontStyle.fontStyleW600(
                fontSize: 13,
                fontColor: AppColors.white,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "₹ 50.00",
                    style: FontStyle.fontStyleW500(
                      fontSize: 15,
                      fontColor: AppColors.black,
                      textDecoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.black,
                    ),
                  ).paddingOnly(left: 10.0, top: 5.0),
                ),
                Expanded(
                  child: Container(
                      // padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 50.0, right: 50.0),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(EnumLocale.txtAddedToCart.name.tr,
                        style: FontStyle.fontStyleW600(
                          fontSize: 11,
                          fontColor: AppColors.primaryAppColor1,
                        ),).paddingOnly(right: 2.0)
                  ).paddingOnly(left: 25.0, right: 25.0),
                ),
              ],
            ),

          ],
        ),
      ).paddingOnly(top: 10, left: 10, right: 10),
    );
  }
}

/// =================== Specialist Title =================== ///
class HomeSpecialistTitleView extends StatelessWidget {
  const HomeSpecialistTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    indent: 2,
                    endIndent: 1,
                    thickness: 3,
                    color: AppColors.primaryAppColor1,
                  ),
                  Text(
                    EnumLocale.txtBestSpecialist.name.tr,
                    style: FontStyle.fontStyleW600(
                      fontSize: 17,
                      fontColor: AppColors.title,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.topSpecialist,
                  arguments: [logic.getAllServiceModel?.data],
                );
              },
              child: Text(
                EnumLocale.txtViewMore.name.tr,
                style: FontStyle.fontStyleW500(
                  fontSize: 12,
                  fontColor: AppColors.tabUnselectText,
                  textDecoration: TextDecoration.underline,
                  decorationColor: AppColors.tabUnselectText,
                ),
              ),
            )
          ],
        ).paddingOnly(top: 15, left: 15, right: 15);
      },
    );
  }
}

/// =================== Tab bar =================== ///
class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HomeTabBarView(),
        HomeTabBarItemView(),
      ],
    );
  }
}

class HomeTabBarView extends StatelessWidget {
  const HomeTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idTabBar,
      builder: (logic) {
        return DefaultTabController(
          length: logic.addData?.length ?? 0,
          child: logic.isLoading
              ? Shimmers.homeTabShimmer()
              : TabBar(
                  controller: logic.tabController,
                  tabs: logic.addData?.map<Tab>((category) {
                        return Tab(
                          text: category.name.toString().capitalizeFirst,
                        );
                      }).toList() ??
                      [],
                  labelStyle: FontStyle.fontStyleW500(
                    fontSize: 13.5,
                    fontColor: AppColors.white,
                  ),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                ),
        );
      },
    );
  }
}

class HomeTabBarItemView extends StatelessWidget {
  const HomeTabBarItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<HomeScreenController>(
        id: Constant.idTabBarView,
        builder: (logic) {
          return DefaultTabController(
            length: logic.addData?.length ?? 0,
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: logic.tabController,
              children: List.generate(
                (logic.addData?.length ?? 0),
                (index) => const GeneralSpecialistView(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GeneralSpecialistView extends StatelessWidget {
  const GeneralSpecialistView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return SingleChildScrollView(
          child: logic.isLoading1
              ? Shimmers.homeTabBarShimmer()
              : logic.tabController?.index == 0
                  ? logic.getAllDoctorList.isEmpty == true
                      ? NoDataFound(
                          image: AppAsset.icNoDoctorFound,
                          imageHeight: 80,
                          text: EnumLocale.noDataFoundDoctor.name.tr,
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: logic.getAllDoctorList.length,
                          itemBuilder: (context, index) {
                            return SpecialistListItemView(
                              getAllDoctors: logic.getAllDoctorList[index],
                              isAllDoctor: true,
                            );
                          },
                        )
                  : logic.doctorList?.isEmpty == true
                      ? NoDataFound(
                          image: AppAsset.icNoDoctorFound,
                          imageHeight: 80,
                          text: EnumLocale.noDataFoundDoctor.name.tr,
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: logic.doctorList?.length,
                          itemBuilder: (context, index) {
                            return SpecialistListItemView(
                              doctors: logic.doctorList?[index],
                              isAllDoctor: false,
                            );
                          },
                        ),
        );
      },
    );
  }
}

class SpecialistListItemView extends StatelessWidget {
  Doctors? doctors;
  GetAllDoctors? getAllDoctors;
  final bool isAllDoctor;

  SpecialistListItemView(
      {super.key, this.doctors, this.getAllDoctors, required this.isAllDoctor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return isAllDoctor == true
            ? GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.specialistDetail,
                    arguments: [
                      getAllDoctors?.id,
                      getAllDoctors?.service?.first,
                    ],
                  )?.then((value) async {
                    await logic.onGetDoctorsServiceWiseApiCall(
                      userId: Constant.storage.read("userId"),
                    );
                  });
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.containerBg,
                    borderRadius: BorderRadius.circular(18),
                    //border removed when changing design
                    // border: Border.all(
                    //   color: AppColors.divider,
                    //   width: 1.3,
                    // ),
                  ),
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height * 0.13,
                        width: Get.height * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.placeholder,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: getAllDoctors?.image ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Image.asset(AppAsset.icDoctorPlaceholder)
                                .paddingAll(10);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icDoctorPlaceholder)
                                .paddingAll(10);
                          },
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Expanded(
                        child: SizedBox(
                          height: Get.height * 0.13,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getAllDoctors?.name ?? "",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 16,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                              Text(
                                getAllDoctors?.degree?.join(", ") ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13.5,
                                  fontColor: AppColors.primaryAppColorTitle,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.56,
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.divider1,
                                    width: 0.50,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.60,
                                child: Text(
                                  '${getAllDoctors?.designation} | ${getAllDoctors?.clinicName}',
                                  style: FontStyle.fontStyleW400(
                                    fontSize: 13,
                                    fontColor: AppColors.primaryAppColorTitle,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    AppAsset.icRating,
                                    height: 18,
                                  ),
                                  Text(
                                    '  ${getAllDoctors?.rating?.toStringAsFixed(1)} ${EnumLocale.txtReviews.name.tr}',
                                    style: FontStyle.fontStyleW600(
                                      fontSize: 12,
                                      fontColor: AppColors.rating,
                                    ),
                                  ),
                                ],
                              ).paddingOnly(top: 7)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      GestureDetector(
                        onTap: () async {
                          await logic.onGetSavedDoctorApiCall(
                            userId: Constant.storage.read("userId"),
                            doctorId: getAllDoctors?.id ?? "",
                          );

                          logic.onSavedClick(isAllDoctor: true);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.categoryCircle,
                          ),
                          child: getAllDoctors?.isSaved == true
                              ? Image.asset(AppAsset.icSaveFilled)
                              : Image.asset(AppAsset.icSaveOutline),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.specialistDetail,
                    arguments: [
                      doctors?.id,
                      logic.addData?[logic.tabController?.index ?? 0].id ?? "",
                    ],
                  )?.then((value) async {
                    await logic.onGetDoctorsServiceWiseApiCall(
                      userId: Constant.storage.read("userId"),
                    );
                  });
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppColors.divider,
                      width: 1.3,
                    ),
                  ),
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height * 0.13,
                        width: Get.height * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.placeholder,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: doctors?.image ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Image.asset(AppAsset.icDoctorPlaceholder)
                                .paddingAll(10);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icDoctorPlaceholder)
                                .paddingAll(10);
                          },
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Expanded(
                        child: SizedBox(
                          height: Get.height * 0.13,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                doctors?.name ?? "",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 16,
                                  fontColor: AppColors.title,
                                ),
                              ),
                              Text(
                                doctors?.degree?.join(", ") ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13.5,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.56,
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.divider,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.60,
                                child: Text(
                                  '${doctors?.designation} | ${doctors?.clinicName}',
                                  style: FontStyle.fontStyleW400(
                                    fontSize: 13,
                                    fontColor: AppColors.degreeText,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    AppAsset.icRating,
                                    height: 18,
                                  ),
                                  Text(
                                    '  ${doctors?.rating?.toStringAsFixed(1)} ${EnumLocale.txtReviews.name.tr}',
                                    style: FontStyle.fontStyleW600(
                                      fontSize: 12,
                                      fontColor: AppColors.rating,
                                    ),
                                  ),
                                ],
                              ).paddingOnly(top: 7)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      GestureDetector(
                        onTap: () async {
                          await logic.onGetSavedDoctorApiCall(
                            userId: Constant.storage.read("userId"),
                            doctorId: doctors?.id ?? "",
                          );

                          logic.onSavedClick(isAllDoctor: false);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.categoryCircle,
                          ),
                          child: doctors?.isSaved == true
                              ? Image.asset(AppAsset.icSaveFilled)
                              : Image.asset(AppAsset.icSaveOutline),
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
