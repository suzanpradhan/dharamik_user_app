part of 'news_screen_bloc.dart';

@immutable
abstract class NewsScreenState {
  NewsScreenState();
}

class NewsScreenLoading extends NewsScreenState {
  NewsScreenLoading();
}

class NewsScreenLoaded extends NewsScreenState{
  final List<NewsModel> newsList;
  NewsScreenLoaded(this.newsList);
}

