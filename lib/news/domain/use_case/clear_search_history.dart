import 'package:feature_mind_demo/news/domain/repositories/search_history_repository.dart';

class ClearSearchHistory {
  final SearchHistoryRepository repository;

  ClearSearchHistory(this.repository);

  Future<void> call() async {
    await repository.clearSearchHistory();
  }
}
