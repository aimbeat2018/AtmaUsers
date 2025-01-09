import 'package:doctor/ui/pharmacy_booking/widget/pharmacy_booking_widget.dart';
import 'package:flutter/material.dart';

class PharmacyBookingScreen extends StatelessWidget {
  const PharmacyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MedicinesAppBarView(),
      ),
      bottomNavigationBar: GoToCartBottomView(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MedicinesAddressView(),
            SearchBrandView(),
            UploadPrescriptionView(),
            MedicinesListView(),

          ],
        ),
      ),
    );
  }
}
