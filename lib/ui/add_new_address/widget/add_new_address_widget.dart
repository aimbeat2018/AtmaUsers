import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/ui/lab_tests/widgets/lab_tests_widgets.dart';
import 'package:doctor/ui/language_screen/controller/language_screen_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class AddNewAddressAppBarView extends StatelessWidget {
  const AddNewAddressAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
    title: EnumLocale.txtAddressDetails.name.tr,
    showLeadingIcon: true,
    );
  }
}
class AddNewAddressButton extends StatelessWidget {
  const AddNewAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: AppColors.containerBlue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  EnumLocale.txtAddNewAddress.name.tr,
                  style: FontStyle.fontStyleW400(
                  fontSize: 14,
                  fontColor: AppColors.white,
                ),),
                Icon(Icons.add_circle_outline, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SaveAddressTitle extends StatelessWidget {
  const SaveAddressTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VerticalDivider(
            indent: 14,
            endIndent: 2,
            thickness: 3,
            color: AppColors.primaryAppColor1,
          ).paddingOnly(left: 15),
          Text(
            EnumLocale.txtSaveAddress.name.tr,
            style: FontStyle.fontStyleW600(
              fontSize: 17,
              fontColor: AppColors.black,
            ),
          ).paddingOnly(top: 15, left: 0, right: 15),
        ],
      ),
    );
  }
}

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {

  // int selectedValue = 1;
  final addType = ["Default", "Home", "Office"];
  String? selectedValue;
  changeSelectedIndex(v) {
    setState(() {
      selectedValue = v;
    });
  }
  @override
  Widget build(BuildContext context) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
            itemCount: addType.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return RadioListTile(
                fillColor: WidgetStateProperty.resolveWith((states) {
                  // active
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primaryAppColor1;
                  }
                  // inactive
                  return AppColors.primaryAppColor1;
                }),
                value: addType[index],
                groupValue: selectedValue,
                selected: selectedValue == addType[index],
                onChanged: changeSelectedIndex,
                title: Container(
                    padding:
                    const EdgeInsets.only(left: 10.0, top: 12.0, bottom: 12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.containerBg,
                        border: Border.all(
                          width: 1.0,
                          color: AppColors.primaryAppColor1,
                        ),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${EnumLocale.txtTestType.name.tr} : Blood Test",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 14,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                              Text(
                                "${EnumLocale.txtConstDoctor.name.tr} : Blood Test",
                                style: FontStyle.fontStyleW400(
                                  fontSize: 13,
                                  fontColor: AppColors.black,
                                ),
                              ),
                              Text(
                                "${EnumLocale.txtCollection.name.tr} : Blood Test",
                                style: FontStyle.fontStyleW400(
                                  fontSize: 13,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete,
                                color: AppColors.primaryAppColor1)),
                      ],
                    )),
              );
            },
          );
    }
}

