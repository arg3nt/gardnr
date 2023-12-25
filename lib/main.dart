import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gardnr/discover.dart';
import 'package:gardnr/messages.dart';
import 'package:gardnr/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gardnr',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gardnr 0.0.0'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 2;

  void _setPage(int newPage) {
    setState(() {
      _page = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageContent = switch (_page) {
      0 => DiscoverPage(),
      1 => MessagesPage(),
      2 => ProfilePage(),
      _ => const Text("yikes")
    };
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _page,
          onDestinationSelected: _setPage,
          destinations: [
            NavigationDestination(
                icon: SvgPicture.asset('images/discoverIcon.svg',
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn)),
                label: "Discover"),
                NavigationDestination(icon: SvgPicture.asset('images/messageIcon.svg',
                      height: 30,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor, BlendMode.srcIn)), label: "Messages"),
            NavigationDestination(icon: SvgPicture.asset('images/userIcon.svg',
                      height: 30,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor, BlendMode.srcIn)), label: "Profile")
          ]),
      body: pageContent, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
