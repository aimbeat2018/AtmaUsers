import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../utils/api.dart';

class AppointmentService {
  final String baseUrl;

  AppointmentService({required this.baseUrl});

  Future<Map<String, dynamic>?> sendAppointmentRequest({
    required Map<String, dynamic> body,
  }) async {
    try {
      final url = Uri.parse( ApiConstant.BASE_URL + ApiConstant.sendAppointmentRequest,);

      log("📤 Sending Appointment Request → $url");
      log("📦 Body → $body");

      final headers = {
        "key": ApiConstant.SECRET_KEY,
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      log("📥 Status Code: ${response.statusCode}");
      log("📥 Response: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      log("❌ Error in sendAppointmentRequest: $e");
      return null;
    }
  }

  

}
