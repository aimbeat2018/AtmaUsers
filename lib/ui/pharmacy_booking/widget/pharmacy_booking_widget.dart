import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/text_field/custom_text_field.dart';
import 'package:doctor/custom/upper_case_formatter/upper_case_formatter_class.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/search_screen/widget/search_screen_widget.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class MedicinesAppBarView extends StatelessWidget {
  const MedicinesAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMedicines.name.tr,
      showLeadingIcon: true,
    );
  }
}

class MedicinesAddressView extends StatelessWidget {
   const MedicinesAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, top: 12.0, bottom: 12.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.containerBg,
          borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        children: [
          Image.asset(
              height: 18,
              AppAsset.icLocationFilled2,
              color: AppColors.primaryAppColor1),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              "1904, Haware Infotech Park, Vashi, Navi Mumbai, Maharashtra, 400703",
              style: FontStyle.fontStyleW400(
                fontSize: 13,
                fontColor: AppColors.black,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
                    height: 22,
                    AppAsset.icEditAdd,
                    color: AppColors.primaryAppColor1)
                .paddingOnly(right: 10.0),
          ),
        ],
      ),
    ).paddingOnly(bottom: 20, top: 10.0, left: 10.0, right: 10.0);
  }
}

class SearchBrandView extends StatelessWidget {
  SearchBrandView({super.key});

  final TextEditingController searchBrandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldSearch(
      onChanged: (text) {
        // logic.searchDoctorByName(text: text ?? "");
        return null;
      },
      hintText: EnumLocale.txtSearchBrand.name.tr,
      controller: /*logic.searchController*/ searchBrandController,
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
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const FilterBottomSheet();
            },
          );
        },
        child: Text(
          EnumLocale.txtSearch.name.tr,
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

class UploadPrescriptionView extends StatelessWidget {
  const UploadPrescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
      child: InkWell(
        onTap: (){
          Get.toNamed(AppRoutes.newAddress);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColors.containerBlue,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Icon(Icons.cloud_upload_outlined, color: Colors.white),
              Image.asset(AppAsset.icUpload, height: 20, color: Colors.white),
              Text(
                EnumLocale.txtUploadPrescription.name.tr,
                style: FontStyle.fontStyleW400(
                  fontSize: 14,
                  fontColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

class MedicinesListView extends StatefulWidget {
  const MedicinesListView({super.key});

  @override
  State<MedicinesListView> createState() => _MedicinesListViewState();
}

class _MedicinesListViewState extends State<MedicinesListView> {
   bool isAddToCartClicked = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Get.toNamed(AppRoutes.medicineDetails);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryAppColor1,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                height: 100,
                width: 100,
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                  child: Image.asset(AppAsset.medicineImg1),
              ).paddingOnly(top: 10, left: 20, bottom: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Metropolis Healthcare Ltd.",
                        style: FontStyle.fontStyleW600(
                          fontSize: 14,
                          fontColor: AppColors.yellowTitle,
                        ),
                      ).paddingOnly(left: 10.0, top: 20.0),
                      Text(
                        "1 strip of 20 Tablets",
                        style: FontStyle.fontStyleW400(
                          fontSize: 12,
                          fontColor: AppColors.white,
                        ),
                      ).paddingOnly(left: 10.0, top:5.0),
                      Row(
                        children: [
                          Text(
                            "₹ 45.60",
                            style: FontStyle.fontStyleW600(
                              fontSize: 15,
                              fontColor: AppColors.white,
                            ),
                          ).paddingOnly(left: 10.0, top:5.0),
                          Text(
                            "₹ 50.00",
                            style: FontStyle.fontStyleW600(
                              fontSize: 12,
                              fontColor: AppColors.white,
                              textDecoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.white,
                            ),
                          ).paddingOnly(left: 10.0, top:5.0),
                          InkWell(
                            onTap: (){
                              setState(() {
                                isAddToCartClicked = !isAddToCartClicked;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 5.0, right: 5.0),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                                child: Row(
                                  children: [
                                    Text(EnumLocale.txtAddedToCart.name.tr,
                                        style: FontStyle.fontStyleW600(
                                      fontSize: 11,
                                      fontColor: AppColors.primaryAppColor1,
                                    ),).paddingOnly(right: 2.0),
                                    Visibility(
                                        visible: !isAddToCartClicked,
                                        child: Image.asset(AppAsset.icCheckBlue, height: 10)),
                                  ],
                                )
                            ).paddingOnly(left: 5.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).paddingOnly(top: 10),
        );
      },
    );
  }
}


class GoToCartBottomView extends StatelessWidget {
  const GoToCartBottomView({super.key});

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
              // Get.toNamed(AppRoutes.medicineDetails);
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
                  text: '${EnumLocale.txtGoToCart.name.tr} ',
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
