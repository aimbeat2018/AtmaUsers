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

class MyOrdersAppBarView extends StatelessWidget {
  const MyOrdersAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyOrder.name.tr,
      showLeadingIcon: true,
    );
  }
}

class MyOrdersItemView extends StatelessWidget {
   MyOrdersItemView({super.key});


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
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: AppColors.containerBg,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryAppColor1,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
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
                                      Get.toNamed(AppRoutes.orderDetails);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 5.0, right: 5.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Text(EnumLocale.txtViewDetails.name.tr,
                                          style: FontStyle.fontStyleW600(
                                            fontSize: 11,
                                            fontColor: AppColors.primaryAppColor1,
                                          ),).paddingOnly(right: 2.0, top: 2.0, bottom: 2.0)
                                    ).paddingOnly(left: 10.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppAsset.icDelivery, height: 15),
                        const SizedBox(width: 5.0),
                        Text("${EnumLocale.txtDeliveredOn.name.tr}18.08.2024, 20:35",
                          style: FontStyle.fontStyleW500(
                          fontSize: 11,
                          fontColor: AppColors.blueColor,
                        ),),
                      ],
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: AppColors.borderColor,
                          ),
                        ),
                        child: Text("${EnumLocale.txtOrderId.name.tr} #M2Z4-VVY2",
                          style: FontStyle.fontStyleW500(
                          fontSize: 11,
                          fontColor: AppColors.containerBlue,
                        ),),
                      ),
                    ),
                  ],
                ).paddingOnly(top:5.0, bottom: 5.0, left: 10.0, right: 10.0),
              ],
            ),
          ).paddingOnly(top:10.0),
        );
      },
    );
  }
}

