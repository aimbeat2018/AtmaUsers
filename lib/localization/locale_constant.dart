import 'dart:developer';
import 'dart:ui';

import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/preference.dart';

Future<Locale> getLocale() async {
  String languageCode = Preference.shared.getString(Preference.selectedLanguage) ?? Constant.languageEn;
  String countryCode = Preference.shared.getString(Preference.selectedCountryCode) ?? Constant.countryCodeEn;
  log("getLocale Updated $languageCode   $countryCode");
  return _locale(languageCode, countryCode);
}

Locale _locale(String languageCode, String countryCode) {
  return languageCode.isNotEmpty ? Locale(languageCode, countryCode) : const Locale(Constant.languageEn, Constant.countryCodeEn);
}
