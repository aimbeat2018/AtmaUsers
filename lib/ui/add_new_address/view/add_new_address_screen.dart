import 'package:doctor/ui/add_new_address/widget/add_new_address_widget.dart';
import 'package:flutter/material.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const AddNewAddressAppBarView(),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AddNewAddressButton(),
            SaveAddressTitle(),
            SelectAddress(),
          ],
        ),
      ),
    );
  }
}
