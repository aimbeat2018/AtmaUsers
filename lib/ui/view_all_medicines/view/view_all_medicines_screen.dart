import 'package:doctor/ui/view_all_medicines/widget/view_all_medicines_widget.dart';
import 'package:doctor/ui/view_all_videos/widget/view_all_videos_widget.dart';
import 'package:flutter/material.dart';

class ViewAllMedicinesScreen extends StatelessWidget {
  const ViewAllMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const ViewAllMedicinesBarView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ViewAllMedicinesItemView(),
          ],
        ),
      ),
    );
  }
}
