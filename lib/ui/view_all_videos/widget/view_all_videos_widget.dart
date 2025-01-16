import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllVideosAppBarView extends StatelessWidget {
  const ViewAllVideosAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Videos From Experts",
      showLeadingIcon: true,
    );
  }
}

class ViewAllVideosItemView extends StatelessWidget {
  const ViewAllVideosItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.videoPlayer);
          },
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.yogaImg),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.redButtonColor,
                ),
                child: Icon(Icons.play_arrow, color: AppColors.iconColor),
              ),
            ),
          )
        );
        },
    );
  }
}

