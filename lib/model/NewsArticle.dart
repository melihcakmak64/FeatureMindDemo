class NewsArticle {
  final String headline;
  final String trailText;
  final String thumbnail;

  NewsArticle(
      {required this.headline,
      required this.trailText,
      required this.thumbnail});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      headline: json['fields']['headline'],
      trailText: json['fields']['trailText'],
      thumbnail: json['fields']['thumbnail'] ??
          '', // Görsel olmadığında boş string döndürün
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
