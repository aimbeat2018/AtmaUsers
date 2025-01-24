import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor/ui/saved_doctor_screen/controller/saved_doctor_controller.dart';

/// =================== App Bar =================== ///
class SavedDoctorAppBarView extends StatelessWidget {
  const SavedDoctorAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtSavedDoctor.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== List View =================== ///
class SavedDoctorListView extends StatelessWidget {
  const SavedDoctorListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedDoctorController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeTabBarShimmer()
            : logic.getAllSavedDoctorModel?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDoctorFound,
                    imageHeight: 200,
                    text: EnumLocale.noDataFound.name.tr,
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: logic.getAllSavedDoctorModel?.data?.length,
                    itemBuilder: (context, index) {
                      return SavedDoctorListItemView(
                        index: index,
                      );
                    },
                  ).paddingOnly(top: 10);
      },
    );
  }
}

class SavedDoctorListItemView extends StatelessWidget {
  final int index;

  const SavedDoctorListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedDoctorController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.specialistDetail,
              arguments: [
                logic.getAllSavedDoctorModel?.data?[index].id,
                logic.getAllSavedDoctorModel?.data?[index].service?.first,
              ],
            );
          },
          child: Container(
            height: Get.height * 0.17,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.divider,
                width: 1.2,
              ),
            ),
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.13,
                        width: Get.width * 0.26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.placeholder,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: logic
                                  .getAllSavedDoctorModel?.data?[index].image ??
                              "",
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
                      ).paddingOnly(top: 9),
                      SizedBox(width: Get.width * 0.02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  logic.getAllSavedDoctorModel?.data?[index]
                                          .name ??
                                      "",
                                  style: FontStyle.fontStyleW600(
                                    fontSize: 15.5,
                                    fontColor: AppColors.title,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    logic.onRemoveSavedDoctor(index);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.categoryCircle,
                                    ),
                                    child: Image.asset(AppAsset.icSaveFilled),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              logic.getAllSavedDoctorModel?.data?[index].degree
                                      ?.join(", ") ??
                                  "",
                              style: FontStyle.fontStyleW500(
                                fontSize: 13,
                                fontColor: AppColors.degreeText,
                              ),
                            ),
                            Container(
                              width: Get.width * 0.58,
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.divider,
                                  width: 1.2,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.6,
                              child: Text(
                                '${logic.getAllSavedDoctorModel?.data?[index].designation} | ${logic.getAllSavedDoctorModel?.data?[index].clinicName}',
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
                                  width: 20,
                                ),
                                Text(
                                  '  ${logic.getAllSavedDoctorModel?.data?[index].rating?.toStringAsFixed(1)} ${EnumLocale.txtReviews.name.tr}',
                                  style: FontStyle.fontStyleW600(
                                    fontSize: 12,
                                    fontColor: AppColors.rating,
                                  ),
                                ),
                              ],
                            ).paddingOnly(top: 8)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
