import 'dart:developer';
import 'package:doctor/utils/utils.dart';
import 'package:get/get.dart';
import '../service/send_request_service.dart';


class AppointmentController extends GetxController {
  final AppointmentService service;

  AppointmentController({required this.service});

  bool isLoading = false;
  Map<String, dynamic>? responseData;

  Future<void> sendAppointment({
    required String userId,
    required String satelliteId,
    required String appointmentDate,
    String? note,
  }) async {
    try {
      isLoading = true;
      update();

      final body = {
        "user_id": userId,
        "kiosk_id": satelliteId,
        "date": appointmentDate,
        "note": note ?? "",
      };

      final response = await service.sendAppointmentRequest(body: body);

      if (response != null) {
        responseData = response;
        print(response["message"]);
        Utils.showToast(Get.context!, response["message"]);
        log("✅ Appointment Sent Successfully");
      } else {
        log("⚠ Failed to send appointment");
      }
    } catch (e) {
      log("❌ Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }


}
