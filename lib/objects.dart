import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class UserProfile {
  UserProfile(
      {this.accountSettings, this.gardenerProfile, this.composterProfile});

  AccountSettings? accountSettings;
  GardenerProfile? gardenerProfile;
  ComposterProfile? composterProfile;
}

class BaseProfile {
  BaseProfile(
      {required this.uid,
      required this.assets,
      required this.name,
      required this.images,
      required this.description,
      required this.location});

  // A unique identifier for the user.
  int uid;

  // The AssetBundle used to retrieve assets for the given gardener.
  AssetBundle assets;

  // The name of the user.
  String name;

  // A list of image assetNames that can be retrieved by loading them from |assets|.
  // Can be empty.
  List<ImageDescription> images;

  // A description of the user.
  String description;

  // The location of the user.
  LocationData location;
}

class GardenerProfile extends BaseProfile {
  GardenerProfile(
      {required super.uid,
      required super.assets,
      required super.name,
      required super.images,
      required super.description,
      required super.location,
      required this.squareFootage,
      required this.stuffTheyGrow});

  // Approximate square footage of the garden.
  int squareFootage;

  // A list of things the gardener/garden grows.
  List<String> stuffTheyGrow;
}

class ComposterProfile extends BaseProfile {
  ComposterProfile(
      {required super.uid,
      required super.assets,
      required super.name,
      required super.images,
      required super.description,
      required super.location,
      required this.monthlyProduction,
      required this.stuffTheyCompost});

  // Approximate monthly production of compost, in gallons.
  double monthlyProduction;

  // A list of things the composter includes in their compost.
  List<String> stuffTheyCompost;
}

class AccountSettings {}

class ImageDescription {
  ImageDescription({required this.source, required this.path});

  ImageSource source;
  String path;
}

enum ImageSource { asset, file, network }

// Represents a chat between multiple users.
class Chat {
  Chat({required this.users}) {
    lastModified = DateTime.now();
  }

  Set<int> users;

  late DateTime lastModified;

  List<ChatMessage> messages = [];

  void addMessage(ChatMessage msg) {
    messages.add(msg);
    lastModified = msg.timestamp;
  }

  // Gets the last |count| messages, ending at endAt (non-inclusive), if specified,
  // or the end of the messages list if not.
  List<ChatMessage> getLastNMessages(int count, int? endAt) {
    if (endAt != null && (endAt < 0 || endAt >= messages.length)) {
      return [];
    }
    int end = switch(endAt) {
      null => messages.length,
      _ => endAt
    };

    var start = max(0, end - count);

    return messages.sublist(start, end);
  }
}

class ChatMessage {
  ChatMessage(
      {required this.sender, required this.timestamp, required this.contents});
  int sender;
  DateTime timestamp;
  String contents;
}
