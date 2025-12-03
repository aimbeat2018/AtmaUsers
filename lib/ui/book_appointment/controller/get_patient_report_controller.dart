import 'dart:io';

import 'package:doctor/utils/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/get_patient_report_model.dart';
import '../service/get_patient_report_service.dart';

class PatientReportController extends GetxController {
  final GetPatientReportService _service = GetPatientReportService();
  final TextEditingController patientIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Rxn<String> selectedFilePath=Rxn<String>();
  /// Observables
  var isLoading = false.obs;
  var reportData = Rx<GetPatientReportModel?>(null);
  var errorMessage = "".obs;



  /// Fetch patient report
  Future<void> fetchPatientReport() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      reportData.value = null;

      final data = await _service.getPatientReport(
          Constant.storage.read("userId")
      );

      if (data != null) {
        reportData.value = data;
      } else {
        errorMessage.value = "No report found or server returned an error.";
      }
    } catch (e) {
      errorMessage.value = "Something went wrong: $e";
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      selectedFilePath.value = result.files.single.path!;
    }
  }

  Future<String> uploadReport() async {
    if (selectedFilePath.value == null) {
      return "Please select a file.";
    }

    if (descriptionController.text.isEmpty) {
      return "Description are required.";
    }

    try {
      isLoading.value = true;

      // 🔥 get API response message
      String response = await _service.uploadPatientReport(
        file: File(selectedFilePath.value!),
        patientId: Constant.storage.read("userId"),
        description: descriptionController.text.trim(),
      );

      return response;
    } catch (e) {
      return "Upload Failed: $e";
    } finally {
      isLoading.value = false;
    }
  }



  void dispose() {
    patientIdController.dispose();
    descriptionController.dispose();
  }
}





