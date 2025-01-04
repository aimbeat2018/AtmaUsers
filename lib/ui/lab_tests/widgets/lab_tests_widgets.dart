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

  final TextEditingController searchTestTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldSearch(
      onChanged: (text) {
        // logic.searchDoctorByName(text: text ?? "");
        return null;
      },
      hintText: EnumLocale.txtSearchDoctor.name.tr,
      controller: /*logic.searchController*/searchTestTypeController,
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
        child: Text("Search",
          style: FontStyle.fontStyleW500(
          fontSize: 12,
          fontColor: AppColors.primaryAppColor1,
        ),).paddingOnly(top:14, right:14),
      /*  Image.asset(
          AppAsset.icCategory,
          height: 10,
          width: 10,
        )*/
      ),
    ).paddingOnly(right: 10, top: 10, bottom: 10, left:10.0);
  }
}

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
              ).paddingOnly(left:15),
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
        crossAxisCount: 4,
        childAspectRatio: 0.72,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return SizedBox();
          // HomeCategoryItemView(index: index);
      },
    );
  }
}

class MostSearchedCategoryItem extends StatelessWidget {
  const MostSearchedCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
