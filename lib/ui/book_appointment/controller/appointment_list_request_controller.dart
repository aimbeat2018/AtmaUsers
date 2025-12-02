import 'package:get/get.dart';

import '../model/appointment_request_model.dart';
import '../service/appointment_request_list.dart';

class AppointmentController extends GetxController {
  late final AppointmentService service;

  var isLoading = false.obs;
  var appointmentList = AppointmentRequestModel().obs; // Stores full model

  @override
  void onInit() {
    service = AppointmentService();
    fetchUserAppointments();
    super.onInit();
  }

  Future<void> fetchUserAppointments() async {
    try {
      isLoading.value = true;

      final response = await service.getUserAppointments();

      if (response != null && response.status == true) {
        appointmentList.value = response;
      } else {
        appointmentList.value = AppointmentRequestModel(); // empty model
        print(response?.message ?? "No data received");
      }
    } catch (e) {
      print("Error fetching appointments: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
