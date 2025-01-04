import 'package:doctor/ui/events/widget/events_widget.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:doctor/utils/font_style.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const EventsBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             IntrinsicHeight(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalDivider(
                indent: 14,
                endIndent: 2,
                thickness: 3,
                color: AppColors.primaryAppColor1,
              ).paddingOnly(left:15),
              Text(
                // EnumLocale.txtCategories.name.tr,
                "Live Events",
                style: FontStyle.fontStyleW500(
                  fontSize: 17,
                  fontColor: AppColors.black,
                ),
              ).paddingOnly(top: 15, left: 0, right: 15),
            ],
          ),
        ),
            LiveEventsListView(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  VerticalDivider(
                    indent: 14,
                    endIndent: 2,
                    thickness: 3,
                    color: AppColors.primaryAppColor1,
                  ).paddingOnly(left:15),
                  Text(
                    // EnumLocale.txtCategories.name.tr,
                    "Upcoming Events",
                    style: FontStyle.fontStyleW500(
                      fontSize: 17,
                      fontColor: AppColors.black,
                    ),
                  ).paddingOnly(top: 15, left: 0, right: 15),
                ],
              ),
            ),
            UpcomingEventsListView(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  VerticalDivider(
                    indent: 14,
                    endIndent: 2,
                    thickness: 3,
                    color: AppColors.primaryAppColor1,
                  ).paddingOnly(left:15),
                  Text(
                    // EnumLocale.txtCategories.name.tr,
                    "Events to Watch",
                    style: FontStyle.fontStyleW500(
                      fontSize: 17,
                      fontColor: AppColors.black,
                    ),
                  ).paddingOnly(top: 15, left: 0, right: 15),
                ],
              ),
            ),
            EventsToWatchListView(),
          ],
        ),
      ),
    );
  }
}

