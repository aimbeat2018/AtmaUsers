import 'dart:io';
import 'package:doctor/utils/enums.dart';
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

class PhysicalDetailsScreen extends StatefulWidget {
  const PhysicalDetailsScreen({super.key});

  @override
  State<PhysicalDetailsScreen> createState() => _PhysicalDetailsScreenState();
}

class _PhysicalDetailsScreenState extends State<PhysicalDetailsScreen> {

  final TextEditingController weightController = TextEditingController();

  final TextEditingController heightController = TextEditingController();

  final TextEditingController medicalHistoryController = TextEditingController();

  final TextEditingController medicalOtherHistoryController = TextEditingController();

  final TextEditingController medicalHistoryDetailsController = TextEditingController();

  final TextEditingController surgicalHistoryController = TextEditingController();

  final TextEditingController anaesthesiaHistoryController = TextEditingController();

  final TextEditingController allergyController = TextEditingController();

  final TextEditingController addictionsController = TextEditingController();

  final TextEditingController familyHistoryController = TextEditingController();

  final TextEditingController otherSpecificHistoryController = TextEditingController();

  String selectedWeightTypes = "Kg";

  List<String> weightTypes = [
    "Kg",
    "Grams",
  ];
  String selectedHeightTypes = "Ft";

  List<String> heightTypes = [
    "Ft",
    "CM",
  ];

  String selectedMedicalHistoryType = "HT";

  List<String> medicalHistoryTypes = [
    "HT",
    "abc",
    'def',
  ];

  String selectedTakingMedicines = "Yes";
  List<String> takingMedicinesTypes = [
    "Yes",
    "No",
  ];

  String selectedRecentExacerbations = "Yes";
  List<String>recentExacerbationsTypes = [
    "Yes",
    "No",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyProfileAppBarView(),
      ),
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
                CircleWithBorder(),
                SizedBox(width: 2),
                const Expanded(child: MySeparator()),
                SizedBox(width: 2),
                CircleWithBorder(),
              ],
            ).paddingOnly(top:20, left:10, right: 10),
            AddressCustomTitle(
              title: "Weight",
              method: Container(
                decoration: BoxDecoration(
                  color: AppColors.appBarBg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: weightController,
                        filled: false,
                        // fillColor: AppColors.appBarBg,
                        cursorColor: AppColors.title,
                        fontColor: AppColors.title,
                        fontSize: 15,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [UpperCaseTextFormatter()],
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                              borderRadius: BorderRadius.circular(10.0),
                              padding: const EdgeInsets.only(right: 10.0, left: 90.0),
                              // isDense: true,
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              style: FontStyle.fontStyleW500(
                                fontSize: 13,
                                fontColor: AppColors.primaryAppColor1,
                              ),
                              value: selectedWeightTypes.isNotEmpty
                                  ? selectedWeightTypes
                                  : null,
                              icon: Icon(
                                Icons.arrow_drop_down_sharp,
                                color: AppColors.black,
                              ),
                              items: weightTypes.map((items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      items,
                                      style: FontStyle.fontStyleW500(
                                        fontSize: 14,
                                        fontColor: AppColors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedWeightTypes = newValue!;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingOnly(bottom: 20, top:20),
            AddressCustomTitle(
              title: "Height",
              method: Container(
                decoration: BoxDecoration(
                  color: AppColors.appBarBg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: heightController,
                        filled: false,
                        // fillColor: AppColors.appBarBg,
                        cursorColor: AppColors.title,
                        fontColor: AppColors.title,
                        fontSize: 15,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [UpperCaseTextFormatter()],
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                              borderRadius: BorderRadius.circular(10.0),
                              padding: const EdgeInsets.only(right: 10.0, left: 90.0),
                              // isDense: true,
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              style: FontStyle.fontStyleW500(
                                fontSize: 13,
                                fontColor: AppColors.primaryAppColor1,
                              ),
                              value: selectedHeightTypes.isNotEmpty
                                  ? selectedHeightTypes
                                  : null,
                              icon: Icon(
                                Icons.arrow_drop_down_sharp,
                                color: AppColors.black,
                              ),
                              items: heightTypes.map((items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      items,
                                      style: FontStyle.fontStyleW500(
                                        fontSize: 14,
                                        fontColor: AppColors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedHeightTypes = newValue!;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingOnly(bottom: 20),
            AddressCustomTitle(
              title: "Medical History",
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
                        value: selectedMedicalHistoryType.isNotEmpty
                            ? selectedMedicalHistoryType
                            : null,
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColors.primaryAppColor1,
                        ),
                        items: medicalHistoryTypes.map((items) {
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
                            selectedMedicalHistoryType = newValue!;
                          });
                        }),
                  ),
                ),
              ),
            ).paddingOnly(bottom: 20),
            AddressCustomTitle(
              title: "Medical Other History",
              method: CustomTextField(
                controller: medicalOtherHistoryController,
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
              title: "Medical History Details",
              method: CustomTextField(
                controller: medicalHistoryDetailsController,
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
              title: "Are you Taking Medicines?",
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
                        value: selectedTakingMedicines.isNotEmpty
                            ? selectedTakingMedicines
                            : null,
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColors.primaryAppColor1,
                        ),
                        items: takingMedicinesTypes.map((items) {
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
                            selectedTakingMedicines = newValue!;
                          });
                        }),
                  ),
                ),
              ),
            ).paddingOnly(bottom: 20),
            AddressCustomTitle(
              title: "Recent Exacerbations",
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
                        value: selectedRecentExacerbations.isNotEmpty
                            ? selectedRecentExacerbations
                            : null,
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColors.primaryAppColor1,
                        ),
                        items: recentExacerbationsTypes.map((items) {
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
                            selectedRecentExacerbations = newValue!;
                          });
                        }),
                  ),
                ),
              ),
            ).paddingOnly(bottom: 20),
            AddressCustomTitle(
              title: "Surgical History",
              method: CustomTextField(
                controller: surgicalHistoryController,
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
              title: "Anaesthesia History",
              method: CustomTextField(
                controller: anaesthesiaHistoryController,
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
              title: "Allergy",
              method: CustomTextField(
                controller: allergyController,
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
              title: "Addictions",
              method: CustomTextField(
                controller: addictionsController,
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
              title: "Family History",
              method: CustomTextField(
                controller: familyHistoryController,
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
              title: "Other Specific History",
              method: CustomTextField(
                controller: otherSpecificHistoryController,
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
                    onTap: ()  {
                      Get.toNamed(AppRoutes.insuranceDetails);
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

          ],
        ).paddingOnly(left: 13, right: 13),
      ),
    );
  }
}
