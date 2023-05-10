import 'package:equatable/equatable.dart';

import '/models/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoadInProgress extends NewsState {}

class NewsLoadSuccess extends NewsState {
  final List<Article> articles;

  const NewsLoadSuccess({required this.articles});

  @override
  List<Object> get props => [articles];
}

class NewsLoadFailure extends NewsState {
  final String error;

  const NewsLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
