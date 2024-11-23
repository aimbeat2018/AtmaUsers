import 'package:doctor/ui/help_desk_history_screen/widget/help_desk_history_widget.dart';
import 'package:flutter/material.dart';

class HelpDeskHistoryScreen extends StatelessWidget {
  const HelpDeskHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: const HelpDeskHistoryAppBarView(),
      ),
      body: const HelpDeskHistoryListView(),
    );
  }
}
