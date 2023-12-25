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
      {required this.assets,
      required this.name,
      required this.images,
      required this.description,
      required this.location});

  // The AssetBundle used to retrieve assets for the given gardener.
  AssetBundle assets;

  // The name of the user.
  String name;

  // A list of image assetNames that can be retrieved by loading them from |assets|.
  // Can be empty.
  List<String> images;

  // A description of the user.
  String description;

  // The location of the user.
  LocationData location;
}

class GardenerProfile extends BaseProfile {
  GardenerProfile(
      {required super.assets,
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
      {required super.assets,
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
