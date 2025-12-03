import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';

import '../../../utils/api.dart';
import '../model/get_patient_report_model.dart';
import '../model/kisakosatelite_model.dart';

class GetPatientReportService {
  /// Fetch satellite/kiosk list
  Future<GetPatientReportModel?> getPatientReport(String userId) async {
    try {
      final url = Uri.parse(
        ApiConstant.BASE_URL + ApiConstant.getPatientReport,
      );

      final headers = {
        "key": ApiConstant.SECRET_KEY,
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'patient_id':userId,
      });

      log("Kiosk URL :: $url");
      log("Headers :: $headers");
      log("Body :: $body");

      final response = await http.post(url, headers: headers, body: body);

      log("Status Code :: ${response.statusCode}");
      log("Response :: ${response.body}");

      if (response.statusCode == 200) {
        return GetPatientReportModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        log("Error Response: ${response.body}");
        return null;
      }
    } catch (e) {
      log("Exception in getKioskList :: $e");
      rethrow;
    }
  }

  Future<String> uploadPatientReport({
    required File file,
    required String patientId,
    required String description,
  }) async {
    try {
      final url = Uri.parse(
        "https://admin.atmaprimehealthcare.com/admin/patient/report/add-patient-reports",
      );

      var request = http.MultipartRequest("POST", url);

      request.fields['patient_id'] = patientId;
      request.fields['description'] = description;

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          filename: file.path.split('/').last,
          contentType:
          file.path.endsWith(".pdf")
              ? MediaType("application", "pdf")
              : MediaType("image", _getExtension(file.path)),
        ),
      );

      request.headers.addAll({
        "Accept": "application/json",
        "key": ApiConstant.SECRET_KEY,
        // DO NOT add Content-Type manually; MultipartRequest sets it automatically
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Response code: ${response.statusCode}");
      print("Response: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded["status"] == true) {
        return decoded["message"] ?? "Uploaded Successfully!";
      } else {
        return decoded["message"] ?? "Upload failed!";
      }
    } catch (e) {
      return "Upload failed: $e";
    }
  }

  String _getExtension(String path) {
    return path.split('.').last.toLowerCase();
  }


  // Future<String> uploadPatientReport({
  //   required File file,
  //   required String patientId,
  //   required String description,
  // }) async {
  //   try {
  //     final url = Uri.parse(
  //       "https://admin.atmaprimehealthcare.com/admin/patient/report/add-patient-reports",
  //     );
  //
  //     var request = http.MultipartRequest("POST", url);
  //
  //     request.fields['patient_id'] = patientId;
  //     request.fields['description'] = description;
  //
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'file',
  //         file.path,
  //       ),
  //     );
  //
  //     request.headers.addAll({
  //       "Content-Type": "multipart/form-data",
  //           "Accept": "application/json",
  //       "key": ApiConstant.SECRET_KEY,
  //     });
  //
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     final decoded = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && decoded["status"] == true) {
  //       return decoded["message"] ?? "Uploaded Successfully!";
  //     } else {
  //       return decoded["message"] ?? "Upload failed!";
  //     }
  //   } catch (e) {
  //     return "Upload failed: $e";
  //   }
  // }



}
