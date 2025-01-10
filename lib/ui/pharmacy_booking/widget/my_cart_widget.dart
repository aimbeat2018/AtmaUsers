import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:doctor/ui/confirm_booking_screen/widget/confirm_booking_widget.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class MyyCartAppBarView extends StatelessWidget {
  const MyyCartAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyCart.name.tr,
      showLeadingIcon: true,
    );
  }
}

class MyCartListView extends StatefulWidget {
  const MyCartListView({super.key});


  @override
  State<MyCartListView> createState() => _MyCartListViewState();
}

class _MyCartListViewState extends State<MyCartListView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 3,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryAppColor1,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Moov Cool Therapy Gel",
                      style: FontStyle.fontStyleW600(
                        fontSize: 14,
                        fontColor: AppColors.yellowTitle,
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "${EnumLocale.txtTotal.name.tr} : ",
                      style: FontStyle.fontStyleW400(
                        fontSize: 14,
                        fontColor: AppColors.white,
                      ),
                      children: [
                        TextSpan(text: "₹ 167.00", style: FontStyle.fontStyleW600(
                          fontSize: 16,
                          fontColor: AppColors.white,
                        ),),
                      ],
                    ),
                  ),
                ],
              ).paddingOnly(left: 10.0, right:10.0, top: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("35 g", style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.white,
                  ),),
                  Row(
                    children: [
                      _counter > 0 ?
                      InkWell(
                        onTap: _decrementCounter,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.addButton,
                          child: const Icon(Icons.remove, color: Colors.white),
                        ),
                      ) : SizedBox(),
                      _counter > 0 ?
                      Text(
                        "$_counter",
                        style: FontStyle.fontStyleW500(
                          fontSize: 15,
                          fontColor: AppColors.white),
                      ).paddingOnly(left: 5.0, right: 5.0) : SizedBox(),
                      InkWell(
                        onTap: _incrementCounter,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.addButton,
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          EnumLocale.txtRemove.name.tr,
                          style: FontStyle.fontStyleW500(
                            fontSize: 14,
                            fontColor: AppColors.primaryAppColor1,
                          ),),
                      ),
                    ],
                  )
                ],
              ).paddingOnly(left: 10.0, right:10.0, top:8.0, bottom: 10.0),
            ],
          ),
        ).paddingOnly(top: 10.0);
      },
    );
  }
}

class MyCartBottomView extends StatelessWidget {
  const MyCartBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        color: AppColors.containerBg,
      ),
      child:  Container(
        height: MediaQuery.sizeOf(context).height * 0.33,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: AppColors.containerBg,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  EnumLocale.txtBloodGlucoseTest.name.tr,
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  '₹ 2350',
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top: 20, left: 15, right: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  EnumLocale.txtCortisolTest.name.tr,
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  '₹ 1475',
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top: 10, left: 15, right: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${EnumLocale.txtGst.name.tr} (18%)',
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  '₹ 1475',
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top: 10, left: 15, right: 15),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 0.50,
              color: AppColors.dividerGrey2,
            ).paddingOnly(top: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  EnumLocale.txtTotal.name.tr,
                  style: FontStyle.fontStyleW600(
                    fontSize: 16,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                Text(
                  '₹ 1475',
                  style: FontStyle.fontStyleW600(
                    fontSize: 16,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ],
            ).paddingOnly(top: 10, left: 15, right: 15),
            GetBuilder<ConfirmBookingController>(
                id: Constant.idProgressView,
                builder: (logic) {
                return PrimaryAppButton(
                        onTap: () {
                          // if (/*walletAmount!*/300< (logic.withDiscountAmount ?? 0)) {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return const ConfirmBookingBottomSheetView(isRecharge: false);
                            },
                          );
                          // }
                        },
                        height: Get.height * 0.06,
                        width: Get.width * 0.90,
                        borderRadius: 11,
                        gradientColor: [
                          AppColors.primaryAppColor1,
                          AppColors.primaryAppColor1
                        ],
                        text: EnumLocale.txtPayNow.name.tr,
                        textStyle: FontStyle.fontStyleW600(
                          fontSize: 16,
                          fontColor: AppColors.white,
                        ),
                      ).paddingOnly(top: 20.0, bottom: 15.0);
              }
            ),
          ],
        ),
      ),
    );
  }
}
