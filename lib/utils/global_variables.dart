import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';

String? fcmToken;
String? country;
String? countryCode;
String? dialCode;
num? walletAmount;

int? zegoAppId;
String? zegoAppSignIn;

String? stripeSecretKey;
String? stripePublishKey;
String? razorpayId;
String? flutterWaveKey;
String? geminiKey;

String? currency;
String? currencyName;

bool? isRazorPay;
bool? isStripePay;
bool? isFlutterWave;

String? tnc;
String? privacyPolicyLink;

String? id;
String? couponId;

getDialCode() {
  CountryCode getCountryDialCode(String countryCode) {
    return CountryCode.fromCountryCode(countryCode);
  }

  CountryCode country = getCountryDialCode(countryCode ?? "IN");
  log("country.Dial code :: ${country.dialCode}");

  dialCode = country.dialCode;
  log("Dial code :: $dialCode");
}
