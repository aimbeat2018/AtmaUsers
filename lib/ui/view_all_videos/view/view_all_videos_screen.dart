import 'package:doctor/ui/view_all_videos/widget/view_all_videos_widget.dart';
import 'package:flutter/material.dart';

class ViewAllVideosScreen extends StatelessWidget {
  const ViewAllVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const ViewAllVideosAppBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ViewAllVideosItemView(),
          ],
        ),
      ),
    );
  }
}
