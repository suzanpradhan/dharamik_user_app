import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/market_trend_model.dart';
import 'package:webapp/models/news_model.dart';
import 'package:webapp/models/segment_model.dart';
import 'package:webapp/repositories/dashboard_repository.dart';
import 'package:webapp/repositories/news_repository.dart';
import 'package:webapp/utils/service_locator.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final dashboardRepo = locator<DashboardRepo>();
  final newsRepo = locator<NewsRepo>();

  @override
  DashboardState get initialState => DashboardLoading();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    yield DashboardLoading();

    if(event is GetDashboardData){
      try {
        var marketTrendData = await dashboardRepo.getMarketTrendDetails();
        var segments = await dashboardRepo.getSegments();
        var news = await newsRepo.getFeaturedNewsItems();
        yield DashboardLoaded(marketTrendData, segments,news);
      } catch (e) {
        yield DashboardErrorState(e.message);
      }
    }
  }
}
