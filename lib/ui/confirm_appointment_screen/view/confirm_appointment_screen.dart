import 'package:flutter/material.dart';
import 'package:doctor/ui/confirm_appointment_screen/widget/confirm_appointment_widget.dart';
import 'package:flutter/widgets.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  const ConfirmAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConfirmAppointmentPaymentView(),
                  ConfirmAppointmentInfoView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
