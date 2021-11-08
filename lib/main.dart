import 'package:flutter/material.dart';
import 'package:rss_reader/pages/home_page.dart';
import 'package:rss_reader/services/notifications.dart';
import 'package:workmanager/workmanager.dart';

const String newFeed = 'NEW_FEED';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rss Reader",
      home: Homepage(),
    );
  }
}
