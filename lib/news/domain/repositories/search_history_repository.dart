abstract class SearchHistoryRepository {
  Future<List<String>> getSearchHistory();
  Future<void> addSearchToHistory(String query);
  Future<void> clearSearchHistory();
}
