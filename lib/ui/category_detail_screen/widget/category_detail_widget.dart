// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/category_detail_screen/controller/category_detail_controller.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_model.dart';
import 'package:doctor/ui/home_screen/model/get_all_doctor_service_model.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class CategoryDetailAppBarView extends StatelessWidget {
  const CategoryDetailAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDetailController>(
      builder: (logic) {
        return CustomAppBar(
          title: logic.serviceName.toString(),
          showLeadingIcon: true,
        );
      },
    );
  }
}

/// =================== List View =================== ///
class CategoryDetailListView extends StatelessWidget {
  const CategoryDetailListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDetailController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isAllDoctors == true
            ? logic.getAllDoctors?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDoctorFound,
                    imageHeight: 200,
                    text: EnumLocale.noDataFoundDoctor.name.tr,
                  ).paddingOnly(bottom: Get.height * 0.08)
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: logic.getAllDoctors?.length,
                    itemBuilder: (context, index) {
                      return CategoryDetailListItemView(
                        getAllDoctors: logic.getAllDoctors?[index],
                        isAllDoctor: true,
                      );
                    },
                  ).paddingOnly(top: 15)
            : logic.categoryDoctorList?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDoctorFound,
                    imageHeight: 200,
                    text: EnumLocale.noDataFoundDoctor.name.tr,
                  ).paddingOnly(bottom: Get.height * 0.08)
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: logic.categoryDoctorList?.length,
                    itemBuilder: (context, index) {
                      return CategoryDetailListItemView(
                        doctors: logic.categoryDoctorList?[index],
                        isAllDoctor: false,
                      );
                    },
                  ).paddingOnly(top: 15);
      },
    );
  }
}

class CategoryDetailListItemView extends StatelessWidget {
  Doctors? doctors;
  GetAllDoctors? getAllDoctors;
  final bool isAllDoctor;

  CategoryDetailListItemView({super.key, this.doctors, this.getAllDoctors, required this.isAllDoctor});

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDetailController>(
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
                  );
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
                                width: Get.width * 0.58,
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.divider,
                                    width: 1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.6,
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
                      ),
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
                      logic.serviceId ?? "",
                    ],
                  );
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
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                              Text(
                                doctors?.degree?.join(", ") ?? "",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13.5,
                                  fontColor: AppColors.primaryAppColorTitle,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.58,
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.divider1,
                                    width: 0.50,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.6,
                                child: Text(
                                  '${doctors?.designation} | ${doctors?.clinicName}',
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
