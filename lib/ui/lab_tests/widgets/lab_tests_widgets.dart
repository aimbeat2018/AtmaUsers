import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/search_screen/widget/search_screen_widget.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:doctor/utils/font_style.dart';

class LabTestsAppBarView extends StatelessWidget {
  const LabTestsAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtLabTest.name.tr,
      showLeadingIcon: true,
    );
  }
}

class SearchTestType extends StatelessWidget {
  SearchTestType({super.key});

  final TextEditingController searchTestTypeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldSearch(
      onChanged: (text) {
        // logic.searchDoctorByName(text: text ?? "");
        return null;
      },
      hintText: EnumLocale.txtSearchDoctor.name.tr,
      controller: /*logic.searchController*/ searchTestTypeController,
      fillColor: AppColors.white,
      hintTextSize: 13,
      hintTextColor: AppColors.textFormHintText,
      filled: true,
      textInputAction: TextInputAction.done,
      /* prefixIcon: Image.asset(
        AppAsset.icSearch,
        height: 10,
        width: 10,
      ).paddingAll(12),*/
      inputFormatters: [
        UpperCaseTextFormatter(),
      ],
      suffixIcon: InkWell(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const FilterBottomSheet();
            },
          );
        },
        child: Text(
          "Search",
          style: FontStyle.fontStyleW500(
            fontSize: 12,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingOnly(top: 14, right: 14),
        /*  Image.asset(
          AppAsset.icCategory,
          height: 10,
          width: 10,
        )*/
      ),
    ).paddingOnly(right: 10, top: 10, bottom: 10, left: 10.0);
  }
}

//most searched
class MostSearchedTitleView extends StatelessWidget {
  const MostSearchedTitleView({super.key});

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
            EnumLocale.txtMostSearched.name.tr,
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

class MostSearchedCategoryView extends StatelessWidget {
  const MostSearchedCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 3,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 9.5 / 9,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return MostSearchedCategoryItem(index: index)
            .paddingOnly(left: 12, right: 12, top: 15);
        // HomeCategoryItemView(index: index);
      },
    );
  }
}

class MostSearchedCategoryItem extends StatelessWidget {
  final int index;

  const MostSearchedCategoryItem({super.key, required this.index});

  final String medicineImg = AppAsset.medicineImg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.containerGrey,
            ),
            padding: const EdgeInsets.all(10),
            child: CachedNetworkImage(
              imageUrl: medicineImg,
              // fit: BoxFit.cover,
              placeholder: (context, url) {
                return Image.asset(AppAsset.medicineImg).paddingAll(10);
              },
              errorWidget: (context, url, error) {
                return Image.asset(AppAsset.medicineImg).paddingAll(10);
              },
            ),
          ).paddingOnly(bottom: 10),
          Text(
            "Category",
            overflow: TextOverflow.ellipsis,
            style: FontStyle.fontStyleW500(
              fontSize: 13,
              fontColor: AppColors.categoryText,
            ),
          ),
        ],
      ),
    );
  }
}

//recommended by experts

class RecommendedByExpertsTitle extends StatelessWidget {
  const RecommendedByExpertsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
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
              EnumLocale.txtRecommendedByExpert.name.tr,
              style: FontStyle.fontStyleW600(
                fontSize: 17,
                fontColor: AppColors.black,
              ),
            ).paddingOnly(top: 15, left: 0, right: 15),
          ],
        ),
      ),
    );
  }
}

// class RecommendedByExpertItems extends StatelessWidget {
//   //   final int index;
//
//   const RecommendedByExpertItems({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //checkbox
//         //listview
//         ListView.builder(
//           itemCount: 3,
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           // padding: EdgeInsets.only(left: 20, right: 20),
//           itemBuilder: (context, index) {
//             return checkboxlist(index: index);
//           },
//         ).paddingOnly(top: 20, bottom: 20),
//       ],
//     );
//   }
// }

List multipleSelected = [];
List checkListItems = [
  {
    "id": 0,
    "value": false,
    "title": "Sunday",
  },
  {
    "id": 1,
    "value": false,
    "title": "Monday",
  },
  {
    "id": 2,
    "value": false,
    "title": "Tuesday",
  },
  {
    "id": 3,
    "value": false,
    "title": "Wednesday",
  },
  {
    "id": 4,
    "value": false,
    "title": "Thursday",
  },
];

