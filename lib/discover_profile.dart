import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gardnr/objects.dart';

class DiscoverProfile extends StatefulWidget {
  const DiscoverProfile({super.key, required this.profile});

  final UserProfile profile;

  @override
  State<DiscoverProfile> createState() => DiscoverProfileState();
}

class DiscoverProfileState extends State<DiscoverProfile> {
  int _carouselIndex = 0;

  void advanceCarousel() {
    setState(() {
      if (++_carouselIndex >= widget.profile.gardenerProfile!.images.length) {
        _carouselIndex = 0;
      }
    });
  }

  void retreatCarousel() {
    setState(() {
      if (--_carouselIndex < 0) {
        _carouselIndex = widget.profile.gardenerProfile!.images.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var imgDesc = widget.profile.gardenerProfile!.images[_carouselIndex];
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Stack(alignment: Alignment.center, children: [
          Image(
              image: switch (imgDesc.source) {
                ImageSource.asset => AssetImage(imgDesc.path,
                    bundle: widget.profile.gardenerProfile!.assets),
                ImageSource.file => FileImage(File(imgDesc.path)),
              } as ImageProvider<Object>,
              fit: BoxFit.fitHeight,
              height: double.infinity,
              width: double.infinity),
          Row(
            children: [
              IconButton(
                  iconSize: 40,
                  onPressed: () => {retreatCarousel()},
                  icon: const Icon(Icons.chevron_left, color: Colors.white)),
              const Spacer(flex: 1),
              IconButton(
                  iconSize: 40,
                  onPressed: () => {advanceCarousel()},
                  icon: const Icon(Icons.chevron_right, color: Colors.white))
            ],
          )
        ]),
        Container(
            padding:
                const EdgeInsets.only(top: 75, bottom: 10, left: 10, right: 10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0xCC000000)],
            )),
            width: double.infinity,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: const Color(0xFFFFFFFF)),
                      widget.profile.gardenerProfile!.name),
                  Text(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: const Color(0xFFFFFFFF)),
                      widget.profile.gardenerProfile!.description),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 1),
                      Center(
                          child: IconButton(
                              iconSize: 40,
                              onPressed: () => {},
                              icon: const Icon(Icons.favorite,
                                  color: Colors.green))),
                      const Spacer(flex: 1),
                      Center(
                          child: IconButton(
                              iconSize: 40,
                              onPressed: () => {},
                              icon:
                                  const Icon(Icons.close, color: Colors.red))),
                      const Spacer(flex: 1),
                    ],
                  ),
                ])),
      ],
    );
  }
}
