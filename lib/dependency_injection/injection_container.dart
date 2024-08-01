import 'package:feature_mind_demo/news/data/data_sources/local/LocalStorageService.dart';
import 'package:feature_mind_demo/news/data/data_sources/remote/ApiService.dart';
import 'package:feature_mind_demo/news/data/repositories/NewsRepositoryImpl.dart';
import 'package:feature_mind_demo/news/data/repositories/SearchHistoryImpl.dart';
import 'package:feature_mind_demo/news/domain/repositories/news_repository.dart';
import 'package:feature_mind_demo/news/domain/repositories/search_history_repository.dart';
import 'package:feature_mind_demo/news/domain/use_case/add_search_history.dart';
import 'package:feature_mind_demo/news/domain/use_case/clear_search_history.dart';
import 'package:feature_mind_demo/news/domain/use_case/get_news_articles.dart';
import 'package:feature_mind_demo/news/domain/use_case/get_search_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageServiceProvider =
    Provider<LocalStorageService>((ref) => LocalStorageService.instance);
final apiServiceProvider = Provider<ApiService>((ref) => ApiService.instance);

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(
      ref.read(apiServiceProvider), ref.read(localStorageServiceProvider));
});

final getNewsArticlesProvider = Provider<GetNewsArticles>((ref) {
  return GetNewsArticles(ref.read(newsRepositoryProvider));
});

final searchHistoryRepositoryProvider =
    Provider<SearchHistoryRepository>((ref) {
  return SearchHistoryRepositoryImpl(ref.read(localStorageServiceProvider));
});

final getSearchHistoryProvider = Provider<GetSearchHistory>((ref) {
  return GetSearchHistory(ref.read(searchHistoryRepositoryProvider));
});

final addSearchHistoryProvider = Provider<AddSearchToHistory>((ref) {
  return AddSearchToHistory(ref.read(searchHistoryRepositoryProvider));
});

final clearSearchHistoryProvider = Provider<ClearSearchHistory>((ref) {
  return ClearSearchHistory(ref.read(searchHistoryRepositoryProvider));
});
