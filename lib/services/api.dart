import 'package:http/http.dart' as http;
import 'package:mise_news/services/shared_preferences.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mise_news/models/feed.dart';
import 'package:mise_news/services/notifications.dart';

const String feedsUrl =
    'https://www.mise.gov.it/index.php/it/per-i-media/notizie?format=feed&type=rss';

Future<List<FeedModel>> getFeeds({String? query = ''}) async {
  final response = await http.get(Uri.parse(feedsUrl));
  final RssFeed responseFeeds = RssFeed.parse(response.body);

  List<FeedModel> feedsList = responseFeeds.items!
      .map((RssItem singleFeed) => FeedModel.fromData(singleFeed))
      .toList();

  // Get filtered feeds if query is passed
  if (query != null && query.isNotEmpty) {
    return getFilteredFeeds(query, feedsList);
  }

  return feedsList;
}

List<FeedModel> getFilteredFeeds(String query, List<FeedModel> feedList) {
  List<FeedModel> foundedFeed = feedList.where((FeedModel item) {
    final String title = item.title.toString().toLowerCase();
    final String description = item.description.toString().toLowerCase();
    final String queryString = query.toLowerCase();
    return title.contains(queryString) || description.contains(queryString);
  }).toList();

  return foundedFeed;
}

Future<void> checkFeedsAndSendNotification() async {
  final String keyword = await getKeyword();
  final List<FeedModel> feeds = await getFeeds();

  bool canNotify = false;
  for (var i = 0; i < feeds.length; i++) {
    final FeedModel feed = feeds[i];

    final title = feed.title.toLowerCase();
    final description = feed.description.toLowerCase();

    if ((title.contains(keyword) || description.contains(keyword)) &&
        keyword.isNotEmpty) {
      canNotify = true;
    }
  }

  if (canNotify) {
    FlutterLocalNotificationsPlugin flip = setupNotification();
    showNotificationWithDefaultSound(flip);
  }
}
