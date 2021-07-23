part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent {
  NotificationsEvent();
}

class GetInitialNotifications extends NotificationsEvent{
  GetInitialNotifications();
}

class GetNextNotifications extends NotificationsEvent{
  GetNextNotifications();
}
