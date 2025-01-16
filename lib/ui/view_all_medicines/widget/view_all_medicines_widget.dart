import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:doctor/utils/font_style.dart';

class ViewAllMedicinesBarView extends StatelessWidget {
  const ViewAllMedicinesBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Medicines",
      showLeadingIcon: true,
    );
  }
}

class ViewAllMedicinesItemView extends StatelessWidget {
  const ViewAllMedicinesItemView({super.key});

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
                            /*  setState(() {
                                isAddToCartClicked = !isAddToCartClicked;
                              });*/
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
                                  /*  Visibility(
                                        visible: !isAddToCartClicked,
                                        child: Image.asset(AppAsset.icCheckBlue, height: 10)),*/
                                  ],
                                )
                            ).paddingOnly(left: 8.0),
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
