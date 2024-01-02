import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gardnr/discover.dart';
import 'package:gardnr/messages.dart';
import 'package:gardnr/profile.dart';

void main() {
  runApp(const GardnrRoot());
}

// This widget is the "root" of the application. Everything
// contained within the application is rendered by direct or
// transitive inclusion in the build() method of this widget.
class GardnrRoot extends StatelessWidget {
  const GardnrRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gardnr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const GardnrScaffolding(),
    );
  }
}

// This widget's purpose is to create the bottom nav bar
// and keep track of which page is currently active.
class GardnrScaffolding extends StatefulWidget {
  const GardnrScaffolding({super.key});

  @override
  State<GardnrScaffolding> createState() => _GardnrScaffoldingState();
}

// Used to represent the active pages.
// NOTE: the ordering of these enum values corresponds to the order
// of the icons in the bottom nav. If those change, the order of
// these enum values must also change to match, otherwise the mapping
// from nav inputs to enum values will break.
enum ActivePage { discover, messages, profile }

class _GardnrScaffoldingState extends State<GardnrScaffolding> {
  ActivePage _page = ActivePage.discover;

  void _setPage(int newPage) {
    setState(() {
      _page = ActivePage.values[newPage];
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageContent = switch (_page) {
      ActivePage.discover => const DiscoverPage(),
      ActivePage.messages => const MessagesPage(),
      ActivePage.profile => const ProfilePage(),
    };

    return Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: _page.index,
          onDestinationSelected: _setPage,
          destinations: [
            NavigationDestination(
                icon: SvgPicture.asset('images/discoverIcon.svg',
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn)),
                label: "Discover"),
            NavigationDestination(
                icon: SvgPicture.asset('images/messageIcon.svg',
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn)),
                label: "Messages"),
            NavigationDestination(
                icon: SvgPicture.asset('images/userIcon.svg',
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn)),
                label: "Profile")
          ]),
      body:
          pageContent,
    );
  }
}
