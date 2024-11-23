import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/home_screen/controller/home_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class CategoryAppBarView extends StatelessWidget {
  const CategoryAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtCategories.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Grid View =================== ///
class CategoryGridView extends StatelessWidget {
  const CategoryGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (logic) {
        return GridView.builder(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: logic.addData?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.72,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return CategoryGridItemView(index: index);
          },
        ).paddingOnly(left: 11, right: 11, top: 25);
      },
    );
  }
}

class CategoryGridItemView extends StatelessWidget {
  final int index;

  const CategoryGridItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
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
                  getFilteredDoctorModel: logic.getAllDoctorServiceModel, serviceId: logic.addData?[index].id);

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
          },
          child: SizedBox(
            height: Get.height * 0.15,
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
                    imageUrl: logic.addData?[index].image ?? "",
                    // fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(AppAsset.icCategoryPlaceholder).paddingAll(10);
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(AppAsset.icCategoryPlaceholder).paddingAll(10);
                    },
                  ),
                ).paddingOnly(bottom: 10),
                Text(
                  logic.addData?[index].name ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: FontStyle.fontStyleW500(
                    fontSize: 13,
                    fontColor: AppColors.categoryText,
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
