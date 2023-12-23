import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: const Text("This is the discover page!"));
  }
}
