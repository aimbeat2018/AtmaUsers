// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_service_model.dart';
import 'package:doctor/ui/search_screen/controller/search_screen_controller.dart';
import 'package:doctor/ui/top_specialist_screen/controller/top_specialist_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class TopSpecialistAppBarView extends StatelessWidget {
  TopSpecialistAppBarView({super.key});

  SearchScreenController searchScreenController = Get.find<SearchScreenController>();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtSpecialistDoctors.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Tab Bar =================== ///
class TopSpecialistTabBarView extends StatelessWidget {
  const TopSpecialistTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopSpecialistController>(
      id: Constant.idTabBar,
      builder: (logic) {
        return DefaultTabController(
          length: logic.category?.length ?? 0,
          child: TabBar(
            controller: logic.tabController,
            tabs: logic.category?.map<Tab>((category) {
                  return Tab(
                    text: category.name.toString().capitalizeFirst,
                  );
                }).toList() ??
                [],
            labelStyle: FontStyle.fontStyleW500(
              fontSize: 13,
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
              fontSize: 13,
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

class TopSpecialistTabBarItemView extends StatelessWidget {
  const TopSpecialistTabBarItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<TopSpecialistController>(
        id: Constant.idTabBarView,
        builder: (logic) {
          return DefaultTabController(
            length: logic.category?.length ?? 0,
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: logic.tabController,
              children: List.generate(
                (logic.category?.length ?? 0),
                (index) => const TopSpecialistListView(),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// =================== Specialist Listview =================== ///
class TopSpecialistListView extends StatelessWidget {
  const TopSpecialistListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopSpecialistController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeTabBarShimmer()
            : logic.tabController?.index == 0
                ? logic.getAllDoctorList?.isEmpty == true
                    ? NoDataFound(
                        image: AppAsset.icNoDoctorFound,
                        imageHeight: 200,
                        text: EnumLocale.noDataFoundDoctor.name.tr,
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: logic.getAllDoctorList?.length,
                        itemBuilder: (context, index) {
                          return TopSpecialistListItemView(
                            getAllDoctors: logic.getAllDoctorList?[index],
                            isAllDoctor: true,
                          );
                        },
                      )
                : logic.doctorList?.isEmpty == true
                    ? NoDataFound(
                        image: AppAsset.icNoDoctorFound,
                        imageHeight: 200,
                        text: EnumLocale.noDataFoundDoctor.name.tr,
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: logic.doctorList?.length,
                        itemBuilder: (context, index) {
                          return TopSpecialistListItemView(
                            doctors: logic.doctorList?[index],
                            isAllDoctor: false,
                          );
                        },
                      );
      },
    );
  }
}

class TopSpecialistListItemView extends StatelessWidget {
  Doctors? doctors;
  GetAllDoctors? getAllDoctors;
  final bool isAllDoctor;

  TopSpecialistListItemView({super.key, this.doctors, this.getAllDoctors, required this.isAllDoctor});

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopSpecialistController>(
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
                    await homeScreenController.onGetDoctorsServiceWiseApiCall(
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
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
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
                                  fontColor: AppColors.title,
                                ),
                              ),
                              Text(
                                getAllDoctors?.degree?.join(", ") ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13.5,
                                  fontColor: AppColors.degreeText,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.56,
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
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
                                  '${getAllDoctors?.designation} | ${getAllDoctors?.clinicName}',
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
                          await homeScreenController.onGetSavedDoctorApiCall(
                            userId: Constant.storage.read("userId"),
                            doctorId: getAllDoctors?.id ?? "",
                          );

                          homeScreenController.onSavedClick(isAllDoctor: true);
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
                      logic.category?[logic.tabController?.index ?? 0].id,
                    ],
                  )?.then((value) async {
                    await homeScreenController.onGetDoctorsServiceWiseApiCall(
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
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
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
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
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
                          await homeScreenController.onGetSavedDoctorApiCall(
                            userId: Constant.storage.read("userId"),
                            doctorId: getAllDoctors?.id ?? "",
                          );

                          homeScreenController.onSavedClick(isAllDoctor: true);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.categoryCircle,
                          ),
                          child:
                              doctors?.isSaved == true ? Image.asset(AppAsset.icSaveFilled) : Image.asset(AppAsset.icSaveOutline),
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
