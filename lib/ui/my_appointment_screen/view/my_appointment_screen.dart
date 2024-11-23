import 'package:doctor/ui/my_appointment_screen/controller/my_appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor/ui/my_appointment_screen/widget/my_appointment_widget.dart';
import 'package:get/get.dart';

class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyAppointmentAppBarView(),
      ),
      body: GetBuilder<MyAppointmentController>(
        builder: (logic) {
          return RefreshIndicator(
            onRefresh: () => logic.onRefresh(),
            child: const Column(
              children: [
                MyAppointmentTitleView(),
                Expanded(
                  child: MyAppointmentListView(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
