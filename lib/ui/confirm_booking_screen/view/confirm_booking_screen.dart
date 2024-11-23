import 'package:flutter/material.dart';
import 'package:doctor/ui/confirm_booking_screen/widget/confirm_booking_widget.dart';

class ConfirmBookingScreen extends StatelessWidget {
  const ConfirmBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const ConfirmBookingAppBarView(),
      ),
      bottomNavigationBar: const ConfirmBookingBottomView(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ConfirmBookingInfoView(),
            ConfirmBookingAppointmentView(),
            ConfirmBookingPaymentView(),
            ConfirmBookingCouponView()
          ],
        ),
      ),
    );
  }
}
