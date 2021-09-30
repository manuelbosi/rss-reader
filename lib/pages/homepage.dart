import 'package:flutter/material.dart';
import 'package:rss_reader/components/feeds_list.dart';
import 'package:rss_reader/components/search_delegate.dart';
import 'package:rss_reader/components/side_menu.dart';
import 'package:rss_reader/constants/app_constants.dart';
import 'package:rss_reader/services/api.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // initialize empty future to prevent future called twice
  late Future _getFeedsFuture;

  @override
  void initState() {
    super.initState();
    _getFeedsFuture = getFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rss Reader"),
        centerTitle: true,
        backgroundColor: green,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate:
                        CustomSearchDelegate(getFeedsFuture: _getFeedsFuture));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: buildFeedList(_getFeedsFuture),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          setState(() {
            _getFeedsFuture = getFeeds();
          });
        },
      ),
      drawer: sideMenu(context),
    );
  }
}
