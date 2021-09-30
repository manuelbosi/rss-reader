import 'package:rss_reader/models/feed.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_item.dart';

const String feedsUrl =
    'https://www.mise.gov.it/index.php/it/per-i-media/notizie?format=feed&type=rss';

Future<List<FeedModel>> getFeeds({String query = ''}) async {
  final response = await http.get(Uri.parse(feedsUrl));
  final RssFeed responseFeeds = RssFeed.parse(response.body);

  List<FeedModel> feedsList = responseFeeds.items!
      .map((RssItem singleFeed) => FeedModel.fromData(singleFeed))
      .toList();

  print(feedsList.first.title);

  if (query.isNotEmpty) return getFilteredFeeds(query, feedsList);

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
