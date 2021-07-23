part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  DashboardEvent();
}

class GetDashboardData extends DashboardEvent{
  GetDashboardData();
}
