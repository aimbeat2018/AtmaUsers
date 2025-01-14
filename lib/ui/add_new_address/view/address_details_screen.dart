import 'package:doctor/ui/add_new_address/widget/address_details_widgets.dart';
import 'package:flutter/material.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const AddNewAddressAppBarView(),
      ),
      body:  SingleChildScrollView(
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
