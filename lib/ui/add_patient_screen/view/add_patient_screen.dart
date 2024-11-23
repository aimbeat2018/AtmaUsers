import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/add_patient_screen/widget/add_patient_widget.dart';
import 'package:doctor/ui/booking_screen/controller/booking_screen_controller.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPatientScreen extends StatelessWidget {
  const AddPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingScreenController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const PatientDetailAppBarView(),
            ),
            bottomNavigationBar: const PatientDetailBottomView(),
            body: SingleChildScrollView(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PatientDetailUploadImageView(),
                  PatientDetailAddInfoView(),
                ],
              ).paddingOnly(left: 15, right: 15),
            ),
          ),
        );
      },
    );
  }
}
