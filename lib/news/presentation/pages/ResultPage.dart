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

    return Scaffold(
      appBar: AppBar(title: Text('Results for "$query"')),
      body: newsState.isLoading
          ? Center(
              child: Lottie.asset(
                Constants.LOADING_ANIMATION_PATH,
              ),
            )
          : Center(
              child: AnimationList(
                duration: 1500,
                reBounceDepth: 30,
                children: newsState.articles.map((article) {
                  return NewsTile(article: article);
                }).toList(),
              ),
            ),
    );
  }
}
