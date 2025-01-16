import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/circle.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/separator.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController buildingNameController = TextEditingController();

  final TextEditingController landmarkController = TextEditingController();

  final TextEditingController areaController = TextEditingController();

  final TextEditingController pinCodeController = TextEditingController();

  final TextEditingController districtController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

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
       ),
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
        AddressCustomTitle(
          title: EnumLocale.txtFlat.name.tr,
          method: CustomTextField(
            controller: buildingNameController,
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
          title: EnumLocale.txtLandmark.name.tr,
          method: CustomTextField(
            controller: landmarkController,
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
          title: EnumLocale.txtArea.name.tr,
          method: CustomTextField(
            controller: areaController,
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
          title: EnumLocale.txtPincode.name.tr,
          method: CustomTextField(
            controller: pinCodeController,
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
          title: EnumLocale.txtDistrict.name.tr,
          method: CustomTextField(
            controller: districtController,
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
          title: EnumLocale.txtState.name.tr,
          method: CustomTextField(
            controller: stateController,
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
          title: EnumLocale.txtCountry.name.tr,
          method: CustomTextField(
            controller: countryController,
            filled: true,
            fillColor: AppColors.appBarBg,
            cursorColor: AppColors.title,
            fontColor: AppColors.title,
            fontSize: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
        ).paddingOnly(bottom: 20),
        Row(children: [
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
        ]),
      ],
    ).paddingOnly(left: 13, right: 13);
  }
}
