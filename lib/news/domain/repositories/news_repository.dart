import 'package:feature_mind_demo/news/domain/entity/NewsEntity.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> fetchNews(String query);
}
