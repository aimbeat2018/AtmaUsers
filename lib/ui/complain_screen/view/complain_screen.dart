import 'package:doctor/ui/complain_screen/widget/complain_screen_widget.dart';
import 'package:flutter/material.dart';

class ComplainScreen extends StatelessWidget {
  const ComplainScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: const ComplainAppBarView(),
      ),
      body: const ComplainInfoView(),
    );
  }
}
