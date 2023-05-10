import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:isar_starter_project/repository/news_repository.dart';
import 'news_bloc.dart';
import 'pages/home_page.dart';

void main() {
  final NewsApiRepository newsApiRepository = NewsApiRepository(httpClient: http.Client(), newsApiClient: null);
  final NewsRepository newsRepository = NewsRepository(newsApiRepository: newsApiRepository);
  final NewsBloc newsBloc = NewsBloc(newsRepository: newsRepository);

  runApp(MyApp(
    newsBloc: newsBloc,
    newsRepository: newsRepository,
  ));
}

class MyApp extends StatelessWidget {
  final NewsBloc newsBloc;
  final NewsRepository newsRepository;

  MyApp({required this.newsBloc, required this.newsRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isar Starter Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider.value(
        value: newsBloc,
        child: HomePage(),
      ),
    );
  }
}

