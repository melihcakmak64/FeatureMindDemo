import 'package:cached_network_image/cached_network_image.dart';
import 'package:feature_mind_demo/constants/Constants.dart';
import 'package:feature_mind_demo/model/NewsArticle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NewsTile extends StatelessWidget {
  final NewsArticle article;
  const NewsTile({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(
          width: 100,
          imageUrl: article.thumbnail,
          placeholder: (context, url) =>
              Lottie.asset(Constants.LOADING_ANIMATION_PATH),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(article.headline),
        subtitle: Text(article.trailText),
      ),
    );
  }
}
