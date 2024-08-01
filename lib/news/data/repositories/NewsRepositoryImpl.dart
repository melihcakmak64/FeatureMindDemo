import 'package:feature_mind_demo/news/data/data_sources/local/LocalStorageService.dart';
import 'package:feature_mind_demo/news/data/models/NewsArticle.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_sources/remote/ApiService.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiService _apiService;
  final LocalStorageService _localStorageService;

  NewsRepositoryImpl(this._apiService, this._localStorageService);

  @override
  Future<List<NewsArticleModel>> fetchNews(String query, int page) async {
    // Check cache
    List<NewsArticleModel> cachedArticles =
        await _localStorageService.getCachedNews(query, page);
    int? cachedTime = await _localStorageService.getCachedTime(query, page);

    // Return cached articles if available and not expired
    if (cachedArticles.isNotEmpty &&
        cachedTime != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTime < 300000) {
      return cachedArticles;
    }

    // Fetch from API
    List<NewsArticleModel> newsArticles =
        await _apiService.fetchNewsFromApi(query, page);
    await _localStorageService.cacheNews(query, page, newsArticles);

    return newsArticles;
  }
}
