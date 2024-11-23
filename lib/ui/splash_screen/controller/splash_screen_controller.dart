import 'dart:convert';
import 'dart:developer';

import 'package:doctor/custom/dialog/app_maintenance_dialog.dart';
import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/services/app_exception.dart';
import 'package:doctor/services/notification_services/notification_services.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/splash_screen/model/get_country_model.dart';
import 'package:doctor/ui/splash_screen/model/get_setting_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  @override
  void onInit() async {
    await onGetCountryApiCall();

    onRoutes();
    NotificationServices.initFirebase();

    super.onInit();
  }

  onRoutes() async {
    await onGeSettingApiCall();
    getDialCode();

    if (getSettingModel?.status == true) {
      zegoAppId = int.parse(getSettingModel?.setting?.zegoAppId ?? "");
      zegoAppSignIn = getSettingModel?.setting?.zegoAppSignIn;
      stripeSecretKey = getSettingModel?.setting?.stripeSecretKey;
      stripePublishKey = getSettingModel?.setting?.stripePublishableKey;
      razorpayId = getSettingModel?.setting?.razorPayId;
      flutterWaveKey = getSettingModel?.setting?.flutterWaveKey;
      currency = getSettingModel?.setting?.currencySymbol;
      currencyName = getSettingModel?.setting?.currencyName;
      isRazorPay = getSettingModel?.setting?.isRazorPay;
      isStripePay = getSettingModel?.setting?.isStripePay;
      isFlutterWave = getSettingModel?.setting?.isFlutterWave;
      tnc = getSettingModel?.setting?.tnc;
      privacyPolicyLink = getSettingModel?.setting?.privacyPolicyLink;
      geminiKey = getSettingModel?.setting?.geminiKey;

      log("Zego App Id :: $zegoAppId");
      log("Zego App SignIn :: $zegoAppSignIn");
      log("Stripe Secret Key :: $stripeSecretKey");
      log("Stripe Publish Key :: $stripePublishKey");
      log("Razorpay Id :: $razorpayId");
      log("Flutter Wave Key :: $flutterWaveKey");
      log("Currency :: $currency");
      log("Currency Name :: $currencyName");
      log("Is Razor Pay :: $isRazorPay");
      log("Is Stripe Pay :: $isStripePay");
      log("Is Flutter Wave :: $isFlutterWave");
      log("T&C :: $tnc");
      log("Privacy Policy Link :: $privacyPolicyLink");
      log("Gemini Key :: $geminiKey");

      if (getSettingModel?.setting?.maintenanceMode == true) {
        Get.dialog(
          barrierColor: AppColors.black.withOpacity(0.8),
          barrierDismissible: false,
          Dialog(
            backgroundColor: AppColors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            child: const AppMaintenanceDialog(),
          ),
        );
      } else {
        await profileScreenController.onGetUserProfileApiCall();

        if (profileScreenController.getUserProfileModel?.status == true) {
          Constant.storage.write("userName", profileScreenController.getUserProfileModel?.user?.name);
          Constant.storage.write("userEmail", profileScreenController.getUserProfileModel?.user?.email);
          Constant.storage.write("userImage", profileScreenController.getUserProfileModel?.user?.image);
          Constant.storage.write("mobileNumber", profileScreenController.getUserProfileModel?.user?.mobile);
        }

        Future.delayed(const Duration(seconds: 3), () async {
          log("Constant.storage.read :: ${Constant.storage.read("isUpdate")}");

          if (Constant.storage.read("isUpdate") == false) {
            Get.toNamed(AppRoutes.editProfile, arguments: [
              profileScreenController.getUserProfileModel?.user?.name,
              profileScreenController.getUserProfileModel?.user?.email,
              Constant.storage.read("mobileNumber"),
              profileScreenController.getUserProfileModel?.user?.country,
              profileScreenController.getUserProfileModel?.user?.gender,
              DateTime.now(),
            ]);
          } else {
            if (Constant.storage.read("isLogIn") == true) {
              Get.offAllNamed(AppRoutes.bottom);
            } else {
              Get.offAllNamed(AppRoutes.main);
            }
          }
        });
      }
    } else {
      Utils.showToast(Get.context!, getSettingModel?.message ?? "");
    }
  }

  /// =================== Get Country API Calling =================== ///

  GetCountryModel? getCountryModel;
  GetSettingModel? getSettingModel;
  bool isLoading = false;

  onGetCountryApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final url = Uri.parse("http://ip-api.com/json");
      log("Get Country Url :: $url");

      final headers = {'Content-Type': 'application/json'};
      log("Get Country Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Country Status Code :: ${response.statusCode}");
      log("Get Country Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCountryModel = GetCountryModel.fromJson(jsonResponse);

        country = getCountryModel?.country;
        countryCode = getCountryModel?.countryCode;
        log("The Country Name :: $country");
        log("The Country Code :: $countryCode");
      }

      log("Get Country Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Country Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }

  onGeSettingApiCall() async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getSetting);
      log("Get Setting Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Setting Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Setting Status Code :: ${response.statusCode}");
      log("Get Setting Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getSettingModel = GetSettingModel.fromJson(jsonResponse);
      }

      log("Get Setting Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Setting Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
