import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor/services/app_exception.dart';
import 'package:doctor/ui/help_task_screen/model/raise_complain_model.dart';
import 'package:doctor/utils/api.dart';
import 'package:doctor/utils/constant.dart';
import 'package:doctor/utils/enums.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HelpDeskScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();

  int selectedType = 0;
  List type = [EnumLocale.txtComplain.name.tr, EnumLocale.txtSuggestion.name.tr];
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  File? selectImageFile;

  TextEditingController suggestionController = TextEditingController();
  TextEditingController appointmentIdController = TextEditingController();

  onPickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectImageFile = File(image!.path);
      update();
    }
    update([Constant.idComplainImage]);
  }

  onSelectType(int index) {
    selectedType = index;
    update([Constant.idSelectType]);
  }

  onSubmitClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      if (selectImageFile?.path.isEmpty == true) {
        Utils.showToast(Get.context!, EnumLocale.toastSelectImage.name.tr);
      } else {
        await onRaiseComplainApiCall(
          userId: Constant.storage.read("userId"),
          appointmentId: appointmentIdController.text,
          details: suggestionController.text,
          image: selectImageFile?.path ?? "",
          isComplain: selectedType == 0 ? "true" : "false",
        );

        Utils.showToast(Get.context!, raiseComplainModel?.message ?? "");

        if (raiseComplainModel?.status == true) {
          Get.back();
        }
      }
    }
  }

  /// =================== API Calling =================== ///

  RaiseComplainModel? raiseComplainModel;
  bool isLoading = false;

  onRaiseComplainApiCall({
    required String userId,
    required String appointmentId,
    required String details,
    required String image,
    required String isComplain,
  }) async {
    try {
      isLoading = true;
      update([Constant.idProgressView]);

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.raiseComplain);
      var request = http.MultipartRequest("POST", uri);
      log("Raise Complain URL :: $uri");

      if (image.isNotEmpty) {
        var addImage = await http.MultipartFile.fromPath("image", image);
        request.files.add(addImage);
        log("Raise Complain addImage :: $addImage");
        log("Raise Complain Image :: $image");
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "userId": userId,
        "appointmentId": appointmentId,
        "details": details,
        "isComplain": isComplain,
      };

      log("Raise Complain Body :: $requestBody");

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Raise Complain Status Code :: ${res.statusCode}");
      log("Raise Complain Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        raiseComplainModel = RaiseComplainModel.fromJson(jsonResponse);
        return RaiseComplainModel.fromJson(jsonDecode(res.body));
      }

      log("Raise Complain Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Raise Complain Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idProgressView]);
    }
  }
}
