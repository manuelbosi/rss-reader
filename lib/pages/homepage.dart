import 'package:flutter/material.dart';

List<String> menuEntries = [
  "Settings",
];

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rss Reader"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
