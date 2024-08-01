import 'package:feature_mind_demo/news/domain/repositories/news_repository.dart';

import '../entity/NewsEntity.dart';

class GetNewsArticles {
  final NewsRepository repository;

  GetNewsArticles(this.repository);

  Future<List<NewsArticle>> execute(String query, int page) async {
    return await repository.fetchNews(query, page);
  }
}
