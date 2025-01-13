import 'package:doctor/ui/my_orders/widget/my_orders_widget.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
      flexibleSpace: const MyOrdersAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyOrdersItemView(),
          ],
        ),
      ),
    );
  }
}
