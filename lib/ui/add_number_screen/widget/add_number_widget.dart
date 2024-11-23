import 'dart:developer';

import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/add_number_screen/controller/add_number_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// =================== App Bar =================== ///
class AddNumberAppBarView extends StatelessWidget {
  const AddNumberAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtAddNumber.name.tr,
      showLeadingIcon: true,
      gradientColor: [AppColors.appBarBg, AppColors.appBarBg],
      iconColor: AppColors.title,
      textColor: AppColors.title,
    );
  }
}

/// =================== Description =================== ///
class AddNumberDesView extends StatelessWidget {
  const AddNumberDesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.desPleaseFillDetail.name.tr,
      textAlign: TextAlign.center,
      style: FontStyle.fontStyleW400(
        fontSize: 15,
        fontColor: AppColors.registrationDes,
      ),
    ).paddingOnly(bottom: 50);
  }
}

/// =================== Add Number =================== ///
class AddNumberView extends StatelessWidget {
  const AddNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNumberController>(
      builder: (logic) {
        return IntlPhoneField(
          flagsButtonPadding: const EdgeInsets.all(8),
          dropdownIconPosition: IconPosition.trailing,
          controller: logic.numberController,
          onCountryChanged: (value) {
            log("message :: ${value.code}");
            countryCode = value.code;

            getDialCode();
          },
          validator: (value) {
            if (value == null) {
              return EnumLocale.desEnterMobile.name.tr;
            }
            return null;
          },
          obscureText: false,
          style: FontStyle.fontStyleW600(
            fontSize: 15,
            fontColor: AppColors.bottomLabel,
          ),
          cursorColor: AppColors.title,
          dropdownTextStyle: FontStyle.fontStyleW600(
            fontSize: 15,
            fontColor: AppColors.primaryAppColor1,
          ),
          pickerDialogStyle: PickerDialogStyle(
            countryCodeStyle: FontStyle.fontStyleW600(
              fontSize: 13,
              fontColor: AppColors.black,
            ),
            countryNameStyle: FontStyle.fontStyleW600(
              fontSize: 13,
              fontColor: AppColors.title,
            ),
            searchFieldCursorColor: AppColors.title,
            searchFieldInputDecoration: InputDecoration(
              hintStyle: FontStyle.fontStyleW400(
                fontSize: 12,
                fontColor: AppColors.viewMore,
              ),
              hintText: EnumLocale.txtSearchCountryCode.name.tr,
            ),
          ),
          dropdownIcon: Icon(
            Icons.arrow_drop_down_outlined,
            color: AppColors.primaryAppColor1,
          ),
          keyboardType: TextInputType.number,
          showCountryFlag: true,
          decoration: InputDecoration(
            hintStyle: FontStyle.fontStyleW600(
              fontSize: 15,
              fontColor: AppColors.bottomLabel,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.transparent,
              ),
            ),
            filled: true,
            fillColor: AppColors.categoryCircle,
            errorStyle: FontStyle.fontStyleW500(
              fontSize: 10,
              fontColor: AppColors.notificationTitle2,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.notificationTitle2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.notificationTitle2,
              ),
            ),
            counterStyle: FontStyle.fontStyleW400(
              fontSize: 9,
              fontColor: AppColors.loginDes,
            ),
          ),
          initialCountryCode: countryCode,
          onChanged: (phone) {
            log("Phone :: ${phone.completeNumber}");
          },
        );
      },
    );
  }
}

/// =================== Bottom View =================== ///
class AddNumberBottomView extends StatelessWidget {
  const AddNumberBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.085,
      width: Get.width,
      color: AppColors.transparent,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<AddNumberController>(
            id: Constant.idCheckMobile,
            builder: (logic) {
              return PrimaryAppButton(
                onTap: () {
                  logic.onContinueClick();
                  Get.toNamed(
                    AppRoutes.numberOtpVerification,
                    arguments: [
                      logic.numberController.text,
                      dialCode,
                    ],
                  );
                },
                height: Get.height * 0.06,
                width: Get.width * 0.90,
                borderRadius: 11,
                gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                text: EnumLocale.txtContinue.name.tr,
                textStyle: FontStyle.fontStyleW600(
                  fontSize: 16,
                  fontColor: AppColors.white,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
