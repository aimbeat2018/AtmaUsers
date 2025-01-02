// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/specialist_detail_screen/controller/specialist_detail_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class SpecialistDetailAppBarView extends StatelessWidget {
  SpecialistDetailAppBarView({super.key});

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Stack(
          children: [
            logic.isLoading
                ? Shimmers.doctorImageShimmer()
                : Container(
                    height: Get.height * 0.35,
                    width: Get.width,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(0)),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: logic.getDoctorDetailModel?.data?.image ?? "",
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
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: Get.height * 0.047,
                width: Get.height * 0.047,
                decoration: BoxDecoration(
                  color: AppColors.categoryCircle,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 15, top: 15),
                child: Image.asset(
                  AppAsset.icArrowRight,
                  color: AppColors.title,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () async {
                  await homeScreenController.onGetSavedDoctorApiCall(
                    userId: Constant.storage.read("userId"),
                    doctorId: logic.doctorId ?? "",
                  );

                  await logic.onGetDoctorDetailApiCall(
                    doctorId: logic.doctorId ?? "",
                    userId: Constant.storage.read("userId"),
                  );
                },
                child: Container(
                  height: Get.height * 0.047,
                  width: Get.height * 0.047,
                  decoration: BoxDecoration(
                    color: AppColors.categoryCircle,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(9),
                  margin: const EdgeInsets.only(right: 15, top: 15),
                  child: logic.getDoctorDetailModel?.isSaved == false
                      ? Image.asset(AppAsset.icSaveOutline)
                      : Image.asset(AppAsset.icSaveFilled),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// =================== Bottom Bar =================== ///
class SpecialistDetailBottomView extends StatelessWidget {
  const SpecialistDetailBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
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
                  Get.toNamed(
                    AppRoutes.booking,
                    arguments: [
                      logic.getDoctorDetailModel?.data?.id,
                      logic.getDoctorDetailModel?.data?.name,
                      logic.getDoctorDetailModel?.data?.image,
                      logic.getDoctorDetailModel?.data?.designation,
                      logic.getDoctorDetailModel?.data?.degree?.join(", "),
                      logic.getDoctorDetailModel?.data?.charge.toString(),
                      logic.serviceId,
                      logic.getDoctorDetailModel?.data?.clinicName,
                      logic.getDoctorDetailModel?.data?.address,
                      logic.getDoctorDetailModel?.data?.type,
                    ],
                  );
                },
                child: PrimaryAppButton(
                  height: Get.height * 0.062,
                  width: Get.width * 0.76,
                  borderRadius: 11,
                  gradientColor: [
                    AppColors.primaryAppColor1,
                    AppColors.primaryAppColor2
                  ],
                  widget: RichText(
                    text: TextSpan(
                      text: '${EnumLocale.txtBookNow.name.tr} ',
                      style: FontStyle.fontStyleW500(
                        fontSize: 16,
                        fontColor: AppColors.white,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '$currency ${logic.getDoctorDetailModel?.data?.charge ?? 0.0}',
                          style: FontStyle.fontStyleW700(
                            fontSize: 16,
                            fontColor: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  id = logic.getDoctorDetailModel?.data?.id;

                  Get.toNamed(
                    AppRoutes.personalChat,
                    arguments: [
                      logic.getDoctorDetailModel?.data?.id,
                      "",
                      logic.getDoctorDetailModel?.data?.name,
                      logic.getDoctorDetailModel?.data?.image,
                      logic.getDoctorDetailModel?.data?.designation,
                    ],
                  )?.then((value) {
                    id = '';
                    log("Id for notification :: $id");
                  });
                },
                child: PrimaryAppButton(
                  height: Get.height * 0.062,
                  width: Get.width * 0.14,
                  borderRadius: 11,
                  widget: Image.asset(AppAsset.icMessage, height: 35),
                  iconPadding: 10,
                  color: AppColors.black,
                  // gradientColor: [AppColors.message1, AppColors.message2],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Information =================== ///
class SpecialistDetailInfoView extends StatelessWidget {
  const SpecialistDetailInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.doctorDesShimmer()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        logic.getDoctorDetailModel?.data?.name ?? "",
                        style: FontStyle.fontStyleW700(
                          fontSize: 18,
                          fontColor: AppColors.primaryAppColor1,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.containerBg,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child: Text(
                            logic.getDoctorDetailModel?.data?.designation ?? "",
                            style: FontStyle.fontStyleW500(
                              fontSize: 11.5,
                              fontColor: AppColors.primaryAppColorTitle2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 15, right: 15, top: 8),
                  Text(
                    logic.getDoctorDetailModel?.data?.degree?.join(", ") ?? "",
                    style: FontStyle.fontStyleW500(
                      fontSize: 15,
                      fontColor: AppColors.primaryAppColorTitle2,
                    ),
                  ).paddingOnly(left: 15, bottom: 5),
                  Text(
                    "${logic.getDoctorDetailModel?.data?.clinicName}, ${logic.getDoctorDetailModel?.data?.address}",
                    style: FontStyle.fontStyleW500(
                      fontSize: 13,
                      fontColor: AppColors.primaryAppColorTitle2,
                    ),
                  ).paddingOnly(left: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: Get.height * 0.055,
                              width: Get.height * 0.055,
                              decoration: BoxDecoration(
                                color: AppColors.containerBg,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(11.5),
                              child: Image.asset(AppAsset.icExperience,
                                  color: AppColors.primaryAppColor2),
                            ),
                            RichText(
                              text: TextSpan(
                                text: logic
                                    .getDoctorDetailModel?.data?.experience
                                    .toString(),
                                style: FontStyle.fontStyleW700(
                                  fontSize: 16,
                                  fontColor: AppColors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: EnumLocale.txtYear.name.tr,
                                    style: FontStyle.fontStyleW500(
                                      fontSize: 12,
                                      fontColor: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              EnumLocale.txtExperiences.name.tr,
                              style: FontStyle.fontStyleW500(
                                fontSize: 11,
                                fontColor: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: Get.height * 0.055,
                              width: Get.height * 0.055,
                              decoration: BoxDecoration(
                                color: AppColors.containerBg,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(11.5),
                              child: Image.asset(AppAsset.icHappy,
                                  color: AppColors.primaryAppColor2),
                            ),
                            Text(
                              logic.getDoctorDetailModel?.patients.toString() ??
                                  "",
                              style: FontStyle.fontStyleW700(
                                fontSize: 16,
                                fontColor: AppColors.black,
                              ),
                            ),
                            Text(
                              EnumLocale.txtHappyPatients.name.tr,
                              overflow: TextOverflow.ellipsis,
                              style: FontStyle.fontStyleW500(
                                fontSize: 11,
                                fontColor: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: Get.height * 0.055,
                              width: Get.height * 0.055,
                              decoration: BoxDecoration(
                                color: AppColors.containerBg,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(11.5),
                              child: Image.asset(
                                AppAsset.icRating,
                                color: AppColors.primaryAppColor2,
                              ),
                            ),
                            Text(
                              logic.getDoctorDetailModel?.data?.rating
                                      ?.toStringAsFixed(1) ??
                                  "",
                              style: FontStyle.fontStyleW700(
                                fontSize: 16,
                                fontColor: AppColors.black,
                              ),
                            ),
                            Text(
                              EnumLocale.txtRatings.name.tr,
                              style: FontStyle.fontStyleW500(
                                fontSize: 11,
                                fontColor: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: Get.height * 0.055,
                              width: Get.height * 0.055,
                              decoration: BoxDecoration(
                                color: AppColors.containerBg,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(11.5),
                              child: Image.asset(AppAsset.icReview, color: AppColors.primaryAppColor2,),
                            ),
                            Text(
                              logic.getDoctorDetailModel?.data?.reviewCount
                                      .toString() ??
                                  "",
                              style: FontStyle.fontStyleW700(
                                fontSize: 16,
                                fontColor: AppColors.black,
                              ),
                            ),
                            Text(
                              EnumLocale.txtReviews.name.tr,
                              style: FontStyle.fontStyleW500(
                                fontSize: 11,
                                fontColor: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 15, right: 15, top: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.3,
                        color: AppColors.divider,
                      ),
                    ),
                  ).paddingOnly(top: 10),
                ],
              );
      },
    );
  }
}

/// =================== Tab Bar =================== ///
class SpecialistDetailTabView extends StatelessWidget {
  const SpecialistDetailTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SpecialistDetailTabBarView(),
        SpecialistDetailTabBarItemView(),
      ],
    );
  }
}

class SpecialistDetailTabBarView extends StatelessWidget {
  const SpecialistDetailTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Tab(text: EnumLocale.txtDetails.name.tr),
      Tab(text: EnumLocale.txtAddress.name.tr),
      Tab(text: EnumLocale.txtReviews.name.tr),
      Tab(text: EnumLocale.txtEducation.name.tr),
      Tab(text: EnumLocale.txtExperiences.name.tr),
      Tab(text: EnumLocale.txtAwards.name.tr),
    ];

    return GetBuilder<SpecialistDetailController>(
      id: Constant.idTabBarView,
      builder: (logic) {
        return DefaultTabController(
          length: 6,
          child: TabBar(
            controller: logic.tabController,
            tabs: tabs,
            labelStyle: FontStyle.fontStyleW500(
              fontSize: 14,
              fontColor: AppColors.white,
            ),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            unselectedLabelStyle: FontStyle.fontStyleW400(
              fontSize: 14,
              fontColor: AppColors.tabUnselectText1,
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

class SpecialistDetailTabBarItemView extends StatelessWidget {
  const SpecialistDetailTabBarItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<SpecialistDetailController>(
        id: Constant.idTabBarView,
        builder: (logic) {
          return DefaultTabController(
            length: 6,
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: logic.tabController,
              children: const [
                DetailScreen(),
                AddressScreen(),
                ReviewScreen(),
                EducationScreen(),
                ExperienceScreen(),
                AwardScreen(),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// =================== Tab Bar Items =================== ///

/// Details
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SpecialistDetailController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const DetailAboutView(),
                logic.getDoctorDetailModel?.data?.service?.isEmpty == true
                    ? const SizedBox.shrink()
                    : const DetailServiceView(),
                logic.getDoctorDetailModel?.data?.expertise?.isEmpty == true
                    ? const SizedBox.shrink()
                    : const DetailExpertiseView(),
                const DetailWorkingTimeView(),
                logic.getDoctorDetailModel?.data?.language?.isEmpty == true
                    ? const SizedBox.shrink()
                    : const DetailLanguageView(),
              ],
            ).paddingOnly(bottom: 90),
          );
        },
      ),
    );
  }
}

/// About
class DetailAboutView extends StatelessWidget {
  const DetailAboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAsset.icAboutMe,
                  height: 25,
                  width: 25,
                  color: AppColors.primaryAppColor2,
                ).paddingOnly(right: 8),
                Text(
                  EnumLocale.txtAboutMe.name.tr,
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor2,
                  ),
                )
              ],
            ).paddingOnly(left: 15),
            logic.isLoading
                ? Shimmers.doctorAboutShimmer()
                : Container(
                    width: Get.width,
                    color: AppColors.containerBg,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      logic.getDoctorDetailModel?.data?.yourSelf?.trim() ?? "",
                      style: FontStyle.fontStyleW400(
                        fontSize: 12.5,
                        fontColor: AppColors.degreeText1,
                      ),
                    ),
                  )
          ],
        );
      },
    );
  }
}

/// Service View
class DetailServiceView extends StatelessWidget {
  const DetailServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAsset.icServices,
                  height: 25,
                  width: 25,
                  color: AppColors.primaryAppColor2,
                ).paddingOnly(right: 8),
                Text(
                  EnumLocale.txtServices.name.tr,
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor2,
                  ),
                )
              ],
            ).paddingOnly(left: 15, bottom: 12),
            for (int i = 0;
                i < (logic.getDoctorDetailModel?.data?.service?.length ?? 1);
                i++)
              DetailServiceItemView(index: i),
          ],
        );
      },
    );
  }
}

