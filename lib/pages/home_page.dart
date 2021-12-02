import 'package:flutter/material.dart';
import 'package:mise_news/components/feeds_list.dart';
import 'package:mise_news/components/search_delegate.dart';
import 'package:mise_news/components/side_menu.dart';
import 'package:mise_news/constants/app_constants.dart';
import 'package:mise_news/services/api.dart';

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
    _getFeedsFuture = getFeeds(query: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MISE News"),
        centerTitle: true,
        backgroundColor: blue,
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
        backgroundColor: blue,
        onPressed: () {
          setState(() {
            _getFeedsFuture = getFeeds(query: null);
          });
        },
      ),
      drawer: const SideMenu(),
    );
  }
}
