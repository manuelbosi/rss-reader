import 'package:rss_reader/models/feed.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_item.dart';

const String feedsUrl =
    'https://www.mise.gov.it/index.php/it/per-i-media/notizie?format=feed&type=rss';

Future<List<FeedModel>> getFeeds() async {
  final response = await http.get(Uri.parse(feedsUrl));
  final RssFeed responseFeeds = RssFeed.parse(response.body);

  List<FeedModel> feedsList = responseFeeds.items!
      .map((RssItem singleFeed) => FeedModel.fromData(singleFeed))
      .toList();

  print(feedsList.first.title);

  return feedsList;
}
