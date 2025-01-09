import 'package:doctor/ui/pharmacy_booking/widget/medicine_details_widget.dart';
import 'package:flutter/material.dart';

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MedicineDetailsAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MedicineImageView(),
            MedicineAddToCart(),
            MedicineDescription(),

          ],
        ),
      ),
    );
  }
}
