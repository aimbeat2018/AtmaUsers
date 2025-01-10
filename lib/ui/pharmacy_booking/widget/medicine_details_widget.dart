import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class MedicineDetailsAppBarView extends StatelessWidget {
  const MedicineDetailsAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMedicineDetails.name.tr,
      showLeadingIcon: true,
    );
  }
}

class MedicineImageView extends StatelessWidget {
  const MedicineImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.containerBg,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          )),
      child: Image.asset(AppAsset.medicineImg1, height: 70.0),
    );
  }
}

class MedicineAddToCart extends StatefulWidget {
  const MedicineAddToCart({super.key});

  @override
  State<MedicineAddToCart> createState() => _MedicineAddToCartState();
}

class _MedicineAddToCartState extends State<MedicineAddToCart> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Crocin Advance (500 mg)",
          style: FontStyle.fontStyleW600(
            fontSize: 18,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingOnly(top: 20, left: 15),
        Text(
          "1 strip of 20 Tablets",
          style: FontStyle.fontStyleW600(
            fontSize: 14,
            fontColor: AppColors.black,
          ),
        ).paddingOnly(top: 5, left: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "₹ 45.60",
                    style: FontStyle.fontStyleW600(
                      fontSize: 18,
                      fontColor: AppColors.black,
                    ),
                  ).paddingOnly(left: 10.0, top: 5.0),
                  Text(
                    "₹ 50.00",
                    style: FontStyle.fontStyleW500(
                      fontSize: 15,
                      fontColor: AppColors.black,
                      textDecoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.black,
                    ),
                  ).paddingOnly(left: 10.0, top: 5.0),
                ],
              ).paddingOnly(top: 10.0, left: 5.0),
            ),
            Row(
              children: [
                _counter > 0
                    ? IconButton(
                        icon: Icon(Icons.remove_circle,
                            color: AppColors.addButton, size: 30),
                        onPressed: _decrementCounter,
                      )
                    : SizedBox(),
                Text(
                  "$_counter",
                  style: FontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.black,
                    decorationColor: AppColors.black,
                  ),
                ).paddingOnly(top: 5.0),
                IconButton(
                  icon: Icon(Icons.add_circle,
                      color: AppColors.addButton, size: 30),
                  onPressed: _incrementCounter,
                ),
              ],
            ).paddingOnly(top: 10.0, left: 5.0),
          ],
        ),
        Center(
          child: PrimaryAppButton(
            onTap: () {
              Get.toNamed(AppRoutes.myCart);
            },
            height: Get.height * 0.062,
            width: Get.width * 0.92,
            borderRadius: 11,
            gradientColor: [
              AppColors.primaryAppColor1,
              AppColors.primaryAppColor2
            ],
            widget: RichText(
              text: TextSpan(
                text: '${EnumLocale.txtAddToCart.name.tr} ',
                style: FontStyle.fontStyleW500(
                  fontSize: 16,
                  fontColor: AppColors.white,
                ),
              ),
            ),
          ).paddingOnly(top: 10, left: 10, right: 10),
        ),
      ],
    );
  }
}

class MedicineDescription extends StatelessWidget {
  const MedicineDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocale.txtBrandName.name.tr,
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
                Text(
                  "Crocin",
                  style: FontStyle.fontStyleW600(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocale.txtGenericName.name.tr,
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
                Text(
                  "Paracetamol",
                  style: FontStyle.fontStyleW600(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ).paddingOnly(top: 20, left: 10, right: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocale.txtDoseWith.name.tr,
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
                Text(
                  "Crocin",
                  style: FontStyle.fontStyleW600(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocale.txtPackages.name.tr,
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
                Text(
                  "Paracetamol",
                  style: FontStyle.fontStyleW600(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ).paddingOnly(top: 20, left: 10, right: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocale.txtCompany.name.tr,
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
                Text(
                  "Crocin",
                  style: FontStyle.fontStyleW600(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocale.txtPrescription.name.tr,
                  style: FontStyle.fontStyleW400(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
                Text(
                  "Paracetamol",
                  style: FontStyle.fontStyleW600(
                    fontSize: 14,
                    fontColor: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ).paddingOnly(top: 20, left: 10, right: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              EnumLocale.txtMedicineType.name.tr,
              style: FontStyle.fontStyleW400(
                fontSize: 14,
                fontColor: AppColors.black,
              ),
            ),
            Text(
              "Tablet",
              style: FontStyle.fontStyleW600(
                fontSize: 14,
                fontColor: AppColors.black,
              ),
            ),
          ],
        ).paddingOnly(top: 20, left: 10, right: 10),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalDivider(
                indent: 14,
                endIndent: 2,
                thickness: 3,
                color: AppColors.primaryAppColor1,
              ).paddingOnly(left: 8),
              Text(
                EnumLocale.txtProductDescrp.name.tr,
                style: FontStyle.fontStyleW600(
                  fontSize: 17,
                  fontColor: AppColors.black,
                ),
              ).paddingOnly(top: 30, left: 0),
            ],
          ),
        ),
        Text(
          "Crocin Advance 500mg Tablet helps relieve pain and fever by blocking the release"
          " of certain chemical messengers responsible for fever and pain. It is used to treat headaches,"
          " migraine, toothaches, sore throats, period (menstrual) pains, arthritis, muscle aches, "
          "and the common cold",
          style: FontStyle.fontStyleW400(
            fontSize: 14,
            fontColor: AppColors.black,
          ),
        ).paddingOnly(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
      ],
    );
  }
}
