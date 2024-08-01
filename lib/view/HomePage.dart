import 'package:feature_mind_demo/controller/newsProvider.dart';
import 'package:feature_mind_demo/controller/searchHistoryProvider.dart';
import 'package:feature_mind_demo/view/ResultPage.dart';
import 'package:feature_mind_demo/view/widgets/recent_searches_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class HomePage extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsProvider);
    final searchHistory = ref.watch(searchHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Search News')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  ref
                      .read(searchHistoryProvider.notifier)
                      .addSearch(_controller.text);
                  ref.read(newsProvider.notifier).fetchNews(_controller.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ResultPage(query: _controller.text)),
                  );
                } else {
                  showMessage(context, 'Please enter a search term');
                }
              },
              child: const Text('Search'),
            ),
            if (newsState.error != null) Text('Error: ${newsState.error}'),
            if (searchHistory.isNotEmpty) ...[
              const SizedBox(height: 20),
              const RecentSearchesWidget()
            ],
          ],
        ),
      ),
    );
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
