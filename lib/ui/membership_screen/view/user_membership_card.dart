import 'package:flutter/material.dart';

import '../widget/membership_card.dart';
import '../widget/membership_widget.dart';

class UserMembershipCard extends StatelessWidget {
  const UserMembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MembershipBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MembershipCard(),
            MembershipCardDownloadButton(),


          ],
        ),
      ),
    );
  }
}