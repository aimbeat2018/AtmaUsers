import 'dart:convert';
import 'dart:developer';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/registration_screen/model/registration_model.dart';
import 'package:doctor/ui/registration_screen/widget/registration_screen_widget.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/global_variables.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String? countryName;
  String? genderName;
  String? birthDate;
  String? formatBirthDate;
  String? finalBirthDate;
  int genderSelect = 0;
  bool isObscure = true;
  bool isObscure1 = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  ProfileScreenController profileScreenController =
      Get.find<ProfileScreenController>();

  List gender = ["Female", "Male"];

  @override
  void onInit() {
    log("Country Name is :: $country");
    log("Country Code is :: $countryCode");
    super.onInit();
  }

  onCountryChange(String country) {
    countryName = country;
    update([Constant.idSelectCountry]);
  }

  onGenderSelect(int index) {
    genderSelect = index;
    genderName = gender[index];

    update([Constant.idRegGenderSelect]);
  }

  onSelectBirthDate(String date) {
    birthDate = date;
    update([Constant.idSelectBirthDate]);
  }

  onClickObscure() {
    log("isObscure :: $isObscure");
    isObscure = !isObscure;
    update();
  }

  onClickObscure1() {
    log("isObscure :: $isObscure1");
    isObscure1 = !isObscure1;
    update();
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  onRegisterClick(BuildContext context) {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      Get.to(const CompleteRegistrationScreen());
    }
    update([Constant.idRegister]);
  }

  onSubmitClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty &&
        numberController.text.isNotEmpty) {
      await onRegistrationApiCall(
        fcmToken: fcmToken!,
        loginType: 1,
        email: emailController.text,
        password: rePasswordController.text,
        name: nameController.text,
        mobile: numberController.text,
        country: countryName ?? country!,
        gender: genderName ?? 'Female',
        dob: finalBirthDate ?? '2000-04-01',
      );

      if (registrationModel?.status == true) {
        if (registrationModel?.signup == true) {
          Constant.storage.write("isLogIn", true);
          Constant.storage.write("userId", registrationModel?.user?.id);

          try {
            isLoading = true;
            update([Constant.idProgressView]);

            await profileScreenController.onGetUserProfileApiCall();

            if (profileScreenController.getUserProfileModel?.status == true) {
              Constant.storage.write("userName",
                  profileScreenController.getUserProfileModel?.user?.name);
              Constant.storage.write("userEmail",
                  profileScreenController.getUserProfileModel?.user?.email);
              Constant.storage.write("userImage",
                  profileScreenController.getUserProfileModel?.user?.image);
              Constant.storage.write("mobileNumber",
                  profileScreenController.getUserProfileModel?.user?.mobile);

              Get.offAllNamed(AppRoutes.bottom);
            } else {
              Utils.showToast(Get.context!,
                  profileScreenController.getUserProfileModel?.message ?? "");
            }
          } catch (e) {
            log("Error in Registration Profile :: $e");
          } finally {
            isLoading = false;
            update([Constant.idProgressView]);
          }
        } else {
          Utils.showToast(Get.context!, EnumLocale.desAlreadyUser.name.tr);
        }
      } else {
        Utils.showToast(Get.context!, registrationModel?.message ?? "");
      }
    } else {
      Utils.showToast(Get.context!, EnumLocale.desEnterMobile.name.tr);
    }
    update([Constant.idProgressView, Constant.idRegistration]);
  }

  /// =================== API Calling =================== ///

  RegistrationModel? registrationModel;
  bool isLoading = false;



  onRegistrationApiCall({
    required String fcmToken,
    required int loginType,
    required String email,
    required String password,
    required String name,
    required String mobile,
    required String country,
    required String gender,
    required String dob,
  }) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);
      int age = 0;
      if(dob!="") {
         age = calculateAgeFromString(dob);
      }

      final body = json.encode({
        "email": email,
        "password": password,
        "loginType": loginType,
        "fcmToken": fcmToken,
        "name": name,
        "mobile": mobile,
        "country": country,
        "gender": gender,
        "dob": dob,
        "age": age==0?age.toString():"",
      });

      log("Registration User Body :: $body");

      final url =
          Uri.parse(ApiConstant.BASE_URL + ApiConstant.registrationUser);
      log("Registration User Url :: $url");

      final headers = {
        "key": ApiConstant.SECRET_KEY,
        'Content-Type': 'application/json'
      };
      log("Registration User Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Registration User Status Code :: ${response.statusCode}");
      log("Registration User Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        registrationModel = RegistrationModel.fromJson(jsonResponse);
      }
      log("Registration User Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Registration User Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
