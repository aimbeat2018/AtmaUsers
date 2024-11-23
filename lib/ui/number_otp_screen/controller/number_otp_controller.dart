import 'dart:async';
import 'dart:developer';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/add_number_screen/controller/add_number_controller.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/registration_screen/controller/registration_controller.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberOtpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  dynamic args = Get.arguments;

  String? number;
  String? dialCode;
  bool isLoading = false;
  Timer? timer;

  TextEditingController otpController = TextEditingController();
  RegistrationController registrationController = Get.find<RegistrationController>();
  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();
  AddNumberController addNumberController = Get.find<AddNumberController>();

  @override
  void onInit() async {
    await getDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    log("Verification Otp Args :: $args");

    if (args != null) {
      if (args[0] != null || args[1] != null) {
        number = args[0];
        dialCode = args[1];
      }

      log("Number :: $number");
      log("Dial Code :: $dialCode");
    }
    update([Constant.idProgressView]);
  }

  onResendOtpClick(BuildContext context) async {
    Utils.currentFocus(context);
    Utils.showToast(Get.context!, "Please check your SMS box");
    Constant.storage.write("isResendOtp", true);

    otpController.clear();
    addNumberController.verifyPhone();
  }

  onVerifyClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await verifyOTP(mobileNumber: number ?? "");

      try {
        isLoading = true;
        update([Constant.idProgressView]);

        await registrationController.onRegistrationApiCall(
          fcmToken: fcmToken ?? "",
          loginType: 3,
          email: "",
          password: "",
          name: "",
          mobile: number ?? "",
          country: country!,
          gender: "Female",
          dob: "",
        );

        if (registrationController.registrationModel?.status == true) {
          if (registrationController.registrationModel?.signup == true) {
            Constant.storage.write("isMobileLogin", true);
            Constant.storage.write("isSignUp", true);
            Constant.storage.write("isUpdate", false);
            Constant.storage.write("mobileNumber", registrationController.registrationModel?.user?.mobile);
            Constant.storage.write("userId", registrationController.registrationModel?.user?.id);

            Get.toNamed(AppRoutes.editProfile, arguments: [
              registrationController.registrationModel?.user?.name,
              registrationController.registrationModel?.user?.email,
              registrationController.registrationModel?.user?.mobile,
              registrationController.registrationModel?.user?.country,
              registrationController.registrationModel?.user?.gender,
              DateTime.now(),
            ]);
          } else {
            Constant.storage.write("isLogIn", true);
            Constant.storage.write("userId", registrationController.registrationModel?.user?.id);

            try {
              isLoading = true;
              update([Constant.idProgressView]);

              await profileScreenController.onGetUserProfileApiCall();

              if (profileScreenController.getUserProfileModel?.status == true) {
                Constant.storage.write("userName", profileScreenController.getUserProfileModel?.user?.name);
                Constant.storage.write("userEmail", profileScreenController.getUserProfileModel?.user?.email);
                Constant.storage.write("userImage", profileScreenController.getUserProfileModel?.user?.image);
                Constant.storage.write("mobileNumber", profileScreenController.getUserProfileModel?.user?.mobile);

                Get.offAllNamed(AppRoutes.bottom);
              } else {
                Utils.showToast(Get.context!, profileScreenController.getUserProfileModel?.message ?? "");
              }
            } catch (e) {
              log("Error in Registration Profile :: $e");
            } finally {
              isLoading = false;
              update([Constant.idProgressView]);
            }
          }
        } else {
          Utils.showToast(Get.context!, registrationController.registrationModel?.message ?? "");
        }
      } catch (e) {
        log("Error in Registration Profile ::: $e");
      } finally {
        isLoading = false;
        update([Constant.idProgressView]);
      }
    }
  }

  verifyOTP({required String mobileNumber}) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);
     /* PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: addNumberController.verificationCode,
        smsCode: otpController.text,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      log("User Credential :: $userCredential");*/
    } on FirebaseAuthException catch (e) {
      /*String errorMessage;

      switch (e.code) {
        case 'invalid-verification-code':
          errorMessage = "Invalid verification code. Please check and enter the correct verification code again.";
          break;
        case 'invalid-verification-id':
          errorMessage = "Invalid verification ID.";
          break;
        case 'session-expired':
          errorMessage = "Verification session has expired. Please try again.";
          break;
        case 'quota-exceeded':
          errorMessage = "SMS quota exceeded. Please try again later.";
          break;
        case 'missing-verification-code':
          errorMessage = "Verification code is missing.";
          break;
        case 'missing-verification-id':
          errorMessage = "Verification ID is missing.";
          break;
        case 'app-not-authorized':
          errorMessage = "App is not authorized to use Firebase Authentication.";
          break;
        case 'operation-not-allowed':
          errorMessage = "Phone authentication is not enabled.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Please try again later.";
          break;
        case 'credential-already-in-use':
          errorMessage = "The phone number is already linked to another account.";
          break;
        default:
          errorMessage = "An error occurred during OTP verification.";
      }

      Utils.showToast(Get.context!, errorMessage);
      log("Verify OTP Code :: ${e.code}");
      log("Verify OTP Message ::  ${e.message}");*/
      throw Exception("Error occurred during OTP verification");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