// class RecommendedTestList extends StatelessWidget {
//   final int index;
//
//   const RecommendedTestList({super.key, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30.0, right: 15.0, top: 8.0),
//       child: Container(
//           padding: const EdgeInsets.only(left: 10.0, top: 12.0, bottom: 12.0),
//           width: double.infinity,
//           decoration: BoxDecoration(
//               color: AppColors.containerBg,
//               border: Border.all(
//                 width: 1.0,
//                 color: AppColors.primaryAppColor1,
//               ),
//               borderRadius: BorderRadius.circular(5.0)),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: IntrinsicHeight(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         textAlign: TextAlign.center,
//                         "12",
//                         style: FontStyle.fontStyleW600(
//                           fontSize: 16,
//                           fontColor: AppColors.primaryAppColor1,
//                         ),
//                       ),
//                       Text(
//                         "feb".toUpperCase(),
//                         style: FontStyle.fontStyleW600(
//                           fontSize: 16,
//                           fontColor: AppColors.primaryAppColor1,
//                         ),
//                       ),
//                     ],
//                   ),
//                   VerticalDivider(
//                     indent: 4,
//                     endIndent: 4,
//                     thickness: 1,
//                     color: AppColors.dividerGrey,
//                   ).paddingOnly(left: 8.0),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${EnumLocale.txtTestType.name.tr} : Blood Test",
//                             style: FontStyle.fontStyleW600(
//                               fontSize: 14,
//                               fontColor: AppColors.primaryAppColor1,
//                             ),
//                           ),
//                           Text(
//                             "${EnumLocale.txtConstDoctor.name.tr} : Blood Test",
//                             style: FontStyle.fontStyleW400(
//                               fontSize: 13,
//                               fontColor: AppColors.black,
//                             ),
//                           ),
//                           Text(
//                             "${EnumLocale.txtCollection.name.tr} : Blood Test",
//                             style: FontStyle.fontStyleW400(
//                               fontSize: 13,
//                               fontColor: AppColors.primaryAppColor1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.delete,
//                           color: AppColors.primaryAppColor1)),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }

class RecommendedByExpertItems extends StatefulWidget {
  const RecommendedByExpertItems({super.key});

  @override
  State<RecommendedByExpertItems> createState() => _RecommendedByExpertItemsState();
}

class _RecommendedByExpertItemsState extends State<RecommendedByExpertItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        checkListItems.length,
        (index) => CheckboxListTile(
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          side: WidgetStateBorderSide.resolveWith((states) => BorderSide(
                color: AppColors.primaryAppColor1,
                width: 1.5,
              )),
          activeColor: Colors.white,
          checkColor: AppColors.black,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 8.0),
            child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "12",
                              style: FontStyle.fontStyleW600(
                                fontSize: 16,
                                fontColor: AppColors.primaryAppColor1,
                              ),
                            ),
                            Text(
                              "feb".toUpperCase(),
                              style: FontStyle.fontStyleW600(
                                fontSize: 16,
                                fontColor: AppColors.primaryAppColor1,
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          indent: 4,
                          endIndent: 4,
                          thickness: 1,
                          color: AppColors.dividerGrey,
                        ).paddingOnly(left: 8.0),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
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
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete,
                                color: AppColors.primaryAppColor1)),
                      ],
                    ),
                  ),
                )),
          ),
          value: checkListItems[index]["value"],
          onChanged: (value) {
            setState(() {
            checkListItems[index]["value"] = value;
            if (multipleSelected.contains(checkListItems[index])) {
              multipleSelected.remove(checkListItems[index]);
            } else {
              multipleSelected.add(checkListItems[index]);
            }
            });
          },
        ),
      ),
    );
  }
}

class RecommendedByExpertBottomView extends StatelessWidget {
  const RecommendedByExpertBottomView({super.key});

  @override
  Widget build(BuildContext context) {
        return Container(
          height: Get.height * 0.1,
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                offset: const Offset(
                  3.0,
                  3.0,
                ),
                blurRadius: 8.0,
              ), //BoxShadow
            ],
          ),
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.addAddress);
                },
                child: PrimaryAppButton(
                  height: Get.height * 0.062,
                  width: Get.width * 0.92,
                  borderRadius: 11,
                  gradientColor: [
                    AppColors.primaryAppColor1,
                    AppColors.primaryAppColor2
                  ],
                  widget: RichText(
                    text: TextSpan(
                      text: '${EnumLocale.txtProceed.name.tr} ',
                      style: FontStyle.fontStyleW500(
                        fontSize: 16,
                        fontColor: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
