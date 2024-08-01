import 'package:feature_mind_demo/news/data/data_sources/local/LocalStorageService.dart';
import 'package:feature_mind_demo/news/domain/repositories/search_history_repository.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final LocalStorageService localStorageService;

  SearchHistoryRepositoryImpl(this.localStorageService);

  @override
  Future<List<String>> getSearchHistory() async {
    print("Olduuuuuuu");
    return await localStorageService.getSearchHistory();
  }

  @override
  Future<void> addSearchToHistory(String query) async {
    await localStorageService.addSearchToHistory(query);
  }

  @override
  Future<void> clearSearchHistory() async {
    await localStorageService.clearSearchHistory();
  }
}
