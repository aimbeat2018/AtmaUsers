import 'package:doctor/ui/re-schedule_screen/widget/schedule_widget.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const ScheduleAppBarView(),
      ),
      bottomNavigationBar: const ScheduleBottomView(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ScheduleInfoView(),
            ScheduleDateView(),
            ScheduleSlotView(),
          ],
        ),
      ),
    );
  }
}
