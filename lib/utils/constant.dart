import 'package:doctor/utils/app_asset.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Constant {
  /// =================== Id For Refresh Widgets =================== ///
  static var idProgressView = 'idProgressView';
  static var idBottomBar = 'idBottomBar';
  static var idDoctorSaved = 'idDoctorSaved';
  static var idEditDoctorSaved = 'idEditDoctorSaved';
  static var idCategoryDoctorSaved = 'idCategoryDoctorSaved';
  static var idTopSpecialistSaved = 'idTopSpecialistSaved';
  static var idSpecialistSaved = 'idSpecialistSaved';
  static var idGenderSelect = 'idGenderSelect';
  static var idRegGenderSelect = 'idRegGenderSelect';
  static var idRatingSelect = 'idRatingSelect';
  static var idSelectType = 'idSelectType';
  static var idSelectSortBy = 'idSelectSortBy';
  static var idSelectLocation = 'idSelectLocation';
  static var idSelectAmount = 'idSelectAmount';
  static var idMoneyOffer = 'idMoneyOffer ';
  static var idApplyCoupon = 'idApplyCoupon';
  static var idSelectAppointmentType = 'idSelectAppointmentType';
  static var idAppointmentType = 'idAppointmentType';
  static var idPickImage = 'idPickImage';
  static var idRemoveImage = 'idRemoveImage';
  static var idSelectCountry = 'idSelectCountry';
  static var idSelectPatient = 'idSelectPatient';
  static var idSelectBirthDate = 'idSelectBirthDate';
  static var idPatientImage = 'idPatientImage';
  static var idEditImage = 'idEditImage';
  static var idChatImage = 'idChatImage';
  static var idChatVideo = 'idChatVideo';
  static var idChatCameraPhoto = 'idChatCameraPhoto';
  static var idMicMute = 'idMicMute';
  static var idVideoTurn = 'idVideoTurn';
  static var idCameraTurn = 'idCameraTurn';
  static var idVideoCall = 'idVideoCall';
  static var idSelectStar = 'idSelectStar';
  static var idSwitchOn = 'idSwitchOn';
  static var idSelectDateRange = 'idSelectDateRange';
  static var idSelectPayment = 'idSelectPayment';
  static var idChangeLanguage = 'idChangeLanguage';
  static var idSelectMonth = 'idSelectMonth';
  static var idUpdateSlots = 'idUpdateSlots';
  static var idRegistration = 'idRegistration';
  static var idRegister = 'idRegister';
  static var idLogIn = 'idLogIn';
  static var idGetEditProfileData = 'idGetEditProfileData';
  static var idCategory = 'idCategory';
  static var idTabBar = 'idTabBar';
  static var idTabBarView = 'idTabBarView';
  static var idDiscountAmount = 'idDiscountAmount';
  static var idCheckMobile = 'idCheckMobile';
  static var idVerification = 'idVerification';
  static var idVideoPlay = 'idVideoPlay';
  static var idSetMessage = 'idSetMessage';
  static var idComplainImage = 'idComplainImage';
  static var idNotification = 'idNotification';
  static var idGetDoctor = 'idGetDoctor';
  static var idSearchDoctor = 'idSearchDoctor';
  static var idGender = 'idGender';
  static var idGetReels = 'idGetReels';
  static var idChangePage = 'idChangePage';
  static var idPagination = 'idPagination';
  static var idChatBoat = 'idChatBoat';

  /// =================== App Name =================== ///
  static const stripeUrl = "https://api.stripe.com/v1/payment_intents";
  static const stripeMerchantCountryCode = 'IN';

  /// =================== Get Storage (Local Storage) =================== ///
  static final storage = GetStorage();

  /// =================== Localization =================== ///
  static const languageEn = "en";
  static const countryCodeEn = "US";

  /// =================== Country Name List =================== ///
  static List countryList = [
    // {"country": "Arabic (العربية)", "image": AppAsset.imPakistan, "id": "1"},
    {"country": "English (English)", "image": AppAsset.imEnglish, "id": "4"},
    {"country": "Bengali (বাংলা)", "image": AppAsset.imIndia, "id": "2"},
    // {"country": "Chinese Simplified (中国人)", "image": AppAsset.imChinese, "id": "3"},
    // {"country": "English (English)", "image": AppAsset.imEnglish, "id": "4"},
    // {"country": "French (français)", "image": AppAsset.imFrench, "id": "5"},
    // {"country": "German (Deutsche)", "image": AppAsset.imGerman, "id": "6"},
    {"country": "Hindi (हिंदी)", "image": AppAsset.imIndia, "id": "7"},
    // {"country": "Italian (italiana)", "image": AppAsset.imItalian, "id": "8"},
    // {"country": "Indonesian (bahasa indo)", "image": AppAsset.imIndonesian, "id": "9"},
    // {"country": "Korean (한국인)", "image": AppAsset.imKorean, "id": "10"},
    // {"country": "Portuguese (português)", "image": AppAsset.imPortuguese, "id": "11"},
    // {"country": "Russian (русский)", "image": AppAsset.imRussian, "id": "12"},
    // {"country": "Spanish (Español)", "image": AppAsset.imSpanish, "id": "13"},
    // {"country": "Swahili (Kiswahili)", "image": AppAsset.imSwahili, "id": "14"},
    // {"country": "Turkish (Türk)", "image": AppAsset.imTurkish, "id": "15"},
    {"country": "Telugu (తెలుగు)", "image": AppAsset.imIndia, "id": "16"},
    {"country": "Tamil (தமிழ்)", "image": AppAsset.imIndia, "id": "17"},
    {"country": "(اردو) Urdu", "image": AppAsset.imPakistan, "id": "18"},
  ];

  /// =================== Shimmers =================== ///
  static Color baseColor = AppColors.grey.withOpacity(0.6);
  static Color highlightColor = Colors.grey.withOpacity(0.2);
  static Duration period = const Duration(milliseconds: 500);
}
