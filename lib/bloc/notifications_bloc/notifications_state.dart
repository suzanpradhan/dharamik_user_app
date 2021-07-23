part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState {
  NotificationsState();
}

class NotificationsScreenLoading extends NotificationsState {
  NotificationsScreenLoading();
}

class NotificationsScreenLoaded extends NotificationsState{
  final List<NotificationModel> notifications;
  NotificationsScreenLoaded(this.notifications);
}

