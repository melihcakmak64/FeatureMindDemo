import 'package:feature_mind_demo/news/domain/repositories/search_history_repository.dart';

class GetSearchHistory {
  final SearchHistoryRepository repository;

  GetSearchHistory(this.repository);

  Future<List<String>> call() async {
    return await repository.getSearchHistory();
  }
}
