// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/search_screen/controller/search_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List genderList = ["Female", "Male", "Both"];
List sortBy = [(EnumLocale.txtLow.name.tr), (EnumLocale.txtMedium.name.tr), (EnumLocale.txtHigh.name.tr)];
List location = [(EnumLocale.txtNearbyMe.name.tr), "5km", "10km", "15km"];

/// =================== Top Search Bar =================== ///
class SearchTopBarView extends StatelessWidget {
  const SearchTopBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<SearchScreenController>(
          builder: (logic) {
            return GestureDetector(
              onTap: () {
                Get.back();
                logic.searchDoctorByName(text: "");
              },
              child: Image.asset(
                AppAsset.icArrowRight,
                height: Get.height * 0.065,
                width: Get.width * 0.065,
                color: AppColors.title,
              ).paddingAll(10),
            );
          },
        ),
        Expanded(
          child: GetBuilder<SearchScreenController>(
            builder: (logic) {
              return CustomTextField(
                onChanged: (text) {
                  logic.searchDoctorByName(text: text ?? "");
                  return null;
                },
                hintText: EnumLocale.txtSearchDoctor.name.tr,
                controller: logic.searchController,
                fillColor: AppColors.categoryCircle,
                hintTextSize: 13,
                hintTextColor: AppColors.textFormHintText,
                filled: true,
                textInputAction: TextInputAction.done,
                prefixIcon: Image.asset(
                  AppAsset.icSearch,
                  height: 10,
                  width: 10,
                ).paddingAll(12),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                suffixIcon: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const FilterBottomSheet();
                      },
                    );
                  },
                  child: Image.asset(
                    AppAsset.icCategory,
                    height: 10,
                    width: 10,
                  ).paddingAll(12),
                ),
              ).paddingOnly(right: 10, top: 10, bottom: 10);
            },
          ),
        ),
      ],
    );
  }
}

/// =================== List View =================== ///
class SearchListView extends StatelessWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeTabBarShimmer()
            : logic.searchController.text.isEmpty || logic.getFilteredDoctorModel?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDoctorFound,
                    imageHeight: 200,
                    text: EnumLocale.noDataFound.name.tr,
                  ).paddingOnly(top: Get.height * 0.25)
                : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: logic.getFilteredDoctorModel?.data?.length,
                      itemBuilder: (context, index) {
                        return SearchListItemView(index: index);
                      },
                    ),
                  );
      },
    );
  }
}

class SearchListItemView extends StatelessWidget {
  final int index;

