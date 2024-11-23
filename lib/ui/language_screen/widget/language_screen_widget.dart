import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/localization/localizations_delegate.dart';
import 'package:doctor/ui/language_screen/controller/language_screen_controller.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== App Bar =================== ///
class LanguageAppBarView extends StatelessWidget {
  const LanguageAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtLanguage.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Language List =================== ///
class LanguageListView extends StatelessWidget {
  const LanguageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageScreenController>(
      id: Constant.idChangeLanguage,
      builder: (logic) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          itemCount: Constant.countryList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return InkWell(
              overlayColor: WidgetStatePropertyAll(AppColors.transparent),
              onTap: () {
                logic.onChangeLanguage(languages[index], index);
                logic.onLanguageSave();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 46,
                        width: 46,
                        padding: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: AppColors.primaryAppColor1,
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(Constant.countryList[index]["image"]),
                      ).paddingOnly(right: 8),
                      Text(
                        Constant.countryList[index]["country"],
                        style: FontStyle.fontStyleW600(
                          fontSize: 15,
                          fontColor: AppColors.title,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.06,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: logic.checkedValue == index ? AppColors.sortByBorder : AppColors.border,
                        width: 1.3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(1.5),
                    child: logic.checkedValue == index
                        ? Container(
                            height: Get.height * 0.05,
                            width: Get.width * 0.05,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.primaryAppColor1, AppColors.primaryAppColor2],
                              ),
                              shape: BoxShape.circle,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ).paddingOnly(bottom: 15),
            );
          },
        );
      },
    );
  }
}
