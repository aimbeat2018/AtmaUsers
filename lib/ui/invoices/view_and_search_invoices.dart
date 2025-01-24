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

class ViewAndSearchInvoices extends StatefulWidget {
  const ViewAndSearchInvoices({super.key});

  @override
  State<ViewAndSearchInvoices> createState() => _ViewAndSearchInvoicesState();
}

class _ViewAndSearchInvoicesState extends State<ViewAndSearchInvoices> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: EnumLocale.txtInvoices.name.tr,
          showLeadingIcon: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomTextFieldSearch(
                  onChanged: (text) {
                    return null;
                  },
                  hintText: "from",
                  controller: fromController,
                  fillColor: AppColors.white,
                  hintTextSize: 13,
                  hintTextColor: AppColors.textFormHintText,
                  filled: true,
                  cursorColor: AppColors.primaryAppColor1,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                ),
              ),
              Text("-", style: FontStyle.fontStyleW600(
                fontSize: 17,
                fontColor: AppColors.grey,
              ),).paddingOnly(left:8.0),
              Expanded(
                child: CustomTextFieldSearch(
                  onChanged: (text) {
                    return null;
                  },
                  hintText: "to",
                  controller: toController,
                  fillColor: AppColors.white,
                  hintTextSize: 13,
                  cursorColor: AppColors.primaryAppColor1,
                  hintTextColor: AppColors.textFormHintText,
                  filled: true,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                ).paddingOnly(right: 10, top: 10, bottom: 10, left: 10.0),
              ),
              Text(
                "Search",
                style: FontStyle.fontStyleW500(
                  fontSize: 12,
                  fontColor: AppColors.primaryAppColor1,
                ),
              ),
            ],
          ).paddingOnly(top: 5, right: 10.0, left: 10.0),
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
                        alignment: Alignment.topRight,
                        child: PopupMenuButton(
                            color: AppColors.white,
                            icon: Icon(Icons.more_vert,
                                color: Colors.black), // add this line
                            itemBuilder: (_) => <PopupMenuItem<String>>[
                                  PopupMenuItem<String>(
                                      child: Container(
                                          width: 100,
                                          child: Text(
                                            EnumLocale.txtView.name.tr,
                                            style: TextStyle(
                                                color: AppColors.black),
                                          )),
                                      value: 'view'),
                                  PopupMenuItem<String>(
                                      child: Container(
                                          width: 100,
                                          child: Text(
                                            EnumLocale.txtDownload.name.tr,
                                            style: TextStyle(
                                                color: AppColors.black),
                                          )),
                                      value: 'Download'),
                                  PopupMenuItem<String>(
                                      child: Container(
                                          width: 100,
                                          child: Text(
                                            EnumLocale.txtDelete.name.tr,
                                            style: TextStyle(
                                                color: AppColors.black),
                                          )),
                                      value: 'Delete'),
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
      ),
    );
  }
}
