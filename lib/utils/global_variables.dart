import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl/intl.dart';

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

int calculateAgeFromString(String dateString) {
  // Parse the string date into a DateTime object
  DateTime birthDate = DateFormat("yyyy-MM-dd").parse(dateString);
  final today = DateTime.now();
  int age = today.year - birthDate.year;

  // Check if the birthday hasn't occurred yet this year
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}
