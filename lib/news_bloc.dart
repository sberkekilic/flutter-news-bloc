import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'blocs/news_event.dart';
import 'blocs/news_state.dart';
import 'models/article.dart';
import 'repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(NewsLoadInProgress());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsRequested) {
      yield* _mapNewsRequestedToState();
    }
  }

  Stream<NewsState> _mapNewsRequestedToState() async* {
    try {
      final articles = await newsRepository.getTopHeadlines();
      yield NewsLoadSuccess(articles: articles);
    } catch (e) {
      yield NewsLoadFailure(error: e.toString());
    }
  }
}

class NewsApiClient {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = '0f5d4c5bb57f431999159f9ad7d386ca';
  final http.Client httpClient;
  NewsApiClient({required this.httpClient});

  Future<List<Article>> fetchTopHeadlines() async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final Iterable articlesJson = jsonResponse['articles'];
      return articlesJson.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}


