import 'package:flutter/material.dart';
import 'package:doctor/ui/confirm_appointment_screen/widget/confirm_appointment_widget.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  const ConfirmAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return const Scaffold(
      body: Column(
        children: [
          ConfirmAppointmentPaymentView(),
          ConfirmAppointmentInfoView(),
        ],
      ),
    );
  }
}
