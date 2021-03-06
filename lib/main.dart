import 'package:flutter/material.dart';
import 'package:mise_news/pages/home_page.dart';
import 'package:mise_news/services/notifications.dart';
import 'package:workmanager/workmanager.dart';

const String newFeed = 'NEW_FEED';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

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
