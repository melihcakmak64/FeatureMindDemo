import 'package:dio/dio.dart';
import 'package:feature_mind_demo/constants/Constants.dart';
import 'package:feature_mind_demo/model/NewsArticle.dart';
import 'package:feature_mind_demo/services/LocalStorageService.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  final Dio _dio = Dio();
  final String _apiKey = Constants.API_KEY;
  final String _baseUrl = Constants.BASE_URL;
  final LocalStorageService _localStorageService;

  // Private constructor
  ApiService._internal() : _localStorageService = LocalStorageService();

  // Factory constructor
  factory ApiService() {
    return _instance;
  }

  Future<List<NewsArticle>> fetchNews(String query) async {
    // Sorguya göre önbelleği kontrol et
    List<NewsArticle> cachedArticles =
        await _localStorageService.getCachedNews(query);
    int? cachedTime = await _localStorageService.getCachedTime(query);

    // Eğer önbellek mevcut ve son güncelleme süresi 5 dakikadan azsa, önbelleği döndür
    if (cachedArticles.isNotEmpty &&
        cachedTime != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTime < 300000) {
      return cachedArticles; // Önbellekten sonuç döndür
    }

    // Önbellekte yoksa veya süresi dolmuşsa, API çağrısını yap
    final response = await _dio.get('$_baseUrl/search', queryParameters: {
      'q': query,
      'api-key': _apiKey,
      'page-size': 10,
      'show-fields': 'thumbnail,headline,trailText',
    });

    if (response.statusCode == 200) {
      List articles = response.data['response']['results'];
      List<NewsArticle> newsArticles =
          articles.map((article) => NewsArticle.fromJson(article)).toList();

      // API'den gelen sonuçları önbelleğe al
      await _localStorageService.cacheNews(query, newsArticles);

      return newsArticles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
