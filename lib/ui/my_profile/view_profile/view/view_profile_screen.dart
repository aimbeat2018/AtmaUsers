import 'package:doctor/ui/my_profile/view_profile/widget/my_profile_widget.dart';
import 'package:doctor/ui/my_profile/widget/my_profile_widget.dart';
import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyProfileAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MyProfileBackgroundView(),
            ViewProfileListViewItems(),

          ],
        ),
      ),
    );
  }
}
