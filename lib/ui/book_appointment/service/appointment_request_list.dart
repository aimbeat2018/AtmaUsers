import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/api.dart';
import '../../../utils/constant.dart';
import '../model/appointment_request_model.dart';

class AppointmentService {
  AppointmentService();

  Future<AppointmentRequestModel?> getUserAppointments() async {
    try {
      final userId = Constant.storage.read("userId");

      final uri = Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.appointmentRequestList}?user_id=$userId",
      );

      final response = await http.get(uri,
        headers: {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'}
      );
      print(response.body);
      print(uri);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return AppointmentRequestModel.fromJson(jsonData);
      } else {
        print('Error: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception in getUserAppointments: $e');
      return null;
    }
  }
}
