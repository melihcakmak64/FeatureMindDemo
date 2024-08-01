import 'package:feature_mind_demo/controller/newsProvider.dart';
import 'package:feature_mind_demo/controller/searchHistoryProvider.dart';
import 'package:feature_mind_demo/view/ResultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentSearchesWidget extends ConsumerWidget {
  const RecentSearchesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchHistory = ref.watch(searchHistoryProvider);

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
