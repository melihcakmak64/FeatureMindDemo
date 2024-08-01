// data/services/local_storage_service.dart
import 'dart:convert';

import 'package:feature_mind_demo/model/NewsArticle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> cacheNews(List<NewsArticle> articles) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> articlesJson =
        articles.map((article) => jsonEncode(article.toJson())).toList();
    await prefs.setStringList('cachedNews', articlesJson);
  }

  Future<List<NewsArticle>> getCachedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? articlesJson = prefs.getStringList('cachedNews');
    if (articlesJson != null) {
      return articlesJson
          .map((articleJson) => NewsArticle.fromJson(jsonDecode(articleJson)))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> saveSearchHistory(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchHistory = prefs.getStringList('searchHistory') ?? [];
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
      await prefs.setStringList('searchHistory', searchHistory);
    }
  }

  Future<List<String>> getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('searchHistory') ?? [];
  }
}
