class FeedModel {
  String title;
  String description;
  String link;

  FeedModel({
    required this.title,
    required this.description,
    required this.link,
  });

  factory FeedModel.fromData(dynamic data) {
    final String title = data.title;
    final String description = data.description;
    final String link = data.link;

    return FeedModel(title: title, description: description, link: link);
  }
}
