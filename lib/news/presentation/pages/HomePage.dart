import 'package:feature_mind_demo/core/constants/Constants.dart';
import 'package:feature_mind_demo/news/presentation/providers/newsProvider.dart';
import 'package:feature_mind_demo/news/presentation/providers/searchHistoryProvider.dart';
import 'package:feature_mind_demo/news/presentation/pages/ResultPage.dart';
import 'package:feature_mind_demo/news/presentation/widgets/recent_searches_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchHistory = ref.watch(searchHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(Constants.HOME_APPBAR_TITLE)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: Constants.HOME_SEARCH_HINT,
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
                child: const Text(Constants.HOME_SEARCH_BUTTON),
              ),
              if (searchHistory.isNotEmpty) ...[
                const SizedBox(height: 20),
                RecentSearchesWidget(
                  searchHistory: searchHistory,
                )
              ],
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
