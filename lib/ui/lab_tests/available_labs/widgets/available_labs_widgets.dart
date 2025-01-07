import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class LabTestsAppBarView extends StatelessWidget {
  const LabTestsAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtAvailableLabs.name.tr,
      showLeadingIcon: true,
    );
  }
}

class DisplayAndEditAddressView extends StatelessWidget {
  const DisplayAndEditAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 20, top: 10.0, left: 10.0, right: 10.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, top: 12.0, bottom: 12.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.containerBg,
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            Image.asset(
                height: 18,
                AppAsset.icLocationFilled2,
                color: AppColors.primaryAppColor1),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                "1904, Haware Infotech Park, Vashi, Navi Mumbai, Maharashtra, 400703",
                style: FontStyle.fontStyleW400(
                  fontSize: 13,
                  fontColor: AppColors.black,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Image.asset(
                      height: 22,
                      AppAsset.icEditAdd,
                      color: AppColors.primaryAppColor1)
                  .paddingOnly(right: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}

class AvailableLabsItems extends StatelessWidget {
  const AvailableLabsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      shrinkWrap: true,
      itemCount: 2,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6.0 / 9,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryAppColor1,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  height: 120,
                  width: 250,
                  imageUrl: AppAsset.availableLabsImg,
                  // fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Image.asset(AppAsset.availableLabsImg)
                        .paddingAll(10);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppAsset.availableLabsImg)
                        .paddingAll(10);
                  },
                ),
              ),
              Text(
                "Metropolis Healthcare Ltd.",
                style: FontStyle.fontStyleW500(
                  fontSize: 12,
                  fontColor: AppColors.yellowTitle,
                ),
              ).paddingOnly(left:4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    EnumLocale.txtBloodGlucoseTest.name.tr,
                    style: FontStyle.fontStyleW400(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                  Text(
                    "200",
                    style: FontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                ],
              ).paddingOnly(
                left: 4.0, right: 4.0
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    EnumLocale.txtCortisolTest.name.tr,
                    style: FontStyle.fontStyleW400(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                  Text(
                    "200",
                    style: FontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                ],
              ).paddingOnly(
                    left: 4.0, right: 4.0
               ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    EnumLocale.txtTotal.name.tr,
                    style: FontStyle.fontStyleW400(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                  Text(
                    "2148",
                    style: FontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.white,
                    ),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      minimumSize: const Size(20, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const AvailableLabsBottomSheetView();
                      },
                    );
                  },
                  child: Text(
                     '${EnumLocale.txtBookNow.name.tr} ',
                    style: FontStyle.fontStyleW500(
                      fontSize: 12,
                      fontColor: AppColors.primaryAppColor1,
                    ),),
                ),
              ),
            ],
          ),
        );
        // HomeCategoryItemView(index: index);
      },
    );
  }
}

class AvailableLabsBottomSheetView extends StatelessWidget {
  const AvailableLabsBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft:Radius.circular(10.0),
            topRight:Radius.circular(10.0),
        ),
        color: AppColors.containerBg,
      ),
    );
  }
}

