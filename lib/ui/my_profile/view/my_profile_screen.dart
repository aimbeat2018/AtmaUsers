import 'package:doctor/ui/my_profile/widget/my_profile_widget.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyProfileAppBarView(),
      ),
    );
  }
}
