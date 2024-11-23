import 'dart:developer';

import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNumberController extends GetxController {
  String selectedCountryCode = dialCode ?? "+91";
  String verificationCode = "";
  bool verification = false;

  TextEditingController numberController = TextEditingController();

  onCheckMobile() {
    if (numberController.text.isNotEmpty) {
      Constant.storage.write('mobileNumber', numberController.text);

      verifyPhone();
      onVerification();
    } else {
      Utils.showToast(Get.context!, EnumLocale.toastEnterNumber.name.tr);
    }
    update([Constant.idCheckMobile]);
  }

  onVerification() {
    verification = true;
    log("Verification == $verification");
    update([Constant.idVerification]);
  }

  void verifyPhone() async {
    log('---- number ---- ${numberController.text}');
    log('---- number ---- $selectedCountryCode ${numberController.text}');
    verificationCode = '123456';

    /*await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$dialCode ${numberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        String errorMessage;

        switch (e.code) {
          case 'invalid-verification-code':
            errorMessage = "Invalid verification code.";
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
        log("Mobile number Verification :: ${e.code}");
        log("Mobile number verification :: ${e.message}");
      },
      codeSent: (String verificationID, int? resendToken) {
        verificationCode = verificationID;
      },
      codeAutoRetrievalTimeout: (String verificationID) {},
    );*/
  }

  onContinueClick() {
    onCheckMobile();
    update([Constant.idCheckMobile]);
  }
}
