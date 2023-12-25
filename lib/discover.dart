import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gardnr/discover_profile.dart';
import 'package:gardnr/objects.dart';
import 'package:location/location.dart';

final _profile = UserProfile(
    accountSettings: AccountSettings(),
    gardenerProfile: GardenerProfile(
        assets: rootBundle,
        name: "Samwise Gamgee",
        images: ["images/samwiseGardening.jpg", "images/hobbiton.jpg"],
        description:
            "Poh-tay-toes! Boil 'em, mash 'em, stick 'em in a stew!\nI love my garden here in Hobbiton!",
        location: LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}),
        squareFootage: 9000,
        stuffTheyGrow: ["Potatoes"]));

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DiscoverProfile(profile: _profile);
  }
}