class DetailServiceItemView extends StatelessWidget {
  final int index;

  const DetailServiceItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.doctorServiceShimmer()
            : Container(
                height: Get.height * 0.063,
                decoration: BoxDecoration(
                  color: index.isOdd
                      ? AppColors.specialistBox2
                      : AppColors.containerBg,
                ),
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Container(
                      height: Get.height * 0.01,
                      width: Get.height * 0.01,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.degreeText1,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      logic.getDoctorDetailModel?.data?.service?[index].name ??
                          "",
                      overflow: TextOverflow.ellipsis,
                      style: FontStyle.fontStyleW400(
                        fontSize: 14,
                        fontColor: AppColors.degreeText1,
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}

/// Expertise View
class DetailExpertiseView extends StatelessWidget {
  const DetailExpertiseView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAsset.icExpertise,
                  height: 25,
                  width: 25,
                  color: AppColors.primaryAppColor2,
                ).paddingOnly(right: 8),
                Text(
                  EnumLocale.txtExpertise.name.tr,
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor2,
                  ),
                )
              ],
            ).paddingOnly(left: 15, top: 12, bottom: 12),
            for (int i = 0;
                i < (logic.getDoctorDetailModel?.data?.expertise?.length ?? 1);
                i++)
              DetailExpertiseItemView(index: i),
          ],
        );
      },
    );
  }
}

