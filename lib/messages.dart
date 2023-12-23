import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: const Text("This is the messages overview page!"));
  }
}
