// =================== App Bar =================== ///
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:doctor/utils/font_style.dart';

class EventsBarView extends StatelessWidget {
  const EventsBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtEvents.name.tr,
      showLeadingIcon: true,
    );
  }
}

class LiveEventsListView extends StatelessWidget {
  const LiveEventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        scrollDirection: Axis.vertical,
        itemCount: 1,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.3),
                    spreadRadius: 0.1,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(width: 100, AppAsset.liveEventImg)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3rd International Research",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 14,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Speaker : ${"Dr. Anmol"}",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13,
                                  fontColor: AppColors.black,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Organised by : ${"AIIHPC"}",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13,
                                  fontColor: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text(
                            "16 August 2024 | 12:00 PM",
                            style: FontStyle.fontStyleW500(
                              fontSize: 12,
                              fontColor: AppColors.dateRedColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryAppColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(40, 32),
                          ),
                            onPressed: () {},
                            child: Text(
                              EnumLocale.txtJoinNow.name.tr,
                              style: FontStyle.fontStyleW500(
                                fontSize: 12,
                                fontColor: AppColors.white,
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class UpcomingEventsListView extends StatelessWidget {
  const UpcomingEventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        scrollDirection: Axis.vertical,
        itemCount: 1,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.3),
                    spreadRadius: 0.1,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(width: 100, AppAsset.liveEventImg)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3rd International Research",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 14,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Speaker : ${"Dr. Anmol"}",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13,
                                  fontColor: AppColors.black,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Organised by : ${"AIIHPC"}",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13,
                                  fontColor: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text(
                            "16 August 2024 | 12:00 PM",
                            style: FontStyle.fontStyleW500(
                              fontSize: 12,
                              fontColor: AppColors.dateRedColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryAppColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(40, 32),
                          ),
                            onPressed: () {},
                            child: Text(
                             EnumLocale.txtRemindMe.name.tr,
                              style: FontStyle.fontStyleW500(
                                fontSize: 12,
                                fontColor: AppColors.white,
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class EventsToWatchListView extends StatelessWidget {
  const EventsToWatchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        scrollDirection: Axis.vertical,
        itemCount: 2,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.3),
                    spreadRadius: 0.1,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(width: 100, AppAsset.liveEventImg)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3rd International Research",
                                style: FontStyle.fontStyleW600(
                                  fontSize: 14,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "${EnumLocale.txtSpeaker.name.tr} : ${"Dr. Anmol"}",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13,
                                  fontColor: AppColors.black,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "${EnumLocale.txtOrgBy.name.tr} : ${"AIIHPC"}",
                                style: FontStyle.fontStyleW500(
                                  fontSize: 13,
                                  fontColor: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text(
                            "16 August 2024 | 12:00 PM",
                            style: FontStyle.fontStyleW500(
                              fontSize: 12,
                              fontColor: AppColors.dateRedColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryAppColor1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(40, 32),
                            ),
                            onPressed: () {},
                            child: Text(
                              EnumLocale.txtWatchNow.name.tr,
                              style: FontStyle.fontStyleW500(
                                fontSize: 12,
                                fontColor: AppColors.white,
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

