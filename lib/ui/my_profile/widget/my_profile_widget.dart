import 'dart:io';

import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/circle.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:doctor/utils/font_style.dart';

class MyProfileAppBarView extends StatelessWidget {
  const MyProfileAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyProfile.name.tr,
      showLeadingIcon: true,
    );
  }
}

class PersonalDetailsView extends StatefulWidget {
   const PersonalDetailsView({super.key});

  @override
  State<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends State<PersonalDetailsView> {

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController middleNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController emergencyContactController = TextEditingController();

  final TextEditingController bloodGroupController = TextEditingController();

  final TextEditingController educationController = TextEditingController();

  final TextEditingController religionController = TextEditingController();

  final TextEditingController occupationController = TextEditingController();

  final TextEditingController aadhaarController = TextEditingController();

  bool defaultAddressCheckbox = true;
  String selectedAddressType = "Home";

  List<String> addressTypes = [
    "Home",
    "Office",
    'Default',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Row(
         children: [
           FilledCircle(),
           SizedBox(width: 2),
           const Expanded(child: MySeparator()),
           SizedBox(width: 2),
           CircleWithBorder(),
           SizedBox(width: 2),
           const Expanded(child: MySeparator()),
           SizedBox(width: 2),
           CircleWithBorder(),
           SizedBox(width: 2),
           const Expanded(child: MySeparator()),
           SizedBox(width: 2),
           CircleWithBorder(),
         ],
       ).paddingOnly(top:20, left:10, right: 10),
          /*
        AddressCustomTitle(
          title: EnumLocale.txtAddressType.name.tr,
          method: Container(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.appBarBg,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(10.0),
                    padding: const EdgeInsets.only(right: 10.0),
                    // isDense: true,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    style: FontStyle.fontStyleW500(
                      fontSize: 13,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                    value: selectedAddressType.isNotEmpty
                        ? selectedAddressType
                        : null,
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.primaryAppColor1,
                    ),
                    items: addressTypes.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            items,
                            style: FontStyle.fontStyleW500(
                              fontSize: 14,
                              fontColor: AppColors.primaryAppColor1,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAddressType = newValue!;
                      });
                    }),
              ),
            ),
          ),
        ).paddingOnly(bottom: 20, top:20.0),
*/
        AddressCustomTitle(
          title: "First Name",
          method: CustomTextField(
            controller: firstNameController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20, top:20),
        AddressCustomTitle(
          title: "Middle Name",
          method: CustomTextField(
            controller: middleNameController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Last Name",
          method: CustomTextField(
            controller: lastNameController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Gender",
          method: CustomTextField(
            controller: genderController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title:"Date of Birth",
          method: CustomTextField(
            controller: dateOfBirthController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Mobile No.",
          method: CustomTextField(
            controller: mobileController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Email",
          method: CustomTextField(
            controller: emailController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Emergency Contact",
          method: CustomTextField(
            controller: emergencyContactController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Blood Group",
          method: CustomTextField(
            controller: bloodGroupController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Education",
          method: CustomTextField(
            controller: educationController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Religion",
          method: CustomTextField(
            controller: religionController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Occupation",
          method: CustomTextField(
            controller: occupationController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        AddressCustomTitle(
          title: "Aadhaar No.",
          method: CustomTextField(
            controller: aadhaarController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        Row(
          children: [
            Expanded(
              child: PrimaryAppButton(
                onTap: () async {
                  Get.back();

                  // logic.searchDoctorByName(text: logic.searchController.text);
                },
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
              ).paddingOnly(bottom: Platform.isAndroid?20:25, left: 10, right: 10, top:20),
            ),
            Expanded(
              child: PrimaryAppButton(
                onTap: () async {
                  Get.toNamed(AppRoutes.physicalDetails);
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
              ).paddingOnly(bottom: Platform.isAndroid?20:25, left: 10, right: 10, top:20),
            ),

          ],
        )
        /* Row(children: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              side: WidgetStateBorderSide.resolveWith((states) => BorderSide(
                color: AppColors.black,
                width: 1.5,
              )),
              activeColor: AppColors.black,
              value: defaultAddressCheckbox,
              onChanged: (bool? value) {
                setState(() {
                  defaultAddressCheckbox = value!;
                });
              },
            ),
          ),
          Text(
            EnumLocale.txtDefaultAddress.name.tr,
            style: FontStyle.fontStyleW400(
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          )
        ]),*/
      ],
    ).paddingOnly(left: 13, right: 13);
  }
}
