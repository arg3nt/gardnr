import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gardnr/db.dart';
import 'package:gardnr/discover_profile.dart';
import 'package:gardnr/objects.dart';

enum ActivePage { gardenerView, composterView, accountView }

enum EditMode { editing, previewing }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _profile = UserProfile();
  ActivePage? _activePage;
  EditMode _editMode = EditMode.editing;

  void _loadUser() async {
    var profile = await lookupSelfUser();
    if (mounted) {
      setState(() {
        _profile = profile;
        if (profile.gardenerProfile != null) {
          _activePage = ActivePage.gardenerView;
        } else if (profile.composterProfile != null) {
          _activePage = ActivePage.composterView;
        } else {
          _activePage = ActivePage.accountView;
        }
      });
    }
  }

  void _setActivePage(ActivePage page) {
    setState(() {
      _activePage = page;
    });
  }

  void _setEditMode(EditMode mode) {
    setState(() {
      _editMode = mode;
    });
  }

  void _removeGardenerImage(ImageDescription desc) {
    setState(() {
      _profile.gardenerProfile!.images.remove(desc);
    });
  }

  void _addGardenerImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _profile.gardenerProfile!.images.add(ImageDescription(
            source: ImageSource.file, path: result.files.single.path!));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Widget _buildAccountView(BuildContext context) {
    return const Text("Account view active!");
  }

  Widget _buildComposterView(BuildContext context) {
    return const Text("Composter view active!");
  }

  List<bool> _getSelected() {
    switch (_editMode) {
      case EditMode.editing:
        return [true, false];
      case EditMode.previewing:
        return [false, true];
    }
  }

  Widget _buildGardenerImageView() {
    List<Widget> images = [];
    for (var imgDesc in _profile.gardenerProfile!.images) {
      images.add(Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
              padding: const EdgeInsets.all(5),
              child: Image(
                image: switch (imgDesc.source) {
                  ImageSource.asset => AssetImage(imgDesc.path,
                      bundle: _profile.gardenerProfile!.assets),
                  ImageSource.file => FileImage(File(imgDesc.path)),
                  ImageSource.network => NetworkImage(imgDesc.path),
                } as ImageProvider<Object>,
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              )),
          SizedBox(
              height: 20,
              width: 20,
              child: IconButton(
                iconSize: 12,
                padding: EdgeInsets.zero,
                color: Colors.black,
                icon: const Icon(Icons.close),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => Colors.white,
                  ),
                ),
                onPressed: () => {_removeGardenerImage(imgDesc)},
              )),
        ],
      ));
    }

    images.add(Padding(
        padding: const EdgeInsets.all(5),
        child: IconButton(
            icon: const Icon(Icons.add),
            color: Colors.black,
            onPressed: () => {_addGardenerImage()})));

    return Container(
        height: 160,
        color: Theme.of(context).focusColor,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child:
                ListView(scrollDirection: Axis.horizontal, children: images)));
  }

  Widget _buildGardenerView(BuildContext context) {
    return switch (_editMode) {
      EditMode.editing => Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Your name, or your garden's name!"),
                initialValue: _profile.gardenerProfile!.name,
                onChanged: (value) => setState(() {
                  _profile.gardenerProfile!.name = value;
                }),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildGardenerImageView()),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "A description of your garden."),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                initialValue: _profile.gardenerProfile!.description,
                onChanged: (value) => setState(() {
                  _profile.gardenerProfile!.description = value;
                }),
              ),
            ],
          )),
      EditMode.previewing => DiscoverProfile(
          profile: _profile,
          nextTrigger: () {},
          newMatch: (user) {},
        ),
    };
  }

  Widget _buildLoadingView(BuildContext context) {
    return const Text("Loading user profile...");
  }

  @override
  Widget build(BuildContext context) {
    // Put together the page content
    if (_activePage == null) {
      return _buildLoadingView(context);
    }

    return Stack(alignment: Alignment.topCenter, children: [
      switch (_activePage!) {
        ActivePage.accountView => _buildAccountView(context),
        ActivePage.composterView => _buildComposterView(context),
        ActivePage.gardenerView => _buildGardenerView(context),
      },
      Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ToggleButtons(
                isSelected: _getSelected(),
                onPressed: (index) => {
                  if (index == 0)
                    _setEditMode(EditMode.editing)
                  else
                    _setEditMode(EditMode.previewing)
                },
                borderRadius: BorderRadius.circular(50),
                constraints: const BoxConstraints(minHeight: 40, minWidth: 80),
                children: const [Text("Edit"), Text("Preview")],
              ))),
    ]);
  }
}
