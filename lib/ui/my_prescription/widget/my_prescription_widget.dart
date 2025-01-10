import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/ui/search_screen/widget/search_screen_widget.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:doctor/utils/font_style.dart';

class MyPrescriptionAppBarView extends StatelessWidget {
  const MyPrescriptionAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyPrescription.name.tr,
      showLeadingIcon: true,
    );
  }
}

class SearchFileNameView extends StatelessWidget {
  SearchFileNameView({super.key});

  final TextEditingController searchFileNameController =
      TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return CustomTextFieldSearch(
      onChanged: (text) {
        // logic.searchDoctorByName(text: text ?? "");
        return null;
      },
      hintText: EnumLocale.txtSearchFileName.name.tr,
      controller: /*logic.searchController*/ searchFileNameController,
      fillColor: AppColors.white,
      hintTextSize: 13,
      hintTextColor: AppColors.textFormHintText,
      filled: true,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        UpperCaseTextFormatter(),
      ],
      suffixIcon: InkWell(
        onTap: () {
          // showModalBottomSheet(
          //   isScrollControlled: true,
          //   context: context,
          //   builder: (BuildContext context) {
          //     return const FilterBottomSheet();
          //   },
          // );
        },
        child: Text(
          EnumLocale.txtSearch.name.tr,
          style: FontStyle.fontStyleW500(
            fontSize: 12,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingOnly(top: 14, right: 14),
      ),
    ).paddingOnly(right: 10, top: 10, bottom: 10, left: 10.0);
  }
}

class PrescriptionByExpertsTitle extends StatelessWidget {
  const PrescriptionByExpertsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VerticalDivider(
            indent: 20,
            endIndent: 1,
            thickness: 3,
            color: AppColors.primaryAppColor1,
          ).paddingOnly(left: 8),
          Text(
            EnumLocale.txtPrescriptionByExperts.name.tr,
            style: FontStyle.fontStyleW600(
              fontSize: 17,
              fontColor: AppColors.black,
            ),
          ).paddingOnly(top: 20, left: 0),
        ],
      ),
    );
  }
}

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "15 Aug 2024",
          style: FontStyle.fontStyleW500(
            fontSize: 14,
            fontColor: AppColors.black,
          ),
        ).paddingOnly(top: 15.0, left: 12.0),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 6,
            physics: const NeverScrollableScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.containerGrey1,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment:Alignment.topRight,
                      child: PopupMenuButton(
                        color: AppColors.white,
                          icon: Icon(Icons.more_vert,color: Colors.black), // add this line
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                child: Container(
                                    width: 100,
                                    child: Text(
                                      EnumLocale.txtView.name.tr,
                                      style: TextStyle(color: AppColors.black),
                                    )),
                                value: 'view'),


                          ],
                          onSelected: (index) async {
                            switch (index) {
                              case 'report':
                              // showDialog(
                              //     barrierDismissible: true,
                              //     context: context,
                              //     builder: (context) => ReportUser(
                              //       currentUser: widget.sender,
                              //       seconduser: widget.second,
                              //     )).then((value) => Navigator.pop(ct))
                                break;
                            }
                          }),
                    ),
                    Image.asset(AppAsset.icPdf, height: 50),

                  ],
                ),
              );
            }),
      ],
    );
  }
}
