import 'package:doctor/ui/my_prescription/widget/my_prescription_widget.dart';
import 'package:flutter/material.dart';

class MyPrescriptionScreen extends StatelessWidget {
  const MyPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyPrescriptionAppBarView(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchFileNameView(),
          PrescriptionByExpertsTitle(),
          SearchResultView(),
        ],
      ),
    );
  }
}
