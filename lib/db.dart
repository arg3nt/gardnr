// This file contains "database" functions that will probably
// be evolved into a full-blown backend middleware eventually.
// For now, they contain fake data to make the app mockup practical.

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:gardnr/objects.dart';
import 'package:location/location.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

Map<Set<int>, Chat> _chats = {};

Map<int, GardenerProfile> _gardeners = {
  0: GardenerProfile(
          uid: 0,
          assets: rootBundle,
          name: "Samwise Gamgee",
          images: [
            ImageDescription(
                source: ImageSource.asset, path: "images/samwiseGardening.jpg"),
            ImageDescription(
                source: ImageSource.asset, path: "images/hobbiton.jpg")
          ],
          description:
              "Poh-tay-toes! Boil 'em, mash 'em, stick 'em in a stew!\nI love my garden here in Hobbiton!",
          location: LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}),
          squareFootage: 9000,
          stuffTheyGrow: ["Potatoes"])
};

var _rng = Random();

int getSelfUid() {
  return 0;
}

Future<UserProfile> lookupSelfUser() async {
  await Future.delayed(const Duration(seconds: 1));

  return UserProfile(
      accountSettings: AccountSettings(),
      gardenerProfile: GardenerProfile(
          uid: 0,
          assets: rootBundle,
          name: "Samwise Gamgee",
          images: [
            ImageDescription(
                source: ImageSource.asset, path: "images/samwiseGardening.jpg"),
            ImageDescription(
                source: ImageSource.asset, path: "images/hobbiton.jpg")
          ],
          description:
              "Poh-tay-toes! Boil 'em, mash 'em, stick 'em in a stew!\nI love my garden here in Hobbiton!",
          location: LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}),
          squareFootage: 9000,
          stuffTheyGrow: ["Potatoes"]));
}

UserProfile getNextProfile() {
  var rng = Random();
  var id1 = rng.nextInt(1084);
  var id2 = rng.nextInt(1084);
  return UserProfile(
      gardenerProfile: GardenerProfile(
          uid: rng.nextInt(1<<32 - 1) + 1,
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

void matchWithGardener(int matcherUid, GardenerProfile matchedWith) {
  // Let's just say there's a 50% chance the user matches back.
  if (_rng.nextBool()) {
    return;
  }

  var key = {matcherUid, matchedWith.uid};

  // Do nothing if we already have message history.
  if (_chats.containsKey(key)) {
    return;
  }

  _chats[key] = Chat(users: key);
  _gardeners[matchedWith.uid] = matchedWith;
}

List<Chat> getChats(int uid) {
  List<Chat> chats = [];
  for (var participantSet in _chats.keys) {
    if (!participantSet.contains(uid)) {
      continue;
    }

    chats.add(_chats[participantSet]!);
  }

  chats.sort((a, b) => b.lastModified.compareTo(a.lastModified));

  return chats;
}

GardenerProfile? getGardener(int uid) {
  return _gardeners[uid];
}
