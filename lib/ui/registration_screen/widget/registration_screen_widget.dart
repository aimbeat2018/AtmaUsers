import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:country_picker/country_picker.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/ui/registration_screen/controller/registration_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// =================== App Bar =================== ///
class RegistrationAppBarView extends StatelessWidget {
  const RegistrationAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtRegistration.name.tr,
      showLeadingIcon: true,
      gradientColor: [AppColors.appBarBg, AppColors.appBarBg],
      iconColor: AppColors.title,
      textColor: AppColors.title,
    );
  }
}

/// =================== Description =================== ///
class RegistrationDesView extends StatelessWidget {
  const RegistrationDesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.desPleaseFillDetail.name.tr,
      textAlign: TextAlign.center,
      style: FontStyle.fontStyleW400(
        fontSize: 15,
        fontColor: AppColors.registrationDes,
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== Add Information(TextFormField) =================== ///
class RegistrationAddInfoView extends StatelessWidget {
  const RegistrationAddInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
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
                title: EnumLocale.txtEmail.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.emailController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterEmail.name.tr;
                    } else if (!logic.isEmailValid(value)) {
                      return EnumLocale.desEnterValidEmailAddress.name.tr;
                    }

                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtPassword.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.passwordController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  obscureText: logic.isObscure,
                  maxLines: 1,
                  suffixIcon: logic.isObscure
                      ? InkWell(
                          onTap: () {
                            logic.onClickObscure();
                          },
                          child: Image.asset(
                            AppAsset.icEyeUnVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        )
                      : InkWell(
                          onTap: () {
                            logic.onClickObscure();
                          },
                          child: Image.asset(
                            AppAsset.icEyeVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterPassword.name.tr;
                    } else if (value.length < 6) {
                      return EnumLocale.desPasswordCharacters.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtRePassword.name.tr,
                method: CustomTextField(
                  filled: true,
                  controller: logic.rePasswordController,
                  fillColor: AppColors.categoryCircle,
                  cursorColor: AppColors.title,
                  fontColor: AppColors.title,
                  fontSize: 15,
                  textInputAction: TextInputAction.next,
                  obscureText: logic.isObscure1,
                  maxLines: 1,
                  suffixIcon: logic.isObscure1
                      ? InkWell(
                          onTap: () {
                            logic.onClickObscure1();
                          },
                          child: Image.asset(
                            AppAsset.icEyeUnVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        )
                      : InkWell(
                          onTap: () {
                            logic.onClickObscure1();
                          },
                          child: Image.asset(
                            AppAsset.icEyeVisible,
                            height: 10,
                            width: 10,
                          ).paddingAll(12),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desReEnterPassword.name.tr;
                    } else if (value != logic.passwordController.text) {
                      return EnumLocale.desPasswordNotMatch.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Button =================== ///
class RegistrationButtonView extends StatelessWidget {
  const RegistrationButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      id: Constant.idRegister,
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onRegisterClick(context);
          },
          height: Get.height * 0.065,
          width: Get.width,
          borderRadius: 10,
          text: EnumLocale.txtRegister.name.tr,
          textStyle: FontStyle.fontStyleW600(
            fontSize: 16,
            fontColor: AppColors.white,
          ),
          gradientColor: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
        ).paddingOnly(left: 12, right: 12, top: 15);
      },
    );
  }
}

/// =================== Terms-Condition & Policy =================== ///
class RegistrationTncAndPolicyView extends StatelessWidget {
  const RegistrationTncAndPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        Utils.launchURL(tnc ?? "");
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: EnumLocale.desByProceedingForward.name.tr,
          style: FontStyle.fontStyleW400(
            fontSize: 14,
            fontColor: AppColors.accountLogin,
          ),
          children: [
            TextSpan(
              text: '\n${EnumLocale.txtPrivacyPolicy.name.tr}',
              style: FontStyle.fontStyleW600(
                fontSize: 14,
                fontColor: AppColors.bottomLabel,
                textDecoration: TextDecoration.underline,
                decorationColor: AppColors.bottomLabel,
              ),
            ),
            TextSpan(
              text: ' ${EnumLocale.txtAnd.name.tr} ',
              style: FontStyle.fontStyleW400(
                fontSize: 14,
                fontColor: AppColors.accountLogin,
              ),
            ),
            TextSpan(
              text: EnumLocale.txtTermsCondition.name.tr,
              style: FontStyle.fontStyleW600(
                fontSize: 14,
                fontColor: AppColors.bottomLabel,
                textDecoration: TextDecoration.underline,
                decorationColor: AppColors.bottomLabel,
              ),
            ),
          ],
        ),
      ).paddingOnly(top: 25),
    );
  }
}

/// =================== Complete Registration Screen =================== ///
class CompleteRegistrationScreen extends StatelessWidget {
  const CompleteRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: const CompleteRegistrationAppBarView(),
        ),
        body: GetBuilder<RegistrationController>(
          id: Constant.idProgressView,
          builder: (logic) {
            return ProgressDialog(
              inAsyncCall: logic.isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTitle(
                      title: EnumLocale.txtMobileNumber.name.tr,
                      method: const CompleteRegistrationPhoneNumberView(),
                    ).paddingOnly(bottom: 20),
                    CustomTitle(
                      title: EnumLocale.txtSelectCountry.name.tr,
                      method: const CompleteRegistrationCountryView(),
                    ).paddingOnly(bottom: 20),
                    CustomTitle(
                      title: EnumLocale.txtSelectGender.name.tr,
                      method: const CompleteRegistrationGenderView(),
                    ).paddingOnly(bottom: 20),
                    CustomTitle(
                      title: EnumLocale.txtDateOfBirth.name.tr,
                      method: const CompleteRegistrationBirthDateView(),
                    ).paddingOnly(bottom: 35),
                    const CompleteRegistrationButtonView(),
                  ],
                ).paddingOnly(left: 18, right: 18, top: 18),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// =================== Complete Registration App Bar =================== ///
class CompleteRegistrationAppBarView extends StatelessWidget {
  const CompleteRegistrationAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtCompleteRegistration.name.tr,
      showLeadingIcon: true,
      gradientColor: [AppColors.appBarBg, AppColors.appBarBg],
      iconColor: AppColors.title,
      textColor: AppColors.title,
    );
  }
}

/// =================== Complete Registration Add Number =================== ///
class CompleteRegistrationPhoneNumberView extends StatelessWidget {
  const CompleteRegistrationPhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
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

/// =================== Complete Registration Add Country =================== ///
class CompleteRegistrationCountryView extends StatelessWidget {
  const CompleteRegistrationCountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
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
            height: Get.height * 0.065,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.categoryCircle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logic.countryName ?? country.toString(),
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

/// =================== Complete Registration Select Gender =================== ///
class CompleteRegistrationGenderView extends StatelessWidget {
  const CompleteRegistrationGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
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
                        child: GetBuilder<RegistrationController>(
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
                              itemCount: logic.gender.length,
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
                                        logic.gender[index],
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
            height: Get.height * 0.065,
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

/// =================== Complete Registration Select BirthDate =================== ///
class CompleteRegistrationBirthDateView extends StatelessWidget {
  const CompleteRegistrationBirthDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
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
              value: [DateTime.now()],
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
            height: Get.height * 0.065,
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

/// =================== Complete Registration Button =================== ///
class CompleteRegistrationButtonView extends StatelessWidget {
  const CompleteRegistrationButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      id: Constant.idRegistration,
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
        ).paddingOnly(left: 12, right: 12, top: 25);
      },
    );
  }
}
