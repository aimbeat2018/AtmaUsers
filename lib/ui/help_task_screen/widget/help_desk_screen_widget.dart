import 'dart:io';

import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/help_task_screen/controller/help_desk_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpDeskAppBarView extends StatelessWidget {
  const HelpDeskAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtHelpDesk.name.tr,
      showLeadingIcon: true,
      action: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.helpDeskHistory);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Image.asset(AppAsset.icHistory, color: AppColors.primaryAppColor1).paddingAll(8),
          ).paddingOnly(right: 12),
        )
      ],
    );
  }
}

class HelpDeskAddDateView extends StatelessWidget {
  const HelpDeskAddDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idSelectType,
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                title: EnumLocale.txtSelectDesk.name.tr,
                method: SizedBox(
                  height: Get.height * 0.04,
                  child: ListView.builder(
                    itemCount: logic.type.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HelpDeskTypeView(index: index);
                    },
                  ),
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtComplainSuggestion.name.tr,
                method: CustomTextField(
                  controller: logic.suggestionController,
                  filled: true,
                  maxLines: 8,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  textStyle: FontStyle.fontStyleW400(
                    fontSize: 15,
                    fontColor: AppColors.title,
                  ),
                  textInputAction: TextInputAction.newline,
                  hintText: EnumLocale.txtTypeSomething.name.tr,
                  hintTextSize: 14,
                  hintTextColor: AppColors.ratingMessage,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterSuggestion.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
              logic.selectedType == 1
                  ? const SizedBox()
                  : CustomTitle(
                      title: EnumLocale.txtAppointmentID.name.tr,
                      method: CustomTextField(
                        controller: logic.appointmentIdController,
                        filled: true,
                        fillColor: AppColors.categoryCircle,
                        cursorColor: AppColors.title,
                        textStyle: FontStyle.fontStyleW400(
                          fontSize: 15,
                          fontColor: AppColors.title,
                        ),
                        textInputAction: TextInputAction.newline,
                        hintText: EnumLocale.txtEnterAppointmentId.name.tr,
                        hintTextSize: 14,
                        hintTextColor: AppColors.ratingMessage,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return EnumLocale.desEnterAppointmentId.name.tr;
                          }
                          return null;
                        },
                      ),
                    ).paddingOnly(bottom: 20)
            ],
          ).paddingOnly(top: 15, left: 15, right: 15),
        );
      },
    );
  }
}

/// =================== Type Item View=================== ///
class HelpDeskTypeView extends StatelessWidget {
  final int index;

  const HelpDeskTypeView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idSelectType,
      builder: (logic) {
        return InkWell(
          onTap: () {
            logic.onSelectType(index);
          },
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.035,
                width: Get.height * 0.035,
                decoration: BoxDecoration(
                  color: AppColors.categoryCircle,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: logic.selectedType == index ? AppColors.primaryAppColor1 : AppColors.typeSelect,
                    width: 1.2,
                  ),
                ),
                child: logic.selectedType == index ? Image.asset(AppAsset.icCheck, color: AppColors.primaryAppColor1).paddingAll(7) : const SizedBox(),
              ),
              Text(
                logic.type[index],
                style: FontStyle.fontStyleW600(
                  fontSize: 15,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ).paddingOnly(left: 8)
            ],
          ).paddingOnly(right: 30, left: 5),
        );
      },
    );
  }
}

class HelpDeskAddImageview extends StatelessWidget {
  const HelpDeskAddImageview({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idComplainImage,
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(
              title: EnumLocale.txtAttachImage.name.tr,
              method: GestureDetector(
                onTap: () {
                  logic.onPickImage();
                },
                child: DottedBorder(
                  color: AppColors.complainBoxBorder,
                  dashPattern: const [3.5, 3.5],
                  radius: const Radius.circular(38),
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      color: AppColors.placeholder,
                    ),
                    child: Row(
                      children: [
                        Image.asset(AppAsset.icClipImage, height: 25, color: AppColors.primaryAppColor1),
                        VerticalDivider(
                          thickness: 1.5,
                          color: AppColors.verticalBorder,
                          endIndent: 10,
                          indent: 10,
                        ).paddingOnly(left: 7, right: 7),
                        Text(
                          EnumLocale.txtBrowse.name.tr,
                          style: FontStyle.fontStyleW500(
                            fontSize: 14,
                            fontColor: AppColors.primaryAppColor1,
                          ),
                        )
                      ],
                    ).paddingOnly(left: 10),
                  ),
                ),
              ),
            ).paddingOnly(left: 15, right: 15),
            logic.selectImageFile != null ? const HelpDeskShowImageView() : const SizedBox(),
          ],
        );
      },
    );
  }
}

class HelpDeskShowImageView extends StatelessWidget {
  const HelpDeskShowImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idComplainImage,
      builder: (logic) {
        return Container(
          height: Get.height * 0.18,
          width: Get.width * 0.36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: FileImage(
                File(logic.selectImageFile?.path ?? ""),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ).paddingOnly(top: 15, left: 15);
      },
    );
  }
}

/// =================== Help Desk Button =================== ///
class HelpDeskButtonView extends StatelessWidget {
  const HelpDeskButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onSubmitClick(context);
          },
          height: Get.height * 0.065,
          width: Get.width,
          borderRadius: 10,
          text: EnumLocale.txtSubmit.name.tr,
          textStyle: FontStyle.fontStyleW600(
            fontSize: 16,
            fontColor: AppColors.white,
          ),
          gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
        ).paddingOnly(left: 12, right: 12, bottom: 10);
      },
    );
  }
}