class DetailExpertiseItemView extends StatelessWidget {
  final int index;

  const DetailExpertiseItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.doctorServiceShimmer()
            : Container(
                height: Get.height * 0.063,
                decoration: BoxDecoration(
                  color: index.isOdd
                      ? AppColors.specialistBox2
                      : AppColors.containerBg,
                ),
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Container(
                      height: Get.height * 0.01,
                      width: Get.height * 0.01,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.degreeText1,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      logic.getDoctorDetailModel?.data?.expertise?[index]
                              .trim() ??
                          "",
                      overflow: TextOverflow.ellipsis,
                      style: FontStyle.fontStyleW400(
                        fontSize: 14,
                        fontColor: AppColors.degreeText1,
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}

/// Working Time View
class DetailWorkingTimeView extends StatelessWidget {
  const DetailWorkingTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAsset.icWorkingTime,
                  height: 25,
                  width: 25,
                  color: AppColors.primaryAppColor2,
                ).paddingOnly(right: 8),
                Text(
                  EnumLocale.txtWorkingTime.name.tr,
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor2,
                  ),
                )
              ],
            ).paddingOnly(left: 15, top: 12),
            logic.isLoading
                ? Shimmers.doctorServiceShimmer()
                : Container(
                    height: Get.height * 0.063,
                    width: Get.width,
                    color: AppColors.containerBg,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.01,
                          width: Get.height * 0.01,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: AppColors.degreeText1,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          "${logic.getDoctorDetailModel?.data?.schedule?.first.day} - ${logic.getDoctorDetailModel?.data?.schedule?.last.day}, ${logic.getDoctorDetailModel?.data?.schedule?.first.startTime} - ${logic.getDoctorDetailModel?.data?.schedule?.first.endTime}",
                          style: FontStyle.fontStyleW400(
                            fontSize: 14,
                            fontColor: AppColors.degreeText1,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        );
      },
    );
  }
}

