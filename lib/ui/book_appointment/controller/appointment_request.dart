import 'package:get/get.dart';
import '../model/appointment_request_model.dart';
import '../service/appointment_request_list.dart';



class AppointmentController extends GetxController {
  final AppointmentService service;

  AppointmentController({required this.service});

  var isLoading = false.obs;
  var appointmentList = AppointmentRequestModel().obs;

  Future<void> fetchUserAppointments() async {
    try {
      isLoading.value = true;

      final response = await service.getUserAppointments();

      if (response != null && response.status!) {
        appointmentList.value = response;
      } else {
        // appointmentList.clear();
        print(response?.message ?? "No data");
      }
    } catch (e) {
      print("Error fetching appointments: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
