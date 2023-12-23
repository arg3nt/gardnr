import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: const Text("This is the profile page!"));
  }
}