/// Language View
class DetailLanguageView extends StatelessWidget {
  const DetailLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAsset.icLanguages,
                  height: 25,
                  width: 25,
                  color: AppColors.primaryAppColor2,
                ).paddingOnly(right: 8),
                Text(
                  EnumLocale.txtLanguages.name.tr,
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor2,
                  ),
                )
              ],
            ).paddingOnly(left: 15, bottom: 12),
            for (int i = 0;
                i < (logic.getDoctorDetailModel?.data?.language?.length ?? 1);
                i++)
              DetailLanguageItemView(index: i),
          ],
        );
      },
    );
  }
}

class DetailLanguageItemView extends StatelessWidget {
  final int index;

  const DetailLanguageItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.doctorServiceShimmer()
            : Container(
                height: Get.height * 0.063,
                decoration: BoxDecoration(
                  color: index.isOdd
                      ? AppColors.specialistBox2
                      : AppColors.containerBg,
                ),
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Container(
                      height: Get.height * 0.01,
                      width: Get.height * 0.01,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.degreeText1,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      logic.getDoctorDetailModel?.data?.language?[index]
                              .trim() ??
                          "",
                      overflow: TextOverflow.ellipsis,
                      style: FontStyle.fontStyleW400(
                        fontSize: 14,
                        fontColor: AppColors.degreeText1,
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}

/// Address
class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset(
                AppAsset.icLocation,
                height: 25,
                width: 25,
                color: AppColors.primaryAppColor2,
              ).paddingOnly(right: 8),
              Text(
                EnumLocale.txtServicesLocation.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor2,
                ),
              )
            ],
          ).paddingOnly(left: 15),
          GetBuilder<SpecialistDetailController>(
            id: Constant.idProgressView,
            builder: (logic) {
              return Container(
                width: Get.width,
                color: AppColors.containerBg,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: Get.height * 0.01,
                          width: Get.height * 0.01,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: AppColors.degreeText1,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          logic.getDoctorDetailModel?.data?.clinicName ?? "",
                          style: FontStyle.fontStyleW400(
                            fontSize: 14,
                            fontColor: AppColors.degreeText1,
                          ),
                        ).paddingOnly(bottom: 3),
                      ],
                    ),
                    Text(
                      logic.getDoctorDetailModel?.data?.address ?? "",
                      style: FontStyle.fontStyleW400(
                        fontSize: 14,
                        fontColor: AppColors.degreeText1,
                      ),
                    ).paddingOnly(left: 18),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

