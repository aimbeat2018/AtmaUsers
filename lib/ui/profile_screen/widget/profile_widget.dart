import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/custom/app_bar/custom_app_bar.dart';
import 'package:doctor/custom/dialog/delete_account_dialog.dart';
import 'package:doctor/custom/dialog/log_out_dialog.dart';
import 'package:doctor/custom/profile/profile_custom_title.dart';
import 'package:doctor/custom/profile/profile_menu.dart';
import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';

/// =================== App Bar =================== ///
class ProfileAppBarView extends StatelessWidget {
  const ProfileAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyProfile.name.tr,
      showLeadingIcon: false,
    );
  }
}

/// =================== Information =================== ///
class ProfileInfoView extends StatelessWidget {
  const ProfileInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                offset: const Offset(
                  0.8,
                  0.8,
                ),
                blurRadius: 5.0,
              ),
            ],
            color: AppColors.white,
          ),
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.13,
                width: Get.width * 0.27,
                margin: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: AppColors.placeholder,
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: Constant.storage.read("userImage") ??
                      logic.getUserProfileModel?.user?.image ??
                      "${ApiConstant.BASE_URL}storage/male.png",
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Image.asset(AppAsset.icUserPlaceholder, color: AppColors.user).paddingAll(10);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppAsset.icUserPlaceholder, color: AppColors.user).paddingAll(10);
                  },
                ),
              ),
              Container(
                height: Get.height * 0.12,
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Constant.storage.read("userName") ?? logic.getUserProfileModel?.user?.name ?? "",
                      style: FontStyle.fontStyleW700(
                        fontSize: 16,
                        fontColor: AppColors.title,
                      ),
                    ),
                    Text(
                      Constant.storage.read("userEmail") ?? logic.getUserProfileModel?.user?.email ?? "",
                      style: FontStyle.fontStyleW500(
                        fontSize: 14,
                        fontColor: AppColors.degreeText,
                      ),
                    ),
                    InkWell(
                      overlayColor: WidgetStatePropertyAll(AppColors.transparent),
                      onTap: () {
                        Get.toNamed(AppRoutes.editProfile, arguments: [
                          logic.getUserProfileModel?.user?.name,
                          logic.getUserProfileModel?.user?.email,
                          logic.getUserProfileModel?.user?.mobile,
                          logic.getUserProfileModel?.user?.country,
                          logic.getUserProfileModel?.user?.gender,
                          logic.getUserProfileModel?.user?.dob,
                        ]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.specialistBox,
                          borderRadius: BorderRadius.circular(46),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Image.asset(
                                AppAsset.icEditProfile,
                                height: 20,
                              ),
                              VerticalDivider(
                                thickness: 1.5,
                                color: AppColors.verticalBorder,
                              ),
                              Text(
                                EnumLocale.txtEditProfile.name.tr,
                                style: FontStyle.fontStyleW600(
                                  fontSize: 13,
                                  fontColor: AppColors.specialist,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(top: 15, bottom: 15)
            ],
          ),
        );
      },
    );
  }
}

