import 'package:doctor/ui/chat_boat_screen/widget/chat_boat_widget.dart';
import 'package:flutter/material.dart';

class ChatBoatScreen extends StatelessWidget {
  const ChatBoatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: ChatBoatTopView(),
      ),
      body: ChatBoatMessageView(),
    );
  }
}
