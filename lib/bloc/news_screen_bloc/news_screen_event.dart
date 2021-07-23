part of 'news_screen_bloc.dart';

@immutable
abstract class NewsScreenEvent {
  NewsScreenEvent();
}

class GetInitialNews extends NewsScreenEvent{
  GetInitialNews();
}

class GetNextNews extends NewsScreenEvent{
  GetNextNews();
}
