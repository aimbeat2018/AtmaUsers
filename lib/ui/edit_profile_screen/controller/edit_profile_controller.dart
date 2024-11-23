import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/edit_profile_screen/model/update_profile_model.dart';
import 'package:doctor/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:doctor/ui/search_screen/widget/search_screen_widget.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileController extends GetxController {
  String? countryName;
  String? genderName;
  String? birthDate;
  String? formatBirthDate;
  String? finalBirthDate;
  String? age;
  int genderSelect = 0;

  String? name;
  String? email;
  String? mobile;
  String? country;
  String? selectGender;
  DateTime? dob;

  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  File? selectImageFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();
    await setArgumentsData();

    super.onInit();
  }

  getDataFromArgs() {
    dynamic args = Get.arguments;

    log("Edit Profile Args :: $args");

    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null || args[4] != null || args[5] != null) {
        name = args[0];
        email = args[1];
        mobile = args[2];
        country = args[3];
        selectGender = args[4];
        dob = args[5];
      }
    }

    update([Constant.idGetEditProfileData]);
  }

  setArgumentsData() {
    log("Name :: $name");
    log("Email :: $email");
    log("Mobile :: $mobile");
    log("Country :: $country");
    log("Gender :: $selectGender");
    log("DOB :: $dob");

    birthDate = DateFormat('dd MMM yyyy').format(dob ?? DateTime.now());
    log("BirthDate :: $birthDate");

    finalBirthDate = DateFormat('yyyy-MM-dd').format(dob ?? DateTime.now());
    log("Final BirthDate :: $finalBirthDate");

    int ageInt =
        int.parse(DateFormat('yyyy').format(DateTime.now())) - int.parse(DateFormat('yyyy').format(dob ?? DateTime.now()));
    age = ageInt.toString();
    log("Age :: $age");

    nameController.text = name ?? "";
    emailController.text = email ?? "";
    numberController.text = mobile ?? "";
    countryName = country;
    genderName = selectGender;
    update([Constant.idGetEditProfileData, Constant.idSelectBirthDate, Constant.idRegGenderSelect, Constant.idSelectCountry]);
  }

  onPickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectImageFile = File(image!.path);
      update();
    }
    update([Constant.idEditImage]);
  }

  onCountryChange(String country) {
    countryName = country;
    update([Constant.idSelectCountry]);
  }

  onGenderSelect(int index) {
    genderSelect = index;
    genderName = genderList[index];

    update([Constant.idRegGenderSelect]);
  }

  onSelectBirthDate(String date) {
    birthDate = date;
    update([Constant.idSelectBirthDate]);
  }

  onSaveProfileClick(BuildContext context) async {
    Utils.currentFocus(context);

    await onUpdateUserApiCall(
      name: nameController.text,
      email: emailController.text,
      mobile: numberController.text,
      age: age ?? "",
      gender: genderName ?? "",
      dob: finalBirthDate ?? "",
      country: countryName ?? "",
      image: selectImageFile?.path ?? "",
    );

    if (updateProfileModel?.status == true) {
      Constant.storage.write("isUpdate", true);
      Constant.storage.write("isLogIn", true);

      try {
        isLoading = true;
        update([Constant.idProgressView]);

        await profileScreenController.onGetUserProfileApiCall();

        if (profileScreenController.getUserProfileModel?.status == true) {
          Constant.storage.write("userName", profileScreenController.getUserProfileModel?.user?.name);
          Constant.storage.write("userEmail", profileScreenController.getUserProfileModel?.user?.email);
          Constant.storage.write("userImage", profileScreenController.getUserProfileModel?.user?.image);
          Constant.storage.write("mobileNumber", profileScreenController.getUserProfileModel?.user?.mobile);

          if (Constant.storage.read("isSignUp") == true) {
            Constant.storage.write("isSignUp", false);
            Get.offAllNamed(AppRoutes.bottom);
          } else {
            Get.back();
          }
        } else {
          Utils.showToast(Get.context!, profileScreenController.getUserProfileModel?.message ?? "");
        }
      } catch (e) {
        log("Error In get profile api :: $e");
      } finally {
        isLoading = false;
        update([Constant.idProgressView]);
      }
    } else {
      Utils.showToast(Get.context!, updateProfileModel?.message ?? "");
    }
  }

  /// =================== API Calling =================== ///

  UpdateProfileModel? updateProfileModel;
  bool isLoading = false;

  onUpdateUserApiCall({
    required String name,
    required String email,
    required String mobile,
    required String age,
    required String gender,
    required String dob,
    required String country,
    required String image,
  }) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      final queryParameters = {
        "userId": Constant.storage.read('userId'),
      };

      log("Update Profile Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.updateUserProfile + queryString);
      var request = http.MultipartRequest("PATCH", uri);
      log("Update Profile URL :: $uri");

      if (image.isNotEmpty) {
        var addImage = await http.MultipartFile.fromPath("image", image);
        request.files.add(addImage);
        log("Update Profile addImage :: $addImage");
        log("Update Profile Image :: $image");
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "name": name,
        "email": email,
        "mobile": mobile,
        "age": age,
        "gender": gender,
        "dob": dob,
        "country": country,
      };

      log("Update Profile Body :: $requestBody");

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Update Profile Status Code :: ${res.statusCode}");
      log("Update Profile Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        updateProfileModel = UpdateProfileModel.fromJson(jsonResponse);
        return UpdateProfileModel.fromJson(jsonDecode(res.body));
      }

      log("Update Profile Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Update User Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
