import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class PersonalDetailsWidget extends StatelessWidget {
  PersonalDetailsWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.containerGrey1,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "First Name",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "abc",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Last Name",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "xyz",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gender",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "female",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date of Birth",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "1-Jan-1094",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Blood Group",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "A+",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Education",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "Masters in BA",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Religion",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "Hindu",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Occupation",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "Businessman",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Aadhaar No.",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "1234-6178-8290",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Emergency Contact",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "0",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top:10, left:10, right: 10, bottom: 10),
          ],
        ),
      ),
    );
  }
}
