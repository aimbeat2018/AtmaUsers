import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/app_button/primary_app_button.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnAppBarView extends StatelessWidget {
  const ReferAndEarnAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Refer and Earn" /*EnumLocale.txtMyProfile.name.tr*/,
      showLeadingIcon: true,
    );
  }
}

class ReferAndEarnImageView extends StatelessWidget {
  const ReferAndEarnImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAsset.referAndEarnImg,
    ).paddingOnly(left: 30, right: 30, top: 50);
  }
}

class ReferAndEarnCodeView extends StatelessWidget {
  ReferAndEarnCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(const ClipboardData(text: "123")); //replace with code
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [
              AppColors.primaryAppColor1,
              AppColors.lightBlue1,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "AS12QWR45f4",
              style: FontStyle.fontStyleW600(
                fontSize: 16,
                fontColor: AppColors.white,
              ),
            ),
            Text(
              "Copy".toUpperCase(),
              style: FontStyle.fontStyleW500(
                fontSize: 14,
                fontColor: AppColors.white,
              ),
            ),
          ],
        ),
      ).paddingOnly(left: 25.0, right: 25.0, top: 30.0),
    );
  }
}

class InviteFriendsView extends StatelessWidget {
   const InviteFriendsView({super.key});

 final String appShareMessage =
      "I'm inviting you to use ${"ATMA"}, a simple and easy app for medical consultation. Here's my code [CODE] "
      "- just enter it while registration.";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        inviteFriendShareMessage();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.addButton,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAsset.icInvite, height: 20),
            const SizedBox(width: 10),
            Text(
              "Invite a Friend",
              style: FontStyle.fontStyleW500(
                fontSize: 14,
                fontColor: AppColors.white,
              ),
            ),
          ],
        ),
      ).paddingOnly(left: 25.0, right: 25.0, top: 20.0),
    );
  }
  inviteFriendShareMessage({int? callId}) {
    try {
     /* if (callId == 0) {
        Share.share(
            'Hi! Use my refer code ${123} to signup in ${"ATMA"} app. You will get some wallet points on successfull sign up. \nAndroid Play Store link - ${""} \nIOS App store link - ${""}');
      } else {*/
        Share.share(appShareMessage.replaceAll("[CODE]", "${"123"}"));
      // }
    } catch (e) {
      debugPrint(
          "Exception -  business_rule.dart - inviteFriendShareMessage():$e");
    }
  }
}
