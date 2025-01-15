import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor/utils/font_style.dart';
import '../../../custom/no_data_found/no_data_found.dart';
import '../../../custom/waveClipper/wave_clipper.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/constant.dart';
import '../../../utils/enums.dart';
import '../../../utils/shimmers.dart';
import '../controller/membership_controller.dart';

/// =================== List View =================== ///
class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.34,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(AppAsset.icPhone, height: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      "+91 91677 29733",
                                      style: FontStyle.fontStyleW500(
                                        fontSize: 11,
                                        fontColor: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 2.0),
                                Row(
                                  children: [
                                    Image.asset(AppAsset.icWeb, height: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      "www.atmaprimehealthcare.com",
                                      style: FontStyle.fontStyleW500(
                                        fontSize: 11,
                                        fontColor: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 2.0),
                                Row(
                                  children: [
                                    Image.asset(AppAsset.icMail, height: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      "atmamembership@gmail.com",
                                      style: FontStyle.fontStyleW500(
                                        fontSize: 11,
                                        fontColor: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 2.0),
                              ],
                            ).paddingOnly(left: 8, top: 10, right: 3),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                  ),
                                  color: AppColors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      style: FontStyle.fontStyleW600(
                                        fontSize: 12,
                                        fontColor: AppColors.primaryAppColor1,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Metabolic Health Warrior",
                                      style: FontStyle.fontStyleW400(
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
                    /*   Stack(
                      children: [
                        // Background Wave
                        Positioned(
                          bottom: 0,
                          child: ClipPath(
                            clipper: WaveClipper(),
                            child: Container(
                              height: 80,
                              width: 350,
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo and Header
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Logo Section
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Any\nTime\nMedical\nAssistance",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  // Main Title
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ATMA PRIME",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Healthcare",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              // User Name and Club Info
                              Text(
                                "RAM",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "ATMA ‘SMART’ Club",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Metabolic Health Warrior",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Spacer(),
                              // Footer Info
                              //changed to column from row
                              Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.phone, size: 16),
                                      SizedBox(width: 5),
                                      Text("9167279733",
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.web, size: 16),
                                      SizedBox(width: 5),
                                      Text(
                                        "www.atmaprimehealthcare.com",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.email, size: 16),
                                      SizedBox(width: 5),
                                      Text("atmamembership@gmail.com",
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),*/
                  ).paddingOnly(left: 15.0, right: 15.0),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.26,
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
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ATMA PRIME ID No. -",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ),
                              Text(
                                "Member's Name",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ).paddingOnly(top: 7.0),
                              Text(
                                "Age",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ).paddingOnly(top: 7.0),
                              Text(
                                "Contact No. -",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ).paddingOnly(top: 7.0),
                              Text(
                                "Email Id -",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ).paddingOnly(top: 7.0),

                            ],
                          ).paddingOnly(left: 10.0, bottom: 10.0, top: 10.0),
                        ).paddingOnly(left: 10.0, right: 10.0, top: 16.0),
                      ],
                    ),
                  ).paddingOnly(left: 15.0, right: 15.0),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.34,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(AppAsset.icPhone, height: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      "+91 91677 29733",
                                      style: FontStyle.fontStyleW500(
                                        fontSize: 11,
                                        fontColor: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 2.0),
                                Row(
                                  children: [
                                    Image.asset(AppAsset.icWeb, height: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      "www.atmaprimehealthcare.com",
                                      style: FontStyle.fontStyleW500(
                                        fontSize: 11,
                                        fontColor: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 2.0),
                                Row(
                                  children: [
                                    Image.asset(AppAsset.icMail, height: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      "atmamembership@gmail.com",
                                      style: FontStyle.fontStyleW500(
                                        fontSize: 11,
                                        fontColor: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 2.0),
                              ],
                            ).paddingOnly(left: 8, top: 10, right: 3),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                  ),
                                  color: AppColors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "PAM",
                                      style: TextStyle(
                                        fontFamily: "Cooper black",
                                        fontSize: 14,
                                        color: AppColors.greenCardText,
                                      ),
                                    ),
                                    Text(
                                      "ATMA ‘SMART CLUB",
                                      style: FontStyle.fontStyleW600(
                                        fontSize: 12,
                                        fontColor: AppColors.primaryAppColor1,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Metabolic Health Warrior",
                                      style: FontStyle.fontStyleW400(
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
                    /*   Stack(
                      children: [
                        // Background Wave
                        Positioned(
                          bottom: 0,
                          child: ClipPath(
                            clipper: WaveClipper(),
                            child: Container(
                              height: 80,
                              width: 350,
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo and Header
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Logo Section
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Any\nTime\nMedical\nAssistance",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  // Main Title
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ATMA PRIME",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Healthcare",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              // User Name and Club Info
                              Text(
                                "RAM",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "ATMA ‘SMART’ Club",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Metabolic Health Warrior",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Spacer(),
                              // Footer Info
                              //changed to column from row
                              Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.phone, size: 16),
                                      SizedBox(width: 5),
                                      Text("9167279733",
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.web, size: 16),
                                      SizedBox(width: 5),
                                      Text(
                                        "www.atmaprimehealthcare.com",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.email, size: 16),
                                      SizedBox(width: 5),
                                      Text("atmamembership@gmail.com",
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),*/
                  ).paddingOnly(left: 15.0, right: 15.0),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.26,
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
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ATMA PRIME ID No. -",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ),
                              Text(
                                "Member's Name",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ).paddingOnly(top: 7.0),
                              Text(
                                "Age",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ).paddingOnly(top: 7.0),
                              Text(
                                "Contact No. -",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ).paddingOnly(top: 7.0),
                              Text(
                                "Email Id -",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 12,
                                  fontColor: AppColors.black,
                                ),
                              ).paddingOnly(top: 7.0),

                            ],
                          ).paddingOnly(left: 10.0, bottom: 10.0, top: 10.0),
                        ).paddingOnly(left: 10.0, right: 10.0, top: 16.0),
                      ],
                    ),
                  ).paddingOnly(left: 15.0, right: 15.0),
                ],
              );
      },
    );
  }
}


/// =================== Button =================== ///
class MembershipCardDownloadButton extends StatelessWidget {
  const MembershipCardDownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryAppButton(
      height: Get.height * 0.06,
      width: Get.width * 0.63,
      borderRadius: 11,
      color: AppColors.containerBlue,
      text: "Download Card",
      textStyle: FontStyle.fontStyleW500(
        fontSize: 15,
        fontColor: AppColors.white,
      ),
    ).paddingOnly(top:20.0, bottom: 20.0);
  }
}
