// "Database" functions.

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:gardnr/objects.dart';
import 'package:location/location.dart';

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

  chats.sort((a, b) => a.lastModified.compareTo(b.lastModified));

  return chats;
}

GardenerProfile? getGardener(int uid) {
  return _gardeners[uid];
}
