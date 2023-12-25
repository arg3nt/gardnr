import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gardnr/discover_profile.dart';
import 'package:gardnr/objects.dart';
import 'package:location/location.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

UserProfile getNextProfile() {
  var rng = Random();
  var id1 = rng.nextInt(1084);
  var id2 = rng.nextInt(1084);
  return UserProfile(
      gardenerProfile: GardenerProfile(
          assets: rootBundle,
          name: loremIpsum(words: 2),
          images: [
            ImageDescription(source: ImageSource.network, path: "https://picsum.photos/id/$id1/500"),
            ImageDescription(source: ImageSource.network, path: "https://picsum.photos/id/$id2/500")
          ],
          description: loremIpsum(paragraphs: 2, words: 30),
          location: LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}),
          squareFootage: 50,
          stuffTheyGrow: []));
}

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
        });
  }
}
