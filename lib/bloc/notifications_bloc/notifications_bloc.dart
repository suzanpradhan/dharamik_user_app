import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/notification_model.dart';
import 'package:webapp/repositories/notification_repository.dart';
import 'package:webapp/utils/service_locator.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  List<NotificationModel> notifications = List();
  NotificationsRepo _notificationsRepo = locator<NotificationsRepo>();

  @override
  NotificationsState get initialState => NotificationsScreenLoading();

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if(event is GetInitialNotifications){
      yield NotificationsScreenLoading();
      notifications = List();
      var initialNotifications = await _notificationsRepo.getNotifications();
      this.notifications.addAll(initialNotifications);
      yield NotificationsScreenLoaded(this.notifications);
    }else if(event is GetNextNotifications){
      var nextNotifications = await _notificationsRepo.getNextNotifications();
      this.notifications.addAll(nextNotifications);
      yield NotificationsScreenLoaded(this.notifications);
    }
  }
}
