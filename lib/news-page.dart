import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/news_event.dart';
import '/blocs/news_state.dart';
import '/widgets/news_list_item.dart';
import 'news_bloc.dart';
import 'repository/news_repository.dart';

class NewsPage extends StatelessWidget {
  final NewsRepository newsRepository;

  const NewsPage({Key? key, required this.newsRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(newsRepository: newsRepository)..add(NewsRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewsLoadSuccess) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return NewsListItem(article: article);
                },
              );
            } else if (state is NewsLoadFailure) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
