import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';
import '../news_bloc.dart';

class NewsRepository {
  final NewsApiRepository newsApiRepository;

  NewsRepository({required this.newsApiRepository});

  Future<List<Article>> getTopHeadlines() async {
    final response = await newsApiRepository.fetchTopHeadlines();
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final Iterable articlesJson = jsonResponse['articles'];
      return articlesJson.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class NewsApiRepository {
  final NewsApiClient newsApiClient;

  NewsApiRepository({required this.newsApiClient, required http.Client httpClient});

  Future<List<Article>> getTopHeadlines() async {
    final List<dynamic> headlines = await newsApiClient.fetchTopHeadlines();
    return headlines.map((article) => Article.fromJson(article)).toList();
  }

  fetchTopHeadlines() {}
}

