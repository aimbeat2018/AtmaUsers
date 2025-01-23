import 'dart:io';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/my_profile/widget/my_profile_widget.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/circle.dart';
import 'package:doctor/utils/separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class InsuranceDetailsScreen extends StatefulWidget {
  const InsuranceDetailsScreen({super.key});

  @override
  State<InsuranceDetailsScreen> createState() => _InsuranceDetailsScreenState();
}

class _InsuranceDetailsScreenState extends State<InsuranceDetailsScreen> {
  final TextEditingController insuranceCompanyController =
      TextEditingController();

  final TextEditingController totalAmountCoveredController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyProfileAppBarView(),
      ),
      // bottomNavigationBar: Row(
      //   children: [
      //     Expanded(
      //       child: PrimaryAppButton(
      //         onTap: () {
      //           print("gg");
      //           Get.toNamed(AppRoutes.uploadDocument);
      //
      //         },
      //         height: Get.height * 0.06,
      //         width: Get.width,
      //         gradientColor: [
      //           AppColors.buttonBack,
      //           AppColors.buttonBack,
      //         ],
      //         borderRadius: 12,
      //         text: "Save",
      //         textStyle: FontStyle.fontStyleW600(
      //           fontSize: 15,
      //           fontColor: AppColors.white,
      //         ),
      //       ).paddingOnly(bottom: Platform.isAndroid?20:25, left: 10, right: 10, top:20),
      //     ),
      //     Expanded(
      //       child: PrimaryAppButton(
      //         onTap: () {
      //         },
      //         height: Get.height * 0.06,
      //         width: Get.width,
      //         gradientColor: [
      //           AppColors.primaryAppColor1,
      //           AppColors.primaryAppColor2,
      //         ],
      //         borderRadius: 12,
      //         text: "Next",
      //         textStyle: FontStyle.fontStyleW600(
      //           fontSize: 15,
      //           fontColor: AppColors.white,
      //         ),
      //       ).paddingOnly(bottom: Platform.isAndroid?20:25, left: 10, right: 10, top:20),
      //     ),
      //
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                FilledCircle(),
                SizedBox(width: 2),
                const Expanded(child: MySeparator()),
                SizedBox(width: 2),
                FilledCircle(),
                SizedBox(width: 2),
                const Expanded(child: MySeparator()),
                SizedBox(width: 2),
                FilledCircle(),
                SizedBox(width: 2),
                const Expanded(child: MySeparator()),
                SizedBox(width: 2),
                CircleWithBorder(),
              ],
            ).paddingOnly(top: 20, left: 10, right: 10),
            AddressCustomTitle(
              title: "Medical Other History",
              method: CustomTextField(
                controller: insuranceCompanyController,
                filled: true,
                fillColor: AppColors.appBarBg,
                cursorColor: AppColors.title,
                fontColor: AppColors.title,
                fontSize: 15,
                textInputAction: TextInputAction.next,
                inputFormatters: [UpperCaseTextFormatter()],
              ),
            ).paddingOnly(bottom: 20, top: 20),
            AddressCustomTitle(
              title: "Total Amount Covered",
              method: CustomTextField(
                controller: totalAmountCoveredController,
                filled: true,
                fillColor: AppColors.appBarBg,
                cursorColor: AppColors.title,
                fontColor: AppColors.title,
                fontSize: 15,
                textInputAction: TextInputAction.next,
                inputFormatters: [UpperCaseTextFormatter()],
                textInputType: TextInputType.number,
              ),
            ).paddingOnly(bottom: 20),
            Row(
              children: [
                Expanded(
                  child: PrimaryAppButton(
                    onTap: () {},
                    height: Get.height * 0.06,
                    width: Get.width,
                    gradientColor: [
                      AppColors.buttonBack,
                      AppColors.buttonBack,
                    ],
                    borderRadius: 12,
                    text: "Save",
                    textStyle: FontStyle.fontStyleW600(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(
                      bottom: Platform.isAndroid ? 20 : 25,
                      left: 10,
                      right: 10,
                      top: 20),
                ),
                Expanded(
                  child: PrimaryAppButton(
                    onTap: () {
                      print("gg");
                      Get.toNamed(AppRoutes.uploadDocument);
                    },
                    height: Get.height * 0.06,
                    width: Get.width,
                    gradientColor: [
                      AppColors.primaryAppColor1,
                      AppColors.primaryAppColor2,
                    ],
                    borderRadius: 12,
                    text: "Next",
                    textStyle: FontStyle.fontStyleW600(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(
                      bottom: Platform.isAndroid ? 20 : 25,
                      left: 10,
                      right: 10,
                      top: 20),
                ),
              ],
            ),
          ],
        ).paddingOnly(left: 13, right: 13),
      ),
    );
  }
}
