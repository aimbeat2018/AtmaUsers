import 'package:doctor/ui/book_appointment/controller/kisakosatelite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom/progress_indicator/progress_dialog.dart';
import '../../../utils/app_color.dart';
import 'appointment_request_from.dart';


class KioskListScreen extends StatefulWidget {
  const KioskListScreen({super.key});

  @override
  _KioskListScreenState createState() => _KioskListScreenState();
}

class _KioskListScreenState extends State<KioskListScreen> {

  final KisakosateliteController kisakosateliteController=Get.put(KisakosateliteController());

  @override
  void initState() {
    super.initState();

    /// Load initial list
    kisakosateliteController.onGetKioskApiCall(
      type: "kiosk",
      search: "",
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Kiosk",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryAppColor1,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, color: AppColors.white),
        ),
      ),
      body: GetBuilder<KisakosateliteController>(
        builder: (controller) {
          return ProgressDialog(
            inAsyncCall: controller.isLoading,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  /// 🔍 SEARCH FIELD (Active API Search)
                  TextFormField(
                    controller: controller.controller,
                    onChanged: (value) {
                      kisakosateliteController.onGetKioskApiCall(
                        type: "satellite",
                        search: value,   // 🟢 Correct & working search
                      );
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      hintText: "Search...",
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔵 LIST VIEW (API DATA)
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                      padding: EdgeInsets.zero,
                      itemCount: controller.kisakoSateliteListResponse
                          ?.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final user = controller
                            .kisakoSateliteListResponse!.data![index];
                        return ListTile(
                          onTap: () {

                            Get.to(AppointmentRequestFrom(
                              hospitalId: user.id.toString(),
                            ));
                          },
                          leading: Icon(Icons.medical_services,size: 25,),
                          title: Text(user.state ?? ""),
                          subtitle: Text(user.building ?? ""),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

