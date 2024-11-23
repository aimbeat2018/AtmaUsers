import 'package:doctor/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor/ui/appointment_screen/widget/appointment_screen_widget.dart';
import 'package:get/get.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Get.find<BottomBarController>().onClick(0);
        if (didPop) {
          return;
        }
      },
      child: const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: AppointmentAppBarView(),
        ),
        body: AppointmentTabView(),
      ),
    );
  }
}
