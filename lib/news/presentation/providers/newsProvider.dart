// presentation/providers/news_provider.dart
import 'package:feature_mind_demo/dependency_injection/injection_container.dart';
import 'package:feature_mind_demo/news/domain/entity/NewsEntity.dart';
import 'package:feature_mind_demo/news/domain/use_case/get_news_articles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) {
  final getNewsArticles = ref.read(getNewsArticlesProvider);
  return NewsNotifier(getNewsArticles);
});

class NewsState {
  final List<NewsArticle> articles;
  final bool isLoading;
  final String? error;

  NewsState({required this.articles, required this.isLoading, this.error});
}

class NewsNotifier extends StateNotifier<NewsState> {
  final GetNewsArticles _getNewsArticles;

  NewsNotifier(this._getNewsArticles)
      : super(NewsState(articles: [], isLoading: false));

  Future<void> fetchNews(String query) async {
    try {
      state = NewsState(articles: state.articles, isLoading: true);
      List<NewsArticle> articles = await _getNewsArticles.execute(query);
      state = NewsState(articles: articles, isLoading: false);
    } catch (e) {
      state = NewsState(articles: [], isLoading: false, error: e.toString());
    }
  }
}
