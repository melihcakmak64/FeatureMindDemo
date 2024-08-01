import 'dart:convert';
import 'package:feature_mind_demo/model/NewsArticle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  late final SharedPreferences _prefs;

  // Private constructor
  LocalStorageService._internal() {
    _init();
  }

  // Factory constructor
  factory LocalStorageService() {
    return _instance;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> cacheNews(String query, List<NewsArticle> articles) async {
    List<String> articlesJson =
        articles.map((article) => jsonEncode(article.toJson())).toList();
    await _prefs.setStringList('cachedNews_$query', articlesJson);
    await _prefs.setInt('cachedTime_$query',
        DateTime.now().millisecondsSinceEpoch); // Zaman damgası
  }

  Future<List<NewsArticle>> getCachedNews(String query) async {
    List<String>? articlesJson = _prefs.getStringList('cachedNews_$query');
    if (articlesJson != null) {
      return articlesJson
          .map((articleJson) => NewsArticle.fromJson(jsonDecode(articleJson)))
          .toList();
    } else {
      return [];
    }
  }

  Future<int?> getCachedTime(String query) async {
    return _prefs.getInt('cachedTime_$query'); // Zaman damgasını getir
  }

  Future<void> saveSearchHistory(String query) async {
    List<String>? searchHistory = _prefs.getStringList('searchHistory') ?? [];
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
      await _prefs.setStringList('searchHistory', searchHistory);
    }
  }

  Future<List<String>> getSearchHistory() async {
    return _prefs.getStringList('searchHistory') ?? [];
  }
}
