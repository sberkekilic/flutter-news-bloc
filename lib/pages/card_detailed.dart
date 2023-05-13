import 'package:flutter/material.dart';
import '../models/article.dart';

class DetailPage extends StatelessWidget {
  final NewsArticle article;
  final int articleIndex;

  const DetailPage({Key? key, required this.article, required this.articleIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.index.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    article.publishedDate,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    article.content,
                    style: TextStyle(
                      fontSize: 18.0,
                      height: 1.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: article.index == 1
                              ? null
                              : ()=> Navigator.pop(context, articleIndex - 1),
                          icon: Icon(Icons.arrow_back_ios),
                        color: article.index == 1
                        ? Colors.grey
                            : Colors.blue
                      ),
                      IconButton(
                          onPressed: article.index == 10
                              ? null
                              : ()=> Navigator.pop(context, articleIndex + 1),
                          icon: Icon(Icons.arrow_forward_ios),
                          color: article.index == 10
                              ? Colors.grey
                              : Colors.blue
                      ),
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
