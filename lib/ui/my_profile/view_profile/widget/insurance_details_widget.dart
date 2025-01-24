import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:doctor/utils/font_style.dart';

class InsuranceDetailsWidget extends StatelessWidget {
  const InsuranceDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.containerGrey1,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Insurance Company",
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  "Bajaj Allianz",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top: 10, left: 10, right: 10),
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
                  "5,68,000/-",
                  style: FontStyle.fontStyleW500(
                    fontSize: 14,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top: 10, left: 10, right: 10, bottom: 10),
          ],
        ),
      ),
    );
  }
}