/// Review
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SpecialistDetailController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return SizedBox(
            height: Get.height * 0.175,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    logic.getDoctorDetailModel?.data?.rating
                            ?.toStringAsFixed(1) ??
                        "",
                    style: FontStyle.fontStyleW700(
                      fontSize: 32,
                      fontColor: AppColors.rating,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          AppAsset.icRating,
                          height: Get.height * 0.05,
                        ).paddingOnly(right: 3);
                      },
                    ),
                  ),
                  Text(
                    "(${logic.getDoctorDetailModel?.data?.rating?.toStringAsFixed(1) ?? ""} ${EnumLocale.txtRatings.name.tr})",
                    style: FontStyle.fontStyleW500(
                      fontSize: 14,
                      fontColor: AppColors.degreeText1,
                    ),
                  ).paddingOnly(top: 5),
                  logic.getDoctorDetailModel?.data?.rating == 0.0
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.rating,
                                arguments: [logic.doctorId]);
                          },
                          child: Container(
                            height: Get.height * 0.043,
                            width: Get.width * 0.48,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: AppColors.containerBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    EnumLocale.txtViewMoreDetails.name.tr,
                                    style: FontStyle.fontStyleW600(
                                      fontSize: 14,
                                      fontColor: AppColors.title,
                                    ),
                                  ),
                                  Image.asset(
                                    AppAsset.icArrowUp,
                                    height: Get.height * 0.06,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ).paddingOnly(top: 10);
        },
      ),
    );
  }
}

/// Education
class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SpecialistDetailController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return logic.getDoctorDetailModel?.data?.education?.isEmpty == true
              ? NoDataFound(
                  image: AppAsset.icNoDataFound,
                  imageHeight: 150,
                  text: EnumLocale.noDataFound.name.tr,
                  padding: const EdgeInsets.only(top: 10),
                  textSize: 14,
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: AppColors.containerBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          logic.getDoctorDetailModel?.data?.education?.trim() ??
                              "",
                          style: FontStyle.fontStyleW400(
                            fontSize: 12.5,
                            fontColor: AppColors.degreeText1,
                          ),
                        ).paddingOnly(left: 15, right: 15, top: 5),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}

/// Experience
class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SpecialistDetailController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return logic.getDoctorDetailModel?.data?.experienceDetails?.isEmpty ==
                  true
              ? NoDataFound(
                  image: AppAsset.icNoDataFound,
                  imageHeight: 150,
                  text: EnumLocale.noDataFound.name.tr,
                  padding: const EdgeInsets.only(top: 10),
                  textSize: 14,
                )
              : SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    itemCount: logic
                        .getDoctorDetailModel?.data?.experienceDetails?.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: AppColors.containerBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: Get.height * 0.01,
                              width: Get.height * 0.01,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: AppColors.degreeText1,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              // width: Get.width * 0.83,
                              child: Text(
                                logic.getDoctorDetailModel?.data
                                        ?.experienceDetails?[index]
                                        .trim() ??
                                    "",
                                overflow: TextOverflow.ellipsis,
                                style: FontStyle.fontStyleW400(
                                  fontSize: 12,
                                  fontColor: AppColors.degreeText1,
                                ),
                              ),
                            )
                          ],
                        ).paddingOnly(left: 15, right: 15, bottom: 7),
                      );
                    },
                  ).paddingOnly(top: 12, bottom: 12),
                );
        },
      ),
    );
  }
}

/// Award
class AwardScreen extends StatelessWidget {
  const AwardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SpecialistDetailController>(
        id: Constant.idProgressView,
        builder: (logic) {
          return logic.getDoctorDetailModel?.data?.awards?.isEmpty == true
              ? NoDataFound(
                  image: AppAsset.icNoDataFound,
                  imageHeight: 150,
                  text: EnumLocale.noDataFound.name.tr,
                  padding: const EdgeInsets.only(top: 10),
                  textSize: 14,
                )
              : SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: logic.getDoctorDetailModel?.data?.awards?.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Image.asset(
                            AppAsset.icAward,
                            height: Get.height * 0.025,
                            width: Get.width * 0.072,
                            color: AppColors.degreeText1,
                          ).paddingOnly(bottom: 3),
                          Expanded(
                            child: SizedBox(
                              width: Get.width * 0.85,
                              child: Text(
                                logic.getDoctorDetailModel?.data?.awards?[index]
                                        .trim() ??
                                    "",
                                overflow: TextOverflow.ellipsis,
                                style: FontStyle.fontStyleW400(
                                  fontSize: 12,
                                  fontColor: AppColors.degreeText1,
                                ),
                              ),
                            ),
                          )
                        ],
                      ).paddingOnly(left: 15, right: 15, bottom: 5);
                    },
                  ).paddingOnly(top: 12, bottom: 12),
                );
        },
      ),
    );
  }
}
