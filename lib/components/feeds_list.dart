import 'package:flutter/material.dart';
import 'package:rss_reader/constants/app_constants.dart';
import 'package:rss_reader/models/feed.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildFeedList(getFeedsFuture) {
  return FutureBuilder(
    future: getFeedsFuture,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final List<FeedModel> feeds = snapshot.data as List<FeedModel>;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(
                color: blue,
              ),
            );
          case ConnectionState.done:
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: feeds.length,
              itemBuilder: (BuildContext context, int index) {
                final String title = feeds[index].title;
                final String description = feeds[index].description;
                final String link = feeds[index].link;

                return Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Column(children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      )
                    ]),
                    subtitle:
                        Text(description, style: const TextStyle(fontSize: 16)),
                    trailing: IconButton(
                        onPressed: () {
                          launch(link);
                        },
                        icon: const Icon(Icons.link)),
                  ),
                );
              },
            );
          case ConnectionState.none:
            return const Center(
              child: Icon(Icons.error),
            );
          default:
            return const Center(
              child: Icon(Icons.error),
            );
        }
      }

      return const Center(
        child: CircularProgressIndicator(
          color: blue,
        ),
      );
    },
  );
}
