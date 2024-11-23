import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/text_field/custom_title.dart';
import 'package:doctor/ui/complain_screen/controller/complain_screen_controller.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplainAppBarView extends StatelessWidget {
  const ComplainAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplainScreenController>(
      builder: (logic) {
        return CustomAppBar(
          title: logic.isComplain == true ? EnumLocale.txtComplain.name.tr : EnumLocale.txtSuggestion.name.tr,
          showLeadingIcon: true,
        );
      },
    );
  }
}

class ComplainInfoView extends StatelessWidget {
  const ComplainInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplainScreenController>(
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(
              title: EnumLocale.txtComplainSuggestion.name.tr,
              method: Container(
                height: Get.height * 0.2,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.categoryCircle,
                ),
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Text(
                    logic.details ?? "",
                    style: FontStyle.fontStyleW500(
                      fontSize: 15,
                      fontColor: AppColors.title,
                    ),
                  ),
                ),
              ),
            ).paddingOnly(bottom: 20),
            logic.isComplain == true
                ? CustomTitle(
                    title: EnumLocale.txtAppointmentID.name.tr,
                    method: Container(
                      height: Get.height * 0.06,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.categoryCircle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          logic.appointmentId.toString(),
                          textAlign: TextAlign.center,
                          style: FontStyle.fontStyleW500(
                            fontSize: 15,
                            fontColor: AppColors.title,
                          ),
                        ),
                      ),
                    ),
                  ).paddingOnly(bottom: 20)
                : const SizedBox(),
            CustomTitle(
              title: EnumLocale.txtYourImageScreenshot.name.tr,
              method: DottedBorder(
                color: AppColors.complainBoxBorder,
                dashPattern: const [3.5, 3.5],
                radius: const Radius.circular(21),
                strokeWidth: 1,
                borderType: BorderType.RRect,
                child: Container(
                  height: Get.height * 0.18,
                  width: Get.width * 0.36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: logic.image ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(AppAsset.icImagePlaceholder).paddingAll(10);
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(AppAsset.icImagePlaceholder).paddingAll(10);
                    },
                  ),
                ).paddingOnly(top: 15, left: 15),
              ),
            ).paddingOnly(bottom: 20),
          ],
        ).paddingOnly(top: 15, left: 15, right: 15);
      },
    );
  }
}
