import 'package:feature_mind_demo/core/constants/Constants.dart';
import 'package:feature_mind_demo/news/presentation/providers/newsProvider.dart';
import 'package:feature_mind_demo/news/presentation/widgets/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:animation_list/animation_list.dart';

class ResultPage extends ConsumerWidget {
  final String query;

  ResultPage({required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsProvider);
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref.read(newsProvider.notifier).loadMore(query);
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Results for "$query"')),
      body: newsState.isLoading && newsState.articles.isEmpty
          ? Center(
              child: Lottie.asset(Constants.LOADING_ANIMATION_PATH,
                  width: 200, height: 200, fit: BoxFit.fill),
            )
          : newsState.error != null
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "There is an error,please check your internet connection and try again",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : AnimationList(
                  controller: scrollController,
                  duration: 1500,
                  reBounceDepth: 30,
                  children: [
                    ...newsState.articles.map((article) {
                      return NewsTile(article: article);
                    }),
                    if (newsState.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
    );
  }
}
