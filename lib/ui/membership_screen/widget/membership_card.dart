import 'dart:io';

import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/shimmers.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/constant.dart';
import '../controller/membership_controller.dart';

/// =================== List View =================== ///
class MembershipCard extends StatefulWidget {
  MembershipCard({super.key});

  @override
  State<MembershipCard> createState() => _MembershipCardState();
}

class _MembershipCardState extends State<MembershipCard> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.getMembershipModel == null
            ? logic.isLoading
                ? Shimmers.membershipPackageShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataFound,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundPackage.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  ).paddingOnly(bottom: Get.height * 0.05, left: 15, right: 15)
            : Screenshot(
                controller: screenshotController,
                child: Column(
                  children: [
                    logic.getMembershipModel!.data!.title == "RAM Package"
                        ?
                        //Ram Card
                        Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.34,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: AssetImage(AppAsset.cardBgImg),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 50),
                                    Image.asset(AppAsset.icLogo, height: 80),
                                    Text(
                                      "ATMA PRIME HEALTHCARE",
                                      style: TextStyle(
                                        fontFamily: "Cooper black",
                                        fontSize: 14,
                                        color: AppColors.primaryAppColor1,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(AppAsset.icPhone,
                                                    height: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "+91 91677 29733",
                                                  style:
                                                      FontStyle.fontStyleW500(
                                                    fontSize: 11,
                                                    fontColor: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ).paddingOnly(top: 2.0),
                                            Row(
                                              children: [
                                                Image.asset(AppAsset.icWeb,
                                                    height: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "www.atmaprimehealthcare.com",
                                                  style:
                                                      FontStyle.fontStyleW500(
                                                    fontSize: 11,
                                                    fontColor: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ).paddingOnly(top: 2.0),
                                            Row(
                                              children: [
                                                Image.asset(AppAsset.icMail,
                                                    height: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "atmamembership@gmail.com",
                                                  style:
                                                      FontStyle.fontStyleW500(
                                                    fontSize: 11,
                                                    fontColor: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ).paddingOnly(top: 2.0),
                                          ],
                                        ).paddingOnly(
                                            left: 8, top: 10, right: 3),
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                              ),
                                              color: AppColors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "RAM",
                                                  style: TextStyle(
                                                    fontFamily: "Cooper black",
                                                    fontSize: 14,
                                                    color: AppColors.cardRed,
                                                  ),
                                                ),
                                                Text(
                                                  "ATMA ‘SMART CLUB",
                                                  style:
                                                      FontStyle.fontStyleW600(
                                                    fontSize: 12,
                                                    fontColor: AppColors
                                                        .primaryAppColor1,
                                                  ),
                                                ),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  "Metabolic Health Warrior",
                                                  style:
                                                      FontStyle.fontStyleW400(
                                                    fontSize: 11,
                                                    fontColor: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(top: 19),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ).paddingOnly(left: 15.0, right: 15.0),
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.26,
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: AssetImage(AppAsset.cardBgImg),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: "REVEREND",
                                        style: TextStyle(
                                          fontFamily: "Cooper black",
                                          fontSize: 14,
                                          color: AppColors.cardRed,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " ATMA MEMBERSHIP CARD",
                                            style: TextStyle(
                                              fontFamily: "Cooper black",
                                              fontSize: 14,
                                              color: AppColors.primaryAppColor1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).paddingOnly(top: 28),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ATMA PRIME ID No. - ${logic.getMembershipModel!.data!.packageId ?? "-"} ",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ),
                                          Text(
                                            "Member's Name - ${logic.getMembershipModel!.data!.userName ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ).paddingOnly(top: 7.0),
                                          Text(
                                            "Age - ${logic.getMembershipModel!.data!.age ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ).paddingOnly(top: 7.0),
                                          Text(
                                            "Contact No. - ${logic.getMembershipModel!.data!.userContact ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ).paddingOnly(top: 7.0),
                                          Text(
                                            "Email Id - ${logic.getMembershipModel!.data!.userEmail ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ).paddingOnly(top: 7.0),
                                        ],
                                      ).paddingOnly(
                                          left: 10.0, bottom: 10.0, top: 10.0),
                                    ).paddingOnly(
                                        left: 10.0, right: 10.0, top: 16.0),
                                  ],
                                ),
                              ).paddingOnly(left: 15.0, right: 15.0),
                            ],
                          )
                        :
                        //pam card
                        Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.34,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: AssetImage(AppAsset.cardBgImg),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 50),
                                    Image.asset(AppAsset.icLogo, height: 80),
                                    Text(
                                      "ATMA PRIME HEALTHCARE",
                                      style: TextStyle(
                                        fontFamily: "Cooper black",
                                        fontSize: 14,
                                        color: AppColors.primaryAppColor1,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(AppAsset.icPhone,
                                                    height: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "+91 91677 29733",
                                                  style:
                                                      FontStyle.fontStyleW500(
                                                    fontSize: 11,
                                                    fontColor: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ).paddingOnly(top: 2.0),
                                            Row(
                                              children: [
                                                Image.asset(AppAsset.icWeb,
                                                    height: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "www.atmaprimehealthcare.com",
                                                  style:
                                                      FontStyle.fontStyleW500(
                                                    fontSize: 11,
                                                    fontColor: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ).paddingOnly(top: 2.0),
                                            Row(
                                              children: [
                                                Image.asset(AppAsset.icMail,
                                                    height: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "atmamembership@gmail.com",
                                                  style:
                                                      FontStyle.fontStyleW500(
                                                    fontSize: 11,
                                                    fontColor: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ).paddingOnly(top: 2.0),
                                          ],
                                        ).paddingOnly(
                                            left: 8, top: 10, right: 3),
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                              ),
                                              color: AppColors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "PAM",
                                                  style: TextStyle(
                                                    fontFamily: "Cooper black",
                                                    fontSize: 14,
                                                    color:
                                                        AppColors.greenCardText,
                                                  ),
                                                ),
                                                Text(
                                                  "ATMA ‘SMART CLUB",
                                                  style:
                                                      FontStyle.fontStyleW600(
                                                    fontSize: 12,
                                                    fontColor: AppColors
                                                        .primaryAppColor1,
                                                  ),
                                                ),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  "Metabolic Health Warrior",
                                                  style:
                                                      FontStyle.fontStyleW400(
                                                    fontSize: 11,
                                                    fontColor: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(top: 19),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ).paddingOnly(left: 15.0, right: 15.0),
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.26,
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: AssetImage(AppAsset.cardBgImg),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: "PRIVILEGE",
                                        style: TextStyle(
                                          fontFamily: "Cooper black",
                                          fontSize: 14,
                                          color: AppColors.greenCardText,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " ATMA MEMBERSHIP CARD",
                                            style: TextStyle(
                                              fontFamily: "Cooper black",
                                              fontSize: 14,
                                              color: AppColors.primaryAppColor1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).paddingOnly(top: 28),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ATMA PRIME ID No. - ${logic.getMembershipModel!.data!.membershipId ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ),
                                          Text(
                                            "Member's Name - ${logic.getMembershipModel!.data!.userName ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ).paddingOnly(top: 7.0),
                                          Text(
                                            "Age - ${logic.getMembershipModel!.data!.age ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ).paddingOnly(top: 7.0),
                                          Text(
                                            "Contact No. - ${logic.getMembershipModel!.data!.userContact ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ).paddingOnly(top: 7.0),
                                          Text(
                                            "Email Id - ${logic.getMembershipModel!.data!.userEmail ?? "-"}",
                                            style: FontStyle.fontStyleW500(
                                              fontSize: 12,
                                              fontColor: AppColors.black,
                                            ),
                                          ).paddingOnly(top: 7.0),
                                        ],
                                      ).paddingOnly(
                                          left: 10.0, bottom: 10.0, top: 10.0),
                                    ).paddingOnly(
                                        left: 10.0, right: 10.0, top: 16.0),
                                  ],
                                ),
                              ).paddingOnly(left: 15.0, right: 15.0),
                            ],
                          ),
                    PrimaryAppButton(
                      onTap: () async {
                        await screenshotController
                            .capture(delay: const Duration(milliseconds: 10))
                            .then((image) async {
                          if (image != null) {
                            final directory =
                                await getApplicationDocumentsDirectory();
                            final imagePath = await File(
                                    '${directory.path}/privilege_card.png')
                                .create();
                            await imagePath.writeAsBytes(image);
                            await Gal.putImage(imagePath.path);
                            Utils.showToast(
                              Get.context!,
                              "Privilege card downloaded and saved in the gallery",
                            );
                          }
                        });
                      },
                      height: Get.height * 0.06,
                      width: Get.width * 0.63,
                      borderRadius: 11,
                      color: AppColors.containerBlue,
                      text: "Download Card",
                      textStyle: FontStyle.fontStyleW500(
                        fontSize: 15,
                        fontColor: AppColors.white,
                      ),
                    ).paddingOnly(top: 30.0, bottom: 20.0),
                  ],
                ),
              );
      },
    );
  }
}
