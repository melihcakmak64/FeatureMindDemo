import 'package:feature_mind_demo/news/domain/repositories/search_history_repository.dart';

class AddSearchToHistory {
  final SearchHistoryRepository repository;

  AddSearchToHistory(this.repository);

  Future<void> call(String query) async {
    await repository.addSearchToHistory(query);
  }
}
