import 'package:doctor/ui/order_details/widget/order_details_widget.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const OrderDetailsAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderSuccessfulTitle(),
            OrderSummaryView(),

          ],
        ),
      ),
    );
  }
}
