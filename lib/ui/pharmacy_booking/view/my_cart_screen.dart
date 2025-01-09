import 'package:doctor/ui/pharmacy_booking/widget/my_cart_widget.dart';
import 'package:flutter/material.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyyCartAppBarView(),
      ),
    );
  }
}
