class NewsArticle {
  final String title;
  final String image;
  final String publishedDate;
  final String content;
  final String excerpt;

  NewsArticle({
    required this.title,
    required this.image,
    required this.publishedDate,
    required this.content,
    required this.excerpt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      image: json['image'],
      publishedDate: json['published-date'],
      content: json['content'],
      excerpt: json['content'].toString().substring(0, 100),
    );
  }
}
