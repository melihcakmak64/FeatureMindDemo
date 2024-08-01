// presentation/providers/news_provider.dart
import 'package:feature_mind_demo/model/NewsArticle.dart';
import 'package:feature_mind_demo/services/ApiService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) {
  return NewsNotifier(ApiService());
});

class NewsState {
  final List<NewsArticle> articles;
  final bool isLoading;
  final String? error;

  NewsState({required this.articles, required this.isLoading, this.error});
}

class NewsNotifier extends StateNotifier<NewsState> {
  final ApiService _apiService;

  NewsNotifier(this._apiService)
      : super(NewsState(articles: [], isLoading: false));

  Future<void> fetchNews(String query) async {
    try {
      state = NewsState(articles: state.articles, isLoading: true);
      List<NewsArticle> articles = await _apiService.fetchNews(query);
      state = NewsState(articles: articles, isLoading: false);
    } catch (e) {
      state = NewsState(articles: [], isLoading: false, error: e.toString());
    }
  }
}
