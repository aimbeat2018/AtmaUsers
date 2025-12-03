import 'dart:convert';
import 'dart:io';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/get_patient_report_controller.dart';

class UploadReportPage extends StatefulWidget {
  @override
  State<UploadReportPage> createState() => _UploadReportPageState();
}

class _UploadReportPageState extends State<UploadReportPage> {
  final PatientReportController controller = Get.put(PatientReportController());

  final PatientReportController patientReportController = Get.put(PatientReportController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,size: 25,color: Colors.white,),
        ),
        backgroundColor: AppColors.primaryAppColor1,
        title: Text("Upload Patient Report",style: TextStyle(color: Colors.white,
         fontSize: 16,fontWeight: FontWeight.w600
        ),),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _title("Patient ID"),
            // _textField(controller.patientIdController, "Enter Patient ID"),

            SizedBox(height: 15),

            _title("Description"),
            _textField(controller.descriptionController, "Enter Description"),

            SizedBox(height: 25),

            /// FIXED here
            Obx(() => controller.selectedFilePath.value != null
                ? _filePreview()
                : Text("No file selected", style: TextStyle(color: Colors.grey))
            ),

            SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.attach_file),
                onPressed: () async {
                  await controller.pickFile();
                },
                label: Text("Choose File"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAppColor1,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            SizedBox(height: 25),

            Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Center(
              child: ElevatedButton(
                onPressed: () async {
                  String result = await controller.uploadReport();
                  print(result);
                  patientReportController.fetchPatientReport();
                  Utils.showToast(context, result);

                },
                child: Text("Upload Report"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAppColor1,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            )
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600));
  }

  Widget _textField(TextEditingController controller, String hint) {
    return TextField(
      maxLines: 10,
      controller: controller,
      decoration: InputDecoration(

        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _filePreview() {
    final controller = Get.find<PatientReportController>();

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.insert_drive_file, size: 32, color: Colors.blue),
          SizedBox(width: 12),

          Expanded(
            child: Text(
              controller.selectedFilePath.value!.split('/').last,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: () {
              controller.selectedFilePath.value = null;  // FIXED
            },
          )
        ],
      ),
    );
  }
}
