import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

/// =================== Current Balance =================== ///

class MyProfileBackgroundView extends StatelessWidget {
  const MyProfileBackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.145,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAsset.profileBackground),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "Hello\n",
              style: FontStyle.fontStyleW500(
                fontSize: 17,
                fontColor: AppColors.black,
              ),
              children: [
                TextSpan(
                  text: "Mr. Rajul Mesvani",
                  style: FontStyle.fontStyleW700(
                    fontSize: 17,
                    fontColor: AppColors.profileTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              EnumLocale.txtEditProfile.name.tr,
              style: FontStyle.fontStyleW500(
                fontSize: 14,
                fontColor: AppColors.black,
              ),
            ),
          ),
        ],
      ).paddingOnly(top: 10.0, left: 10.0),
    );
  }
}

class ViewProfileListViewItems extends StatelessWidget {
   ViewProfileListViewItems({super.key});

  List ViewProfileItems = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Get.height * 0.03,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(

                ),
              );
            }));
  }
}
