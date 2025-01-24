import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/ui/my_profile/view_profile/widget/documents_widget.dart';
import 'package:doctor/ui/my_profile/view_profile/widget/insurance_details_widget.dart';
import 'package:doctor/ui/my_profile/view_profile/widget/personal_details_widget.dart';
import 'package:doctor/ui/my_profile/view_profile/widget/physical_details_widget.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

/// =================== Current Balance =================== ///

class MyProfileBackgroundView extends StatelessWidget {
  const MyProfileBackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.145,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAsset.profileBackground),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "Hello\n",
              style: FontStyle.fontStyleW500(
                fontSize: 17,
                fontColor: AppColors.black,
              ),
              children: [
                TextSpan(
                  text: "Mr. Rajul Mesvani",
                  style: FontStyle.fontStyleW700(
                    fontSize: 17,
                    fontColor: AppColors.profileTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              EnumLocale.txtEditProfile.name.tr,
              style: FontStyle.fontStyleW500(
                fontSize: 14,
                fontColor: AppColors.black,
              ),
            ),
          ),
        ],
      ).paddingOnly(top: 10.0, left: 10.0),
    );
  }
}

class ViewProfileListViewItems extends StatefulWidget {
  ViewProfileListViewItems({super.key});

  @override
  State<ViewProfileListViewItems> createState() =>
      _ViewProfileListViewItemsState();
}

class _ViewProfileListViewItemsState extends State<ViewProfileListViewItems> {
  List<String> viewProfileItems = [
    "Personal Details",
    "Physical Details",
    "Insurance",
    "Documents",
  ];

  final List<Widget> navigateToPages = [
    PersonalDetailsWidget(),
    PhysicalDetailsWidget(),
    InsuranceDetailsWidget(),
    DocumentsDetailsWidget(),
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: Get.height * 0.065,
            child: ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                itemCount: viewProfileItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: selectedIndex == index
                                ? AppColors.containerPurple
                                : AppColors.white,
                            border: Border.all(
                              color: selectedIndex == index
                                  ? AppColors.transparent
                                  : AppColors.black,
                              width: 1.0,
                            ),
                          ),
                          child: Text(
                            viewProfileItems[index],
                            style: FontStyle.fontStyleW500(
                              fontSize: 14,
                              fontColor:  selectedIndex == index
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        ).paddingSymmetric(horizontal: 5.0),
                      ),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.vertical,
                      //   child: IndexedStack(
                      //     index: selectedIndex,
                      //     children: [
                      //       PersonalDetailsWidget(),
                      //       // SettingsWidget(),
                      //       // HelpWidget(),
                      //     ],
                      //   ),
                      // ),
                    ],
                  );
                })),
        SizedBox(
            // height: Get.height * 0.065,
            child: ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: IndexedStack(
                          index: selectedIndex,
                          children: [
                            PersonalDetailsWidget(),
                            PhysicalDetailsWidget(),
                            InsuranceDetailsWidget(),
                            DocumentsDetailsWidget(),
                          ],
                        ),
                      ),
                    ],
                  );
                })),
      ],
    );
  }
}
