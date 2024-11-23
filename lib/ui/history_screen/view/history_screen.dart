import 'package:doctor/ui/history_screen/widget/history_screen_widget.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const HistoryAppBarView(),
      ),
      body: const Column(
        children: [
          HistoryTitleView(),
          Expanded(child: HistoryListView()),
        ],
      ),
    );
  }
}
