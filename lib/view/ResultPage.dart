// presentation/screens/results_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feature_mind_demo/controller/newsProvider.dart';
import 'package:feature_mind_demo/model/NewsArticle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends ConsumerWidget {
  final String query;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  ResultPage({required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Results for "$query"')),
      body: newsState.isLoading
          ? Center(
              child: Lottie.asset(
              "assets/loading.json",
            ))
          : ListView.builder(
              itemCount: newsState.articles.length,
              itemBuilder: (context, index) {
                NewsArticle article = newsState.articles[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    width: 100,
                    imageUrl: article.thumbnail,
                    placeholder: (context, url) =>
                        Lottie.asset("assets/loading.json"),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(article.headline),
                  subtitle: Text(article.trailText),
                );
              },
            ),
    );
  }
}
