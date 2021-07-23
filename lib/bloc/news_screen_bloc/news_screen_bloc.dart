import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/news_model.dart';
import 'package:webapp/repositories/news_repository.dart';
import 'package:webapp/utils/service_locator.dart';

part 'news_screen_event.dart';
part 'news_screen_state.dart';

class NewsScreenBloc extends Bloc<NewsScreenEvent, NewsScreenState> {
  List<NewsModel> newsList = List();
  NewsRepo _newsSectionRepo = locator<NewsRepo>();
  @override
  NewsScreenState get initialState => NewsScreenLoading();

  @override
  Stream<NewsScreenState> mapEventToState(
    NewsScreenEvent event,
  ) async* {
    if(event is GetInitialNews){
      yield NewsScreenLoading();
      newsList = List();
      var initialNews = await _newsSectionRepo.getNewsItems();
      this.newsList.addAll(initialNews);
      yield NewsScreenLoaded(this.newsList);
    } else if(event is GetNextNews){
      var nextNews = await _newsSectionRepo.getNextNewsItems();
      this.newsList.addAll(nextNews);
      yield NewsScreenLoaded(newsList);
    }
  }
}
