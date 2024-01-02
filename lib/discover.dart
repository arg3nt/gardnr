import 'package:flutter/material.dart';
import 'package:gardnr/discover_profile.dart';
import 'package:gardnr/db.dart';
import 'package:gardnr/objects.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => DiscoverPageState();
}

class DiscoverPageState extends State<DiscoverPage> {
  UserProfile active = getNextProfile();

  @override
  Widget build(BuildContext context) {
    return DiscoverProfile(
        profile: active,
        nextTrigger: () {
          setState(() {
            active = getNextProfile();
          });
        },
        newMatch: (user) {
          matchWithGardener(getSelfUid(), user.gardenerProfile!);
        });
  }
}
