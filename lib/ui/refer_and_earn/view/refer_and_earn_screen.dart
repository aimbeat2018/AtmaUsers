import 'package:doctor/ui/refer_and_earn/widget/refer_and_earn_widget.dart';
import 'package:flutter/material.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const ReferAndEarnAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ReferAndEarnImageView(),
            ReferAndEarnCodeView(),
            InviteFriendsView(),
          ],
        ),
      ),
    );
  }
}