/// =================== General =================== ///
class ProfileGeneralView extends StatelessWidget {
  const ProfileGeneralView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileCustomTitle(
      title: EnumLocale.txtGeneral.name.tr,
      widget: Column(
        children: [
          ProfileMenu(
            image: AppAsset.icWalletOutline,
            text: EnumLocale.txtMyWallet.name.tr,
            isArrow: true,
            onTap: () {
              Get.toNamed(AppRoutes.myWallet);
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          ProfileMenu(
            image: AppAsset.icSaved,
            text: EnumLocale.txtSavedDoctor.name.tr,
            isArrow: true,
            onTap: () {
              Get.toNamed(AppRoutes.savedDoctor);
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          ProfileMenu(
            image: AppAsset.icAppointmentOutline,
            text: EnumLocale.txtMyAppointment.name.tr,
            isArrow: true,
            onTap: () {
              Get.toNamed(AppRoutes.myAppointment);
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          ProfileMenu(
            image: AppAsset.icAddPatient,
            text: "Add Patients",
            isArrow: true,
            onTap: () {
              Get.toNamed(AppRoutes.addPatient);
            },
          ),
        ],
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== Account =================== ///
class ProfileAccountView extends StatelessWidget {
  const ProfileAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileCustomTitle(
      title: EnumLocale.txtAccount.name.tr,
      widget: Column(
        children: [
          GetBuilder<ProfileScreenController>(
            id: Constant.idSwitchOn,
            builder: (logic) {
              return ProfileMenu(
                image: AppAsset.icNotificationOutline,
                text: EnumLocale.txtPushNotification.name.tr,
                isArrow: false,
                leading: Switch(
                  value: logic.isSwitchOn,
                  activeColor: AppColors.green,
                  activeTrackColor: AppColors.categoryCircle,
                  inactiveThumbColor: AppColors.notificationTitle2,
                  inactiveTrackColor: AppColors.categoryCircle,
                  trackOutlineColor: WidgetStatePropertyAll(AppColors.switchBorder),
                  trackColor: WidgetStatePropertyAll(AppColors.switchBox),
                  onChanged: (value) {
                    logic.onSwitch(value);
                  },
                ),
              );
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          ProfileMenu(
            image: AppAsset.icLanguage,
            text: EnumLocale.txtLanguage.name.tr,
            isArrow: true,
            onTap: () {
              Get.toNamed(AppRoutes.language);
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          GetBuilder<ProfileScreenController>(
            builder: (logic) {
              return ProfileMenu(
                image: AppAsset.icRate,
                text: EnumLocale.txtRateUs.name.tr,
                isArrow: true,
                onTap: () async {
                  logic.rateMyApp.reset();

                  logic.rateMyApp.init().then((_) {
                    logic.rateMyApp.showRateDialog(
                      context,
                      title: EnumLocale.txtRateThisApp.name.tr,
                      message: EnumLocale.desRateUs.name.tr,
                      rateButton: EnumLocale.txtRATE.name.tr,
                      noButton: EnumLocale.txtNoTHANKS.name.tr,
                      laterButton: EnumLocale.txtMayBeLater.name.tr,
                      listener: (button) {
                        switch (button) {
                          case RateMyAppDialogButton.rate:
                            log('Clicked on Rate');
                            break;
                          case RateMyAppDialogButton.later:
                            log('Clicked on Later');
                            break;
                          case RateMyAppDialogButton.no:
                            log('Clicked on No');
                            break;
                        }
                        return true;
                      },
                      dialogStyle: DialogStyle(
                        messageStyle: FontStyle.fontStyleW500(fontSize: 15, fontColor: AppColors.primaryAppColor1),
                        titleStyle: FontStyle.fontStyleW600(fontSize: 20, fontColor: AppColors.primaryAppColor1),
                        titleAlign: TextAlign.center,
                        dialogShape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onDismissed: () => logic.rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
                    );
                  });
                },
              );
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          ProfileMenu(
            image: AppAsset.icShare,
            text: EnumLocale.txtShareApp.name.tr,
            isArrow: true,
            onTap: () {
              if (Platform.isAndroid) {
                Share.share('http://play.google.com/store/apps/details?id=com.atma.patient');
              } else {}
            },
          ),
        ],
      ),
    ).paddingOnly(bottom: 20);
  }
}

/// =================== About =================== ///
class ProfileAboutView extends StatelessWidget {
  const ProfileAboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileCustomTitle(
      title: EnumLocale.txtAbout.name.tr,
      widget: Column(
        children: [
          ProfileMenu(
            image: AppAsset.icTerms,
            text: EnumLocale.txtTermsOfUse.name.tr,
            isArrow: true,
            onTap: () {
              Utils.launchURL(tnc ?? "");
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          ProfileMenu(
            image: AppAsset.icPolicy,
            text: EnumLocale.txtPrivacyPolicy.name.tr,
            isArrow: true,
            onTap: () {
              Utils.launchURL(privacyPolicyLink ?? "");
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.helpDesk);
            },
            child: ProfileMenu(
              image: AppAsset.icHelp,
              text: EnumLocale.txtHelpFAQ.name.tr,
              isArrow: true,
            ),
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          ProfileMenu(
            image: AppAsset.icLogOut,
            text: EnumLocale.txtLogOut.name.tr,
            isArrow: true,
            onTap: () {
              Get.dialog(
                barrierColor: AppColors.black.withOpacity(0.8),
                Dialog(
                  backgroundColor: AppColors.transparent,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  child: const LogOutDialog(),
                ),
              );
            },
          ),
          Divider(height: 1.5, color: AppColors.white).paddingOnly(top: 15, bottom: 15),
          GetBuilder<ProfileScreenController>(
            id: Constant.idProgressView,
            builder: (logic) {
              return ProfileMenu(
                onTap: () {
                  Get.dialog(
                    barrierColor: AppColors.black.withOpacity(0.8),
                    ProgressDialog(
                      inAsyncCall: logic.isLoading1,
                      child: Dialog(
                        backgroundColor: AppColors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        child: const DeleteAccountDialog(),
                      ),
                    ),
                  );
                },
                image: AppAsset.icDeleteAccount,
                text: EnumLocale.txtDeleteAccount.name.tr,
                isArrow: false,
                iconColor: AppColors.notificationTitle2,
                textColor: AppColors.notificationTitle2,
              );
            },
          ),
        ],
      ),
    );
  }
}
