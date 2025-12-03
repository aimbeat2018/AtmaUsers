import 'dart:io';

import 'package:doctor/custom/no_data_found/no_data_found.dart';
import 'package:doctor/ui/book_appointment/view/upload_report_screen.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../utils/api.dart';
import '../controller/appointment_list_request_controller.dart';
import '../controller/get_patient_report_controller.dart';

class GetPatientReportScreen extends StatefulWidget {
  @override
  State<GetPatientReportScreen> createState() => _GetPatientReportScreenState();
}

class _GetPatientReportScreenState extends State<GetPatientReportScreen> {
  final PatientReportController patientReportController = Get.put(PatientReportController());

  String? filePath;
  Future<void> downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        // Detect Extension
        String extension = _getFileExtension(url, response.headers);

        // Pick storage folder
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/downloaded.$extension');

        await file.writeAsBytes(response.bodyBytes);

        print("File saved at: ${file.path}");

        // Open based on file type
        await OpenFilex.open(file.path);

      } else {
        print("Failed: Server returned ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }


  Future<void> openFileFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Detect extension
        String extension = _getFileExtension(url, response.headers);

        // Create file path with extension
        final dir = await getTemporaryDirectory();
        final filePath = "${dir.path}/report.$extension";
        final file = File(filePath);

        await file.writeAsBytes(response.bodyBytes);

        print("Saved File: $filePath");

        // Open file
        await OpenFilex.open(filePath);

      } else {
        print("Error: HTTP ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

// Detect file extension based on URL or Content-Type header
  String _getFileExtension(String url, Map<String, String> headers) {
    // Try from Content-Type header
    final contentType = headers['content-type'];
    if (contentType != null) {
      if (contentType.contains('pdf')) return 'pdf';
      if (contentType.contains('png')) return 'png';
      if (contentType.contains('jpeg') || contentType.contains('jpg')) return 'jpg';
    }

    // Try from URL extension
    final extFromUrl = path.extension(url).replaceAll(".", "");
    if (extFromUrl.isNotEmpty) return extFromUrl;

    return "file"; // fallback
  }





  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         actions: [
           Padding(
             padding: const EdgeInsets.only(right: 8.0),
             child: GestureDetector(
               onTap: (){
                 Get.to(UploadReportPage());
               },
               child: Row(
                 children: [
                   Icon(Icons.add,size: 25,color: Colors.white,),
                   Text("Add Report",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 15),),
                 ],
               ),
             ),
           )
         ],
          leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title: Text("Appointment List", style: TextStyle(color: Colors.white,fontSize: 19,
              fontWeight: FontWeight.w600
          ),),
          backgroundColor: AppColors.primaryAppColor1,
        ),
        body:Obx(() {
          if(patientReportController.isLoading.value){
            return Center(child: CircularProgressIndicator(),);
          }else if(patientReportController.reportData.value!.data!.isEmpty){
            return Text("No Data Found");
          }else{
            return GridView.builder(
              itemCount: patientReportController.reportData.value!.data!.length,
              padding: const EdgeInsets.only(left: 12,right:12,bottom: 60),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),

              itemBuilder: (context, index) {

                final url = patientReportController.reportData.value!.data![index].file;
                return GestureDetector(
                  onTap: () {
                    print("${ApiConstant.BASE_URL}"+url.toString());
                    if(url!.isNotEmpty){
                      openFileFromUrl("${ApiConstant.BASE_URL}"+url.toString());
                    }else{
                     Utils.showToast(context, "Pdf Link Not Found");
                    }
                  },
                  child: Card(
                    color: Colors.white70,
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.picture_as_pdf,
                            size: 50,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Pdf",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.download, size: 14, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  "Open",
                                  style: TextStyle(fontSize: 11, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },)
    );
  }
}
