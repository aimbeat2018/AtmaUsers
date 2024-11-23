import 'package:flutter/material.dart';
import 'package:doctor/ui/notification_screen/widget/notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const NotificationAppBarView(),
        elevation: 0,
      ),
      body: const NotificationListView(),
    );
  }
}
