import 'package:feature_mind_demo/dependency_injection/injection_container.dart';
import 'package:feature_mind_demo/news/domain/use_case/add_search_history.dart';
import 'package:feature_mind_demo/news/domain/use_case/clear_search_history.dart';
import 'package:feature_mind_demo/news/domain/use_case/get_search_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchHistoryProvider =
    StateNotifierProvider<SearchHistoryNotifier, List<String>>((ref) {
  final getSearchHistory = ref.read(getSearchHistoryProvider);
  final addSearchHistory = ref.read(addSearchHistoryProvider);
  final clearSearchHistory = ref.read(clearSearchHistoryProvider);

  return SearchHistoryNotifier(
    getSearchHistory,
    addSearchHistory,
    clearSearchHistory,
  );
});

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  final GetSearchHistory getSearchHistory;
  final AddSearchToHistory addSearchToHistory;
  final ClearSearchHistory clearSearchHistory;

  SearchHistoryNotifier(
      this.getSearchHistory, this.addSearchToHistory, this.clearSearchHistory)
      : super([]) {
    _loadHistory();
    print("LOAD İŞLEMİ OLDUU");
  }

  void _loadHistory() async {
    state = await getSearchHistory.call();
    print(state);
  }

  void addSearch(String query) async {
    await addSearchToHistory(query);
    state = await getSearchHistory.call();
  }

  void clearHistory() async {
    await clearSearchHistory.call();
    state = [];
  }
}
