import 'dart:convert';

import 'package:flutter/material.dart';

import 'article.dart';

class NewsListPage extends StatefulWidget {
  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<NewsArticle>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = fetchNews(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsListPage"),
      ),
      body: Center(
        child: FutureBuilder<List<NewsArticle>>(
          future: _articlesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailPage(news: items[index])));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(items[index].image),
                          Padding(padding: EdgeInsets.all(16)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(items[index].title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(
                                items[index].publishedDate,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                              SizedBox(height: 16),
                              Text('${items[index].excerpt}[...]',
                                  style: TextStyle(fontSize: 16, height: 1.5))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<List<NewsArticle>> fetchNews(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/news/news.json');
    final jsonItems = jsonDecode(jsonString)['articles'] as List<dynamic>;
    return jsonItems.map((jsonItem) => NewsArticle.fromJson(jsonItem)).toList();
  }
}

class NewsDetailPage extends StatefulWidget {
  final NewsArticle news;

  NewsDetailPage({required this.news});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  int _currentIndex = 0;
  late List<NewsArticle> _news = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  void _loadNews() async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/news/news.json');
    ;
    final jsonItems = jsonDecode(jsonString)['articles'] as List<dynamic>;
    _news =
        jsonItems.map((jsonItem) => NewsArticle.fromJson(jsonItem)).toList();
    _currentIndex =
        _news.indexWhere((element) => element.index == widget.news.index);
    setState(() {
      _loading = false;
    });
  }

  void _navigateToNews(int index) {
    if (index >= 0 && index < _news.length) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }
    if (_currentIndex >= _news.length) {
      return Center(child: Text("Invalid index"));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_news[_currentIndex].index.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(_news[_currentIndex].image),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_news[_currentIndex].title,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  Text(_news[_currentIndex].publishedDate,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  SizedBox(height: 16.0),
                  Text(_news[_currentIndex].content,
                      style: TextStyle(fontSize: 18, height: 1.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: _currentIndex == 0
                              ? null
                              : () => _navigateToNews(_currentIndex - 1),
                          child: Text("Previous")),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: _currentIndex == _news.length - 1
                              ? null
                              : () => _navigateToNews(_currentIndex + 1),
                          child: Text("Next"))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
