import 'package:feature_mind_demo/news/data/data_sources/local/LocalStorageService.dart';
import 'package:feature_mind_demo/news/data/models/NewsArticle.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_sources/remote/ApiService.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiService _apiService;
  final LocalStorageService _localStorageService;

  NewsRepositoryImpl(this._apiService, this._localStorageService);

  @override
  Future<List<NewsArticleModel>> fetchNews(String query) async {
    // Önbelleği kontrol et
    List<NewsArticleModel> cachedArticles =
        await _localStorageService.getCachedNews(query);
    int? cachedTime = await _localStorageService.getCachedTime(query);

    // Önbellek varsa ve 5 dakika geçmemişse, önbellekten döndür
    if (cachedArticles.isNotEmpty &&
        cachedTime != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTime < 300000) {
      return cachedArticles;
    }

    // API'den veriyi çek ve önbelleğe al
    List<NewsArticleModel> newsArticles =
        await _apiService.fetchNewsFromApi(query);
    await _localStorageService.cacheNews(query, newsArticles);

    return newsArticles;
  }
}