  const SearchListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.specialistDetail,
              arguments: [
                logic.getFilteredDoctorModel?.data?[index].id,
                logic.getFilteredDoctorModel?.data?[index].service?.first.id,
              ],
            );
          },
          child: Container(
            height: Get.height * 0.14,
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
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.transparent,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: logic.getFilteredDoctorModel?.data?[index].image ?? "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                            },
                            errorWidget: (context, url, error) {
                              return Image.asset(AppAsset.icDoctorPlaceholder).paddingAll(10);
                            },
                          ),
                        ),
                      ),
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
                                  logic.getFilteredDoctorModel?.data?[index].name ?? "",
                                  style: FontStyle.fontStyleW600(
                                    fontSize: 16,
                                    fontColor: AppColors.title,
                                  ),
                                ),
                                Container(
                                  height: Get.height * 0.037,
                                  width: Get.width * 0.16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: AppColors.ratingCircle,
                                  ),
                                  padding: const EdgeInsets.only(left: 7, right: 7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        AppAsset.icRating,
                                        height: 18,
                                        width: 18,
                                      ),
                                      Text(
                                        logic.getFilteredDoctorModel?.data?[index].rating?.toStringAsFixed(1) ?? "",
                                        style: FontStyle.fontStyleW600(
                                          fontSize: 13,
                                          fontColor: AppColors.rating,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(color: AppColors.specialistBox, borderRadius: BorderRadius.circular(4)),
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                child: Text(
                                  logic.getFilteredDoctorModel?.data?[index].designation ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 11,
                                    fontColor: AppColors.specialist,
                                  ),
                                ),
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
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '${EnumLocale.txtExperience.name.tr} ',
                                    style: FontStyle.fontStyleW400(
                                      fontSize: 12.5,
                                      fontColor: AppColors.degreeText,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${logic.getFilteredDoctorModel?.data?[index].experience} Years',
                                        style: FontStyle.fontStyleW600(
                                          fontSize: 13,
                                          fontColor: AppColors.title,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '  |  ',
                                        style: FontStyle.fontStyleW400(
                                          fontSize: 13,
                                          fontColor: AppColors.degreeText,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${EnumLocale.txtFees.name.tr} ',
                                        style: FontStyle.fontStyleW400(
                                          fontSize: 12.5,
                                          fontColor: AppColors.degreeText,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '$currency ${logic.getFilteredDoctorModel?.data?[index].charge}',
                                        style: FontStyle.fontStyleW600(
                                          fontSize: 13,
                                          fontColor: AppColors.title,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
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

/// =================== Bottom Sheet =================== ///
class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.55,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: AppColors.white,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterBottomTitleView(),
          FilterBottomGenderListView(),
          FilterBottomRatingGridView(),
          FilterBottomSortListView(),
          Spacer(),
          FilterBottomButtonView(),
        ],
      ),
    );
  }
}

/// Bottom Sheet Items......

/// =================== Bottom Sheet Title =================== ///
class FilterBottomTitleView extends StatelessWidget {
  const FilterBottomTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              EnumLocale.txtApplyFilters.name.tr,
              style: FontStyle.fontStyleW600(
                fontSize: 18,
                fontColor: AppColors.title,
              ),
            ).paddingOnly(left: 20),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppAsset.icClose,
                height: Get.height * 0.07,
                width: Get.width * 0.07,
              ).paddingOnly(right: 15),
            )
          ],
        ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.bottomSheetDivider,
              width: 1,
            ),
          ),
        ),
      ],
    );
  }
}

