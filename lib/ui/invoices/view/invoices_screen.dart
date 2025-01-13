import 'package:doctor/ui/invoices/widget/invoices_widget_screen.dart';
import 'package:flutter/material.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: InvoicesAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InvoicesItemView(),
          ],
        ),
      ),
    );
  }
}
