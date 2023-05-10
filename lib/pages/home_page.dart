import 'package:flutter/material.dart';
import 'package:isar_starter_project/news-page.dart';
import '../repository/news_repository.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  final NewsRepository newsRepository = NewsRepository(newsApiClient: NewsApiClient(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage(newsRepository: newsRepository)),
                );
              },
              child: Text('Continue as guest'),
            ),
          ],
        ),
      ),
    );
  }
}
