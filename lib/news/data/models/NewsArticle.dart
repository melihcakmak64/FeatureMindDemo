import 'package:feature_mind_demo/news/domain/entity/NewsEntity.dart';

class NewsArticleModel extends NewsArticle {
  NewsArticleModel({
    required String headline,
    required String trailText,
    required String thumbnail,
  }) : super(
          headline: headline,
          trailText: trailText,
          thumbnail: thumbnail,
        );

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      headline: json['fields']['headline'],
      trailText: json['fields']['trailText'],
      thumbnail: json['fields']['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fields': {
        'headline': headline,
        'trailText': trailText,
        'thumbnail': thumbnail.isNotEmpty ? thumbnail : "",
      },
    };
  }
}
