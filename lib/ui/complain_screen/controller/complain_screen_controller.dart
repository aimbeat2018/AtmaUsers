import 'dart:developer';

import 'package:get/get.dart';

class ComplainScreenController extends GetxController {
  dynamic args = Get.arguments;
  String? details;
  int? appointmentId;
  String? image;
  bool? isComplain;
  DateTime? createdAt;

  @override
  void onInit() async {
    await getDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null || args[4] != null) {
        details = args[0];
        appointmentId = args[1];
        image = args[2];
        isComplain = args[3];
        createdAt = args[4];
      }
    }

    log("Details :: $details");
    log("Appointment Id :: $appointmentId");
    log("Image :: $image");
    log("Is Complain :: $isComplain");
    log("Created At :: $createdAt");
  }
}
