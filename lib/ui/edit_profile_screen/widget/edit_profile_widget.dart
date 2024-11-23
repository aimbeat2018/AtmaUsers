// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:country_picker/country_picker.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/ui/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// =================== App Bar =================== ///
class EditProfileAppBarView extends StatelessWidget {
  const EditProfileAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtEditProfile.name.tr,
      showLeadingIcon: Constant.storage.read("isMobileLogin") == true ? false : true,
    );
  }
}

/// =================== Add Image =================== ///
class EditProfileImageView extends StatelessWidget {
  EditProfileImageView({super.key});

  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: Constant.idEditImage,
      builder: (logic) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            CircleAvatar(
              radius: 62.5,
              backgroundColor: AppColors.bottomLabel,
              child: Container(
                height: 120,
                width: 120,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.categoryCircle,
                ),
                child: logic.image?.path == null
                    ? Image.network(
                        profileScreenController.getUserProfileModel?.user?.image ?? "${ApiConstant.BASE_URL}storage/male.png",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.placeholder,
                          ),
                          child: Image.asset(AppAsset.icUserPlaceholder).paddingAll(20),
                        ),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(
                          File(logic.selectImageFile?.path ?? '${ApiConstant.BASE_URL}storage/male.png'),
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: -43,
              child: GestureDetector(
                onTap: () {
                  logic.onPickImage();
                },
                child: Container(
                  height: Get.height * 0.11,
                  width: Get.width * 0.11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bottomLabel,
                    border: Border.all(
                      width: 2,
                      color: AppColors.white,
                    ),
                  ),
                  child: Image.asset(AppAsset.icCamera).paddingAll(10.5),
                ),
              ),
            ),
          ],
        ).paddingOnly(top: 20, bottom: 30);
      },
    );
  }
}

/// =================== Edit Info(TextField) =================== ///
class EditProfileAddDataView extends StatelessWidget {
  const EditProfileAddDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: Constant.idGetEditProfileData,
      builder: (logic) {
        return Column(
          children: [
            CustomTitle(
              title: EnumLocale.txtFullName.name.tr,
              method: CustomTextField(
                controller: logic.nameController,
                filled: true,
                fillColor: AppColors.categoryCircle,
                cursorColor: AppColors.title,
                fontColor: AppColors.title,
                fontSize: 15,
                textInputAction: TextInputAction.next,
                inputFormatters: [UpperCaseTextFormatter()],
              ),
            ).paddingOnly(bottom: 20),
            CustomTitle(
              title: EnumLocale.txtEmail.name.tr,
              method: CustomTextField(
                controller: logic.emailController,
                filled: true,
                fillColor: AppColors.categoryCircle,
                cursorColor: AppColors.title,
                fontColor: AppColors.title,
                fontSize: 15,
                readOnly: Constant.storage.read("isGoogleLogin") == true ? true : false,
                textInputAction: TextInputAction.next,
              ),
            ).paddingOnly(bottom: 20),
            CustomTitle(
              title: EnumLocale.txtSelectCountry.name.tr,
              method: const EditProfileCountryView(),
            ).paddingOnly(bottom: 20),
            CustomTitle(
              title: EnumLocale.txtSelectGender.name.tr,
              method: const EditProfileGenderView(),
            ).paddingOnly(bottom: 20),
            CustomTitle(
              title: EnumLocale.txtDateOfBirth.name.tr,
              method: const EditProfileBirthDateView(),
            ).paddingOnly(bottom: 20),
            const EditProfileSavedButtonView(),
          ],
        ).paddingOnly(left: 13, right: 13);
      },
    );
  }
}

/// =================== Mobile Number =================== ///
class EditProfilePhoneNumberView extends StatelessWidget {
  const EditProfilePhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (logic) {
        return IntlPhoneField(
          flagsButtonPadding: const EdgeInsets.all(8),
          dropdownIconPosition: IconPosition.trailing,
          controller: logic.numberController,
          validator: (value) {
            if (value == null) {
              return EnumLocale.desEnterMobile.name.tr;
            }
            return null;
          },
          onCountryChanged: (value) {
            log("message :: ${value.code}");
            countryCode = value.code;

            getDialCode();
          },
          obscureText: false,
          readOnly: Constant.storage.read("isMobileLogin") == true ? true : false,
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

/// =================== Country =================== ///
class EditProfileCountryView extends StatelessWidget {
  const EditProfileCountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: Constant.idSelectCountry,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              favorite: <String>[countryCode.toString()],
              showPhoneCode: false,
              onSelect: (Country country) {
                logic.onCountryChange(country.name);
              },
              showSearch: false,
              countryListTheme: CountryListThemeData(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                bottomSheetHeight: Get.height * 0.6,
                flagSize: 30,
                textStyle: FontStyle.fontStyleW600(
                  fontSize: 14,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
            );
          },
          child: Container(
            height: Get.height * 0.07,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.categoryCircle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logic.countryName ?? country!,
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.bottomLabel,
                  ),
                ),
                Image.asset(
                  AppAsset.icArrowDown,
                  height: 23,
                  width: 23,
                  color: AppColors.title,
                ),
              ],
            ).paddingOnly(left: 15, right: 15),
          ),
        );
      },
    );
  }
}

/// =================== Gender =================== ///
class EditProfileGenderView extends StatelessWidget {
  const EditProfileGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    List gender = [
      EnumLocale.txtFemale.name.tr,
      EnumLocale.txtMale.name.tr,
    ];

