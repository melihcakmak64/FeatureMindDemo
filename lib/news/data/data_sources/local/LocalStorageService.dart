import 'dart:convert';
import 'package:feature_mind_demo/news/data/models/NewsArticle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _prefs;

  static LocalStorageService get instance {
    _instance ??= LocalStorageService._();

    return _instance!;
  }

  LocalStorageService._();

  Future<void> cacheNews(
      String query, int page, List<NewsArticleModel> articles) async {
    List<String> articlesJson =
        articles.map((article) => jsonEncode(article.toJson())).toList();
    await _prefs!.setStringList('cachedNews_$query$page', articlesJson);
    await _prefs!.setInt(
        'cachedTime_$query$page', DateTime.now().millisecondsSinceEpoch);
  }

  Future<List<NewsArticleModel>> getCachedNews(String query, int page) async {
    List<String>? articlesJson =
        _prefs!.getStringList('cachedNews_$query$page');
    if (articlesJson != null) {
      return articlesJson
          .map((articleJson) =>
              NewsArticleModel.fromJson(jsonDecode(articleJson)))
          .toList();
    } else {
      return [];
    }
  }

  Future<int?> getCachedTime(String query, int page) async {
    return _prefs!.getInt('cachedTime_$query$page');
  }

  Future<List<String>> getSearchHistory() async {
    await _initializePrefs();
    return _prefs!.getStringList('search_history') ?? [];
  }

  Future<void> addSearchToHistory(String query) async {
    List<String> history = await getSearchHistory();

    if (history.contains(query)) {
      history.remove(query);
    }
    history.insert(0, query);

    if (history.length > 5) {
      history = history.sublist(0, 5); // Sadece ilk 5 eleman
    }

    await _prefs!.setStringList('search_history', history);
  }

  Future<void> clearSearchHistory() async {
    await _prefs!.remove('search_history');
  }

  // Asenkron başlatma fonksiyonu
  Future<void> _initializePrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
}
