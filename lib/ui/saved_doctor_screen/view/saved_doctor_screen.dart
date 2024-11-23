import 'package:doctor/custom/progress_indicator/progress_dialog.dart';
import 'package:doctor/ui/saved_doctor_screen/controller/saved_doctor_controller.dart';
import 'package:doctor/ui/saved_doctor_screen/widget/saved_doctor_widget.dart';
import 'package:doctor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedDoctorScreen extends StatelessWidget {
  const SavedDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return GetBuilder<SavedDoctorController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return ProgressDialog(
          inAsyncCall: logic.isLoading1,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const SavedDoctorAppBarView(),
            ),
            body: const SavedDoctorListView(),
          ),
        );
      },
    );
  }
}
