part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {
  DashboardState();
}

class DashboardLoading extends DashboardState {
  DashboardLoading();
}

class DashboardLoaded extends DashboardState{
  final MarketTrendModel marketTrendModel;
  final List<SegmentModel> segments;
  final List<NewsModel> news;
  DashboardLoaded(this.marketTrendModel,this.segments,this.news);
}

class DashboardErrorState extends DashboardState{
  final String errorMessage;
  DashboardErrorState(this.errorMessage);
}
