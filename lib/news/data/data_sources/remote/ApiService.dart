import 'package:dio/dio.dart';
import 'package:feature_mind_demo/core/constants/Constants.dart';
import 'package:feature_mind_demo/news/data/models/NewsArticle.dart';

class ApiService {
  static ApiService? _instance;

  final Dio _dio = Dio();
  final String _apiKey = Constants.API_KEY;
  final String _baseUrl = Constants.BASE_URL;

  static ApiService get instance {
    _instance ??= ApiService._();

    return _instance!;
  }

  ApiService._();
  Future<List<NewsArticleModel>> fetchNewsFromApi(String query) async {
    final response = await _dio.get('$_baseUrl/search', queryParameters: {
      'q': query,
      'api-key': _apiKey,
      'page-size': 10,
      'show-fields': 'thumbnail,headline,trailText',
    });

    if (response.statusCode == 200) {
      List articles = response.data['response']['results'];
      return articles
          .map((article) => NewsArticleModel.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load news from API');
    }
  }
}
