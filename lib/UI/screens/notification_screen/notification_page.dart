import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:webapp/models/notification_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/services/alerts_service.dart';
import 'package:webapp/utils/service_locator.dart';

notificationScreen(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NotificationsScreen();
      });
}

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationsBloc _notificationsBloc = NotificationsBloc();
  List<NotificationModel> notifications;

  StreamSubscription listener;
  AlertsService alertsService = locator<AlertsService>();

  @override
  void initState() {
    updateReadTime();
    _notificationsBloc.add(GetInitialNotifications());
    // checkNo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: IconButton(
                    tooltip: 'close',
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Notifications',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              BlocListener<NotificationsBloc, NotificationsState>(
                bloc: _notificationsBloc,
                listener: (context, state) {
                  if (state is NotificationsScreenLoaded) {
                    if (notifications == null) notifications = List();
                    notifications.addAll(state.notifications);

                    if (this.listener == null) {
                      alertsService.listeningToNotifications = true;
                      listener = alertsService.realtimeNotifications
                          .listen((notification) {
                        if (!checkIfNotificationExists(notification))
                          setState(() {
                            this.notifications.insert(0, notification);
                          });
                      });
                    }
                  }
                  setState(() {});
                },
                child: (notifications == null)
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      )
                    : (notifications.isEmpty)
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                'No Notifications',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                            return Container(
                              padding: EdgeInsets.all(15.0),
                              margin: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  )),
                              child: ListTile(
                                onTap: () {},
                                trailing: Icon(
                                  Icons.notifications_active,
                                  color: Colors.amber,
                                ),
                                title: Text(
                                  notifications[index].notificationTitle,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  notifications[index].notificationText,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }, childCount: notifications.length)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (listener != null) {
      alertsService.listeningToNotifications = false;
      listener.cancel();
    }
    super.dispose();
  }

  bool checkIfNotificationExists(NotificationModel notificationModel) {
    if (notifications == null) return false;
    var notification = notifications.firstWhere(
        (element) => notificationModel.notificationId == element.notificationId,
        orElse: () => null);
    return notification != null;
  }

  void updateReadTime() async {
    await UserRepository().UpdateReadTime();
  }
}
