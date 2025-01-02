import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/ui/rating_screen/controller/rating_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class RatingAppBarView extends StatelessWidget {
  const RatingAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtRatings.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== List View =================== ///
class RatingListView extends StatelessWidget {
  const RatingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return SizedBox(
          child: logic.isLoading
              ? Shimmers.doctorReviewShimmer()
              : logic.getDoctorRatingModel?.data?.isEmpty == true
                  ? NoDataFound(
                      image: AppAsset.icNoReviewFound,
                      imageHeight: 200,
                      text: EnumLocale.noDataFoundReview.name.tr,
                      padding: const EdgeInsets.only(top: 10),
                    ).paddingOnly(bottom: 40)
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: logic.getDoctorRatingModel?.data?.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return RatingListItemView(index: index);
                      },
                    ).paddingOnly(top: 12, bottom: 12),
        );
      },
    );
  }
}

class RatingListItemView extends StatelessWidget {
  final int index;

  const RatingListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        logic.rating = logic.getDoctorRatingModel?.data?[index].rating ?? 0.0;
        logic.roundedRating = logic.rating?.round();
        logic.filledStars = logic.roundedRating?.clamp(0, 5);

        return Container(
          decoration: BoxDecoration(
            color: AppColors.containerBg,
            borderRadius: BorderRadius.circular(20),
            // border: Border.all(
            //   color: AppColors.divider,
            //   width: 1.3,
            // ),
          ),
          margin: const EdgeInsets.only(bottom: 13, left: 15, right: 15),
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.placeholder,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: logic.getDoctorRatingModel?.data?[index].user?.image ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icUserPlaceholder, color: AppColors.user).paddingAll(10);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icUserPlaceholder, color: AppColors.user).paddingAll(10);
                      },
                    ),
                  ).paddingOnly(right: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              logic.getDoctorRatingModel?.data?[index].user?.name ?? "",
                              style: FontStyle.fontStyleW600(
                                fontSize: 15,
                                fontColor: AppColors.title,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.specialistBox,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                child: Text(
                                  logic.getDoctorRatingModel?.data?[index].relativeTime ?? "",
                                  style: FontStyle.fontStyleW500(
                                    fontSize: 11,
                                    fontColor: AppColors.specialist,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              if (index < logic.filledStars!) {
                                return Image.asset(AppAsset.icStarFilled, height: 18, width: 18).paddingOnly(right: 5);
                              } else {
                                return Image.asset(AppAsset.icStarOutline, height: 18, width: 18).paddingOnly(right: 5);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ).paddingOnly(bottom: 8),
              Text(
                logic.getDoctorRatingModel?.data?[index].review ?? "",
                style: FontStyle.fontStyleW400(
                  fontSize: 12,
                  fontColor: AppColors.ratingMessage,
                ),
              ).paddingOnly(bottom: 8)
            ],
          ),
        );
      },
    );
  }
}