    return GetBuilder<EditProfileController>(
      id: Constant.idRegGenderSelect,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 6,
                          width: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.viewMore),
                        ),
                      ).paddingOnly(top: 8, bottom: 23),
                      SizedBox(
                        height: Get.height * 0.05,
                        child: GetBuilder<EditProfileController>(
                          id: Constant.idRegGenderSelect,
                          builder: (logic) {
                            return GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                childAspectRatio: 3,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: gender.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    logic.onGenderSelect(index);
                                  },
                                  child: Container(
                                    width: Get.width * 0.26,
                                    margin: const EdgeInsets.only(right: 13),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: logic.genderSelect == index ? AppColors.primaryAppColor1 : AppColors.border,
                                        width: 1.2,
                                      ),
                                      gradient: logic.genderSelect == index
                                          ? LinearGradient(
                                              colors: [
                                                AppColors.primaryAppColor1,
                                                AppColors.primaryAppColor2,
                                              ],
                                            )
                                          : LinearGradient(
                                              colors: [
                                                AppColors.white,
                                                AppColors.white,
                                              ],
                                            ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        gender[index],
                                        style: FontStyle.fontStyleW500(
                                          fontSize: 15,
                                          fontColor: logic.genderSelect == index ? AppColors.white : AppColors.tabUnselectText,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ).paddingOnly(left: 12, right: 12),
                      const Spacer(),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: PrimaryAppButton(
                            height: Get.height * 0.06,
                            width: Get.width * 0.5,
                            gradientColor: [
                              AppColors.primaryAppColor1,
                              AppColors.primaryAppColor2,
                            ],
                            borderRadius: 70,
                            text: EnumLocale.txtSelectGender.name.tr,
                            textStyle: FontStyle.fontStyleW600(
                              fontSize: 15,
                              fontColor: AppColors.white,
                            ),
                          ).paddingOnly(bottom: 25),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            height: Get.height * 0.07,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.categoryCircle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logic.genderName ?? "Female",
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.bottomLabel,
                  ),
                ),
                Image.asset(
                  AppAsset.icArrowDown,
                  height: 23,
                  width: 23,
                  color: AppColors.title,
                ),
              ],
            ).paddingOnly(left: 15, right: 15),
          ),
        );
      },
    );
  }
}

/// =================== BirthDate =================== ///
class EditProfileBirthDateView extends StatelessWidget {
  const EditProfileBirthDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: Constant.idSelectBirthDate,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            showCalendarDatePicker2Dialog(
              context: context,
              config: CalendarDatePicker2WithActionButtonsConfig(
                selectedDayHighlightColor: AppColors.title,
                weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                weekdayLabelTextStyle: FontStyle.fontStyleW500(
                  fontSize: 11,
                  fontColor: AppColors.description,
                ),
                firstDayOfWeek: 1,
                controlsHeight: 50,
                controlsTextStyle: FontStyle.fontStyleW600(
                  fontSize: 12,
                  fontColor: AppColors.bottomLabel,
                ),
                dayTextStyle: FontStyle.fontStyleW600(
                  fontSize: 13.5,
                  fontColor: AppColors.bottomLabel,
                ),
                disabledDayTextStyle: const TextStyle(
                  color: Colors.grey,
                ),
                lastDate: DateTime.now(),
                currentDate: DateTime.now(),
                firstDate: DateTime(1960),
                cancelButtonTextStyle: FontStyle.fontStyleW600(
                  fontSize: 13,
                  fontColor: AppColors.notificationTitle2,
                ),
                okButtonTextStyle: FontStyle.fontStyleW600(
                  fontSize: 13,
                  fontColor: AppColors.bottomLabel,
                ),
              ),
              dialogSize: const Size(325, 400),
              value: [logic.dob],
              borderRadius: BorderRadius.circular(30),
            ).then((value) {
              if (value != null) {
                log("Selected Value :: $value");

                logic.formatBirthDate = DateFormat('dd MMM yyyy').format(value.first!);
                logic.finalBirthDate = DateFormat('yyyy-MM-dd').format(value.first!);

                logic.onSelectBirthDate(logic.formatBirthDate.toString());
                log("Selected BirthDate :: ${logic.birthDate}");
                log("Final Selected BirthDate :: ${logic.finalBirthDate}");
              }
            });
          },
          child: Container(
            height: Get.height * 0.07,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.categoryCircle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logic.birthDate ?? "01 Jan 2000",
                  style: FontStyle.fontStyleW600(
                    fontSize: 15,
                    fontColor: AppColors.bottomLabel,
                  ),
                ),
                Image.asset(
                  AppAsset.icAppointmentFilled,
                  height: 25,
                  width: 25,
                  color: AppColors.bottomLabel,
                ),
              ],
            ).paddingOnly(left: 15, right: 15),
          ),
        );
      },
    );
  }
}

/// =================== Save Button =================== ///
class EditProfileSavedButtonView extends StatelessWidget {
  const EditProfileSavedButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onSaveProfileClick(context);
          },
          height: Get.height * 0.065,
          width: Get.width,
          gradientColor: [
            AppColors.primaryAppColor1,
            AppColors.primaryAppColor2,
          ],
          borderRadius: 10,
          text: EnumLocale.txtSaveProfile.name.tr,
          textStyle: FontStyle.fontStyleW600(
            fontSize: 16,
            fontColor: AppColors.white,
          ),
        ).paddingOnly(bottom: 25);
      },
    );
  }
}
