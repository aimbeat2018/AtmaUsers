import 'dart:io';

import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/ui/booking_screen/controller/booking_screen_controller.dart';
import 'package:doctor/ui/booking_screen/widget/booking_screen_widget.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Patient Detail App Bar =================== ///
class PatientDetailAppBarView extends StatelessWidget {
  const PatientDetailAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtAddPatientDetails.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Patient Detail Bottom View =================== ///
class PatientDetailBottomView extends StatelessWidget {
  const PatientDetailBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 8.0,
          ), //BoxShadow
        ],
      ),
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<BookingScreenController>(
            id: Constant.idSelectPatient,
            builder: (logic) {
              return GestureDetector(
                onTap: () {
                  logic.onAddPatient(context);
                },
                child: PrimaryAppButton(
                  height: Get.height * 0.06,
                  width: Get.width * 0.90,
                  borderRadius: 11,
                  gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                  text: EnumLocale.txtSubmitMember.name.tr,
                  textStyle: FontStyle.fontStyleW600(
                    fontSize: 16,
                    fontColor: AppColors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// =================== Patient Detail Upload Image =================== ///
class PatientDetailUploadImageView extends StatelessWidget {
  const PatientDetailUploadImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingScreenController>(
      id: Constant.idPatientImage,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onPickImage();
          },
          child: DottedBorder(
            color: AppColors.border,
            dashPattern: const [3.5, 3.5],
            radius: const Radius.circular(16),
            strokeWidth: 1,
            borderType: BorderType.RRect,
            child: logic.selectImageFile == null
                ? Container(
              height: Get.height * 0.15,
              width: Get.width * 0.3,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAsset.icUploadImage,
                    height: 32,
                    width: 32,
                  ),
                  Text(
                    EnumLocale.txtUploadImage.name.tr,
                    textAlign: TextAlign.center,
                    style: FontStyle.fontStyleW500(
                      fontSize: 11,
                      fontColor: AppColors.border,
                    ),
                  )
                ],
              ),
            )
                : Container(
              height: Get.height * 0.15,
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: FileImage(
                    File(logic.selectImageFile?.path ?? ""),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ).paddingOnly(top: 10, bottom: 20),
        );
      },
    );
  }
}

/// =================== Patient Detail Add Info(TextFormField) =================== ///
class PatientDetailAddInfoView extends StatelessWidget {
  const PatientDetailAddInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    List type = [EnumLocale.txtFemale.name.tr, EnumLocale.txtMale.name.tr];

    return GetBuilder<BookingScreenController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                title: EnumLocale.txtFullName.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.nameController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterFullName.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtAge.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.ageController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  maxLength: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterAge.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 15),
              CustomTitle(
                title: EnumLocale.txtGender.name.tr,
                method: SizedBox(
                  height: Get.height * 0.04,
                  child: ListView.builder(
                    itemCount: type.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DoctorRegistrationClinicTypeView(index: index, type: type);
                    },
                  ),
                ),
              ).paddingOnly(bottom: 15),
              CustomTitle(
                title: EnumLocale.txtRelation.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.relationController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterRelation.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 15),
            ],
          ),
        );
      },
    );
  }
}