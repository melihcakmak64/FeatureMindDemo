import 'package:feature_mind_demo/news/presentation/providers/newsProvider.dart';
import 'package:feature_mind_demo/news/presentation/providers/searchHistoryProvider.dart';
import 'package:feature_mind_demo/news/presentation/pages/ResultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentSearchesWidget extends ConsumerWidget {
  final List<String> searchHistory;
  const RecentSearchesWidget({Key? key, required this.searchHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Recent Searches',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: searchHistory.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(searchHistory[index]),
              onTap: () {
                ref.read(newsProvider.notifier).fetchNews(searchHistory[index]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ResultPage(query: searchHistory[index]),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
