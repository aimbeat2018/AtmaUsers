import 'package:doctor/ui/my_wallet_screen/widget/my_wallet_widget.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyWalletAppBarView(),
      ),
      body: Column(
        children: [
          const MyWalletBalanceView(),
          MyWalletButtonView(),
          Divider(height: Get.height * 0.05, color: AppColors.description.withOpacity(0.1)),
        ],
      ),
    );
  }
}
