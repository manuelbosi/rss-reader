import 'package:flutter/material.dart';
import 'package:rss_reader/models/feed.dart';
import 'package:rss_reader/services/api.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomSearchDelegate extends SearchDelegate {
  final Future getFeedsFuture;
  CustomSearchDelegate({required this.getFeedsFuture});

  @override
  String get searchFieldLabel => 'Cerca...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear_sharp),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: getFeeds(query: query),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          final List<FeedModel> feeds = snapshot.data as List<FeedModel>;

          if (feeds.isEmpty) {
            return const Center(
              child: Text(
                "Nessun feed trovato",
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            itemCount: feeds.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey.shade600, width: 0.3),
                  )),
                  child: ListTile(
                    title: Text(
                      feeds[index].title,
                      style: const TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      launch(feeds[index].link);
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.grey.shade600,
          ));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