/// =================== Bottom Sheet Select Gender =================== ///
class FilterBottomGenderListView extends StatelessWidget {
  const FilterBottomGenderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtGender.name.tr,
          style: FontStyle.fontStyleW500(
            fontSize: 15,
            fontColor: AppColors.degreeText,
          ),
        ).paddingOnly(left: 15, top: 10, bottom: 13),
        SizedBox(
          height: Get.height * 0.05,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idGenderSelect,
            builder: (logic) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: genderList.length,
                itemBuilder: (context, index) {
                  return FilterBottomGenderListItemView(index: index);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomGenderListItemView extends StatelessWidget {
  final int index;

  const FilterBottomGenderListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idGenderSelect,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onGenderSelect(index);
          },
          child: Container(
            width: Get.width * 0.262,
            margin: const EdgeInsets.only(right: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: logic.genderSelect == index ? AppColors.primaryAppColor1 : AppColors.border,
                width: 1,
              ),
              gradient: logic.genderSelect == index
                  ? LinearGradient(
                      colors: [
                        AppColors.primaryAppColor1,
                        AppColors.primaryAppColor2,
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.white,
                        AppColors.white,
                      ],
                    ),
            ),
            child: Center(
              child: Text(
                genderList[index],
                style: FontStyle.fontStyleW500(
                  fontSize: 14,
                  fontColor: logic.genderSelect == index ? AppColors.white : AppColors.tabUnselectText,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Select Rating =================== ///
class FilterBottomRatingGridView extends StatelessWidget {
  const FilterBottomRatingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtRatings.name.tr,
          style: FontStyle.fontStyleW500(
            fontSize: 15,
            fontColor: AppColors.degreeText,
          ),
        ).paddingOnly(left: 15, top: 15, bottom: 10),
        SizedBox(
          height: Get.height * 0.12,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idRatingSelect,
            builder: (logic) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: logic.ratings.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2.1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return FilterBottomRatingGridItemView(index: index);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomRatingGridItemView extends StatelessWidget {
  final int index;

  const FilterBottomRatingGridItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idRatingSelect,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onRatingSelect(index);
          },
          child: Container(
            width: Get.width * 0.26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: logic.ratingSelect == index ? AppColors.primaryAppColor1 : AppColors.border,
                width: 1.1,
              ),
              gradient: logic.ratingSelect == index
                  ? LinearGradient(
                      colors: [
                        AppColors.primaryAppColor1,
                        AppColors.primaryAppColor2,
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.white,
                        AppColors.white,
                      ],
                    ),
            ),
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAsset.icStarFilled,
                  height: 18,
                  width: 18,
                  color: logic.ratingSelect == index ? AppColors.white : AppColors.tabUnselectText,
                ).paddingOnly(right: 8),
                Text(
                  logic.ratings[index],
                  overflow: TextOverflow.ellipsis,
                  style: FontStyle.fontStyleW600(
                    fontSize: 13,
                    fontColor: logic.ratingSelect == index ? AppColors.white : AppColors.tabUnselectText,
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

/// =================== Bottom Sheet Sorting fees =================== ///
class FilterBottomSortListView extends StatelessWidget {
  const FilterBottomSortListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtConsultationFees.name.tr,
          style: FontStyle.fontStyleW500(
            fontSize: 15,
            fontColor: AppColors.degreeText,
          ),
        ).paddingOnly(left: 15, top: 6, bottom: 15),
        SizedBox(
          height: Get.height * 0.05,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idSelectSortBy,
            builder: (logic) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: sortBy.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return FilterBottomSortListItemView(index: index);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomSortListItemView extends StatelessWidget {
  final int index;

  const FilterBottomSortListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idSelectSortBy,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onSelectFees(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            margin: const EdgeInsets.only(right: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: logic.selectFeesIndex == index ? AppColors.primaryAppColor1 : AppColors.border,
                width: 1,
              ),
              gradient: logic.selectFeesIndex == index
                  ? LinearGradient(
                      colors: [
                        AppColors.primaryAppColor1,
                        AppColors.primaryAppColor2,
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.white,
                        AppColors.white,
                      ],
                    ),
            ),
            child: Center(
              child: Text(
                sortBy[index],
                style: FontStyle.fontStyleW600(
                  fontSize: 14,
                  fontColor: logic.selectFeesIndex == index ? AppColors.white : AppColors.tabUnselectText,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Location =================== ///
class FilterBottomLocationListView extends StatelessWidget {
  const FilterBottomLocationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtLocation.name.tr,
          style: FontStyle.fontStyleW500(
            fontSize: 15,
            fontColor: AppColors.degreeText,
          ),
        ).paddingOnly(left: 15, top: 15, bottom: 15),
        GetBuilder<SearchScreenController>(
          id: Constant.idSelectLocation,
          builder: (logic) {
            return SingleChildScrollView(
              child: Wrap(
                spacing: 5,
                alignment: WrapAlignment.start,
                children: [
                  for (int index = 0; index < location.length; index++) FilterBottomLocationListItemView(index: index),
                ],
              ),
            );
          },
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomLocationListItemView extends StatelessWidget {
  final int index;

  const FilterBottomLocationListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idSelectLocation,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onLocationSelect(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: const EdgeInsets.only(right: 13, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: logic.locationSelect == index ? AppColors.primaryAppColor1 : AppColors.border,
                width: 1,
              ),
              gradient: logic.locationSelect == index
                  ? LinearGradient(
                      colors: [
                        AppColors.primaryAppColor1,
                        AppColors.primaryAppColor2,
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.white,
                        AppColors.white,
                      ],
                    ),
            ),
            child: Text(
              location[index],
              style: FontStyle.fontStyleW600(
                fontSize: 14,
                fontColor: logic.locationSelect == index ? AppColors.white : AppColors.tabUnselectText,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Button =================== ///
class FilterBottomButtonView extends StatelessWidget {
  const FilterBottomButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () async {
            Get.back();

            logic.searchDoctorByName(text: logic.searchController.text);
          },
          height: Get.height * 0.06,
          width: Get.width,
          gradientColor: [
            AppColors.primaryAppColor1,
            AppColors.primaryAppColor2,
          ],
          borderRadius: 12,
          text: EnumLocale.txtApplyNow.name.tr,
          textStyle: FontStyle.fontStyleW600(
            fontSize: 15,
            fontColor: AppColors.white,
          ),
        ).paddingOnly(bottom: Platform.isAndroid?15:25, left: 20, right: 20);
      },
    );
  }
}
