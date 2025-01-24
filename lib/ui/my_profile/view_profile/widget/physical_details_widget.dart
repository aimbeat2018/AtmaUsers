import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:doctor/utils/font_style.dart';

class PhysicalDetailsWidget extends StatelessWidget {
   const PhysicalDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.containerGrey1,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Weight",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "60 kg",
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
                  "Height",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "5.6 Ft",
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
                  "Medical History",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "Male",
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
                  "Medical Other History",
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
                  "Medical History Details",
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
                  "Taking Medications",
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
                  "Recent Exacerbation",
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
                  "Surgical History",
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
                  "Anaesthesia History",
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
                  "Allergy",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Addictions",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Family History",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Other Significant History",
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
