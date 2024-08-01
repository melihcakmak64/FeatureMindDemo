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
  int _currentPage = 1;
  bool _hasMore = true;

  NewsNotifier(this._getNewsArticles)
      : super(NewsState(articles: [], isLoading: false));

  Future<void> fetchNews(String query, {int page = 1}) async {
    if (page == 1) resetPagination(); // Reset pagination for a new search

    if (!_hasMore) return; // Stop fetching if no more data is available

    try {
      state = NewsState(articles: state.articles, isLoading: true);
      List<NewsArticle> articles = await _getNewsArticles.execute(query, page);

      if (articles.isEmpty) {
        _hasMore = false; // No more data to fetch
      } else {
        state = NewsState(
            articles: [...state.articles, ...articles], isLoading: false);
        _currentPage = page;
      }
    } catch (e) {
      state = NewsState(
          articles: state.articles, isLoading: false, error: e.toString());
    }
  }

  void loadMore(String query) {
    fetchNews(query, page: _currentPage + 1);
  }

  void resetPagination() {
    _currentPage = 1;
    _hasMore = true;
    state = NewsState(articles: [], isLoading: false);
  }
}
