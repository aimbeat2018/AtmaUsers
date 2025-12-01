import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../utils/api.dart';
import '../model/kisakosatelite_model.dart';

class SateliteService {
  /// Fetch satellite/kiosk list
  Future<KisakoSateliteListResponse?> getKioskList({
    required String type,
    required String search,
  }) async {
    try {
      final Map<String, String> queryParameters = {
        'type': type,
        'search': search,
      };

      final queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(
        ApiConstant.BASE_URL + ApiConstant.getKioskList + queryString,
      );

      final headers = {
        "key": ApiConstant.SECRET_KEY,
        'Content-Type': 'application/json',
      };

      log("Kiosk URL :: $url");
      log("Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Status Code :: ${response.statusCode}");
      log("Response :: ${response.body}");

      if (response.statusCode == 200) {
        return KisakoSateliteListResponse.fromJson(
            jsonDecode(response.body));
      } else {
        log("Error Response: ${response.body}");
        return null;
      }
    } catch (e) {
      log("Exception in getKioskList :: $e");
      rethrow;
    }
  }
}
