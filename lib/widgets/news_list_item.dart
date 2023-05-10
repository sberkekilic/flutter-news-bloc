import 'package:flutter/material.dart';
import '../models/article.dart';

import '../pages/article_details_page.dart';

class NewsListItem extends StatelessWidget {
  final Article article;

  const NewsListItem({required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsPage(article: article),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              article.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Source: ${article.source.name}',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 4),
            Text(
              'Published at: ${article.publishedAt}',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Divider(
              color: Colors.grey[400],
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
