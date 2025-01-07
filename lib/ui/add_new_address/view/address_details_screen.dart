import 'package:doctor/ui/add_new_address/widget/address_details_widgets.dart';
import 'package:flutter/material.dart';

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key});

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
            CheckAvailableLabsBottomView(),
          ],
        ),
      ),
    );
  }
}
