import 'package:dio/dio.dart';
import 'package:feature_mind_demo/model/NewsArticle.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _apiKey = 'fdec02fc-e090-44cb-a6b6-ec45a2df8eb2';
  final String _baseUrl = 'https://content.guardianapis.com';

  Future<List<NewsArticle>> fetchNews(String query) async {
    final response = await _dio.get('$_baseUrl/search', queryParameters: {
      'q': query,
      'api-key': _apiKey,
      'page-size': 10,
      'show-fields': 'thumbnail,headline,trailText',
    });

    if (response.statusCode == 200) {
      List articles = response.data['response']['results'];
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
