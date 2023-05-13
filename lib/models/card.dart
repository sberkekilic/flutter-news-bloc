import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../pages/card_detailed.dart';
import 'article.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(article.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(article.title, style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(article.publishedDate, style: Theme.of(context).textTheme.caption),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(article.excerpt),
          ),
        ],
      ),
    );
  }
}

class NewsData {

  Future<String> _loadArticleAsset() async {
    final String? jsonString = await rootBundle.loadString('assets/news/news.json');
    return jsonString ?? 'boş';
  }


  Future<List<NewsArticle>> getArticles() async {
    final String jsonData = await _loadArticleAsset();
    final dynamic jsonResult = json.decode(jsonData);

    if (jsonResult is List) {
      return jsonResult.map((article) => NewsArticle.fromJson(article)).toList();
    } else if (jsonResult is Map) {
      final List<dynamic> articlesList = jsonResult['articles'];
      return articlesList.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

}




