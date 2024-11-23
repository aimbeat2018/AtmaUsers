import 'dart:developer';

import 'package:get/get.dart';

class ConfirmAppointmentController extends GetxController {
  dynamic args = Get.arguments;

  String? doctorName;
  String? doctorImage;
  String? doctorDesignation;
  String? doctorDegree;
  String? date;
  String? time;
  String? appointmentType;
  String? clinicName;
  String? address;

  @override
  void onInit() async {
    await getDataFromArgs();

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null ||
          args[1] != null ||
          args[2] != null ||
          args[3] != null ||
          args[4] != null ||
          args[5] != null ||
          args[6] != null ||
          args[7] != null ||
          args[8] != null) {
        doctorName = args[0];
        doctorImage = args[1];
        doctorDesignation = args[2];
        doctorDegree = args[3];
        date = args[4];
        time = args[5];
        appointmentType = args[6];
        clinicName = args[7];
        address = args[8];
      }

      log("Doctor Name :: $doctorName");
      log("Doctor Image :: $doctorImage");
      log("Doctor Designation :: $doctorDesignation");
      log("Doctor Degree :: $doctorDegree");
      log("Date :: $date");
      log("Time :: $time");
      log("AppointmentType :: $appointmentType");
      log("Clinic Name :: $clinicName");
      log("Address $address");
    }
  }
}
