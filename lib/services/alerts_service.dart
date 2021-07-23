import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:webapp/models/notification_model.dart';
import 'package:webapp/models/premium_signal_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/utils/service_locator.dart';

class AlertsService {
  // Firestore _firestore;

  FirebaseFirestore _firestore;
  UserModel user = locator<UserModel>();
  bool listeningToSignals = false;
  bool listeningToNotifications = false;

  final StreamController<PremiumSignalModel> _signalsController =
      StreamController<PremiumSignalModel>.broadcast();

  Stream<PremiumSignalModel> get realtimeSignals =>
      _signalsController.stream.asBroadcastStream();

  final StreamController<NotificationModel> _notificationsController =
      StreamController<NotificationModel>.broadcast();

  Stream<NotificationModel> get realtimeNotifications =>
      _notificationsController.stream.asBroadcastStream();

  // AlertsService() {
  //   this._firestore = Firestore.instance;

  AlertsService() {
    this._firestore = FirebaseFirestore.instance;

    //subscribing to premium signals
    bool firstSignalShown = false;
    _firestore
        .collection('premium_signals')
        .where('membershipIds', arrayContains: user.membershipId)
        .orderBy('signalTimestamp', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      // snapshot.documentChanges.forEach((dc) {
      //   if (dc.type == DocumentChangeType.added) {
      //     if (firstSignalShown) {
      //       var model = PremiumSignalModel.fromDocumentSnapshot(dc.document);

      //       if (listeningToSignals) {
      //         _signalsController.sink.add(model);
      //       } else {
      //         final assetsAudioPlayer = AssetsAudioPlayer();

      //         assetsAudioPlayer.open(
      //           Audio("assets/audio/notification.mp3"),
      //         );
      //         assetsAudioPlayer.play();
      //         showSimpleNotification(Text('New Premium Signal'));
      //       }
      //     } else
      //       firstSignalShown = true;
      //   }
      // });

      snapshot.docChanges.forEach((dc) {
        if (dc.type == DocumentChangeType.added) {
          if (firstSignalShown) {
            var model = PremiumSignalModel.fromDocumentSnapshot(dc.doc);

            if (listeningToSignals) {
              _signalsController.sink.add(model);
            } else {
              final assetsAudioPlayer = AssetsAudioPlayer();

              assetsAudioPlayer.open(
                Audio("assets/audio/notification.mp3"),
              );
              assetsAudioPlayer.play();
              showSimpleNotification(Text('New Premium Signal'));
            }
          } else
            firstSignalShown = true;
        }
      });
    });

    //subscribing to global platform notifications
    if (user.membershipId != null) {
      bool firstNotificationShown = false;
      _firestore
          .collection('notifications')
          .where('filters', arrayContains: user.membershipId)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .snapshots()
          .listen((snapshot) {
        // snapshot.documentChanges.forEach((dc) {
        //   if (dc.type == DocumentChangeType.added) {
        //     if (firstNotificationShown) {
        //       var model = NotificationModel.fromDocumentSnapshot(dc.document);

        //       if (listeningToNotifications) {
        //         _notificationsController.sink.add(model);
        //       } else {
        //         final assetsAudioPlayer = AssetsAudioPlayer();

        //         assetsAudioPlayer.open(
        //           Audio("assets/audio/notification.mp3"),
        //         );
        //         assetsAudioPlayer.play();
        //         showSimpleNotification(Text('New Notification'));
        //       }
        //     } else
        //       firstNotificationShown = true;
        //   }
        // });

        snapshot.docChanges.forEach((dc) {
          if (dc.type == DocumentChangeType.added) {
            if (firstNotificationShown) {
              var model = NotificationModel.fromDocumentSnapshot(dc.doc);

              if (listeningToNotifications) {
                _notificationsController.sink.add(model);
              } else {
                final assetsAudioPlayer = AssetsAudioPlayer();

                assetsAudioPlayer.open(
                  Audio("assets/audio/notification.mp3"),
                );
                assetsAudioPlayer.play();
                showSimpleNotification(Text('New Notification'));
              }
            } else
              firstNotificationShown = true;
          }
        });
      });
    } else {
      bool firstNotificationShown = false;
      _firestore
          .collection('notifications')
          .where('filters', arrayContains: user.membershipId)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .snapshots()
          .listen((snapshot) {
        // snapshot.documentChanges.forEach((dc) {
        //   if (dc.type == DocumentChangeType.added) {
        //     if (firstNotificationShown) {
        //       var model = NotificationModel.fromDocumentSnapshot(dc.document);

        //       if (listeningToNotifications) {
        //         _notificationsController.sink.add(model);
        //       } else {
        //         final assetsAudioPlayer = AssetsAudioPlayer();

        //         assetsAudioPlayer.open(
        //           Audio("assets/audio/notification.mp3"),
        //         );
        //         assetsAudioPlayer.play();
        //         showSimpleNotification(Text('New Notification'));
        //       }
        //     } else
        //       firstNotificationShown = true;
        //   }
        // });

        snapshot.docChanges.forEach((dc) {
          if (dc.type == DocumentChangeType.added) {
            if (firstNotificationShown) {
              var model = NotificationModel.fromDocumentSnapshot(dc.doc);

              if (listeningToNotifications) {
                _notificationsController.sink.add(model);
              } else {
                final assetsAudioPlayer = AssetsAudioPlayer();

                assetsAudioPlayer.open(
                  Audio("assets/audio/notification.mp3"),
                );
                assetsAudioPlayer.play();
                showSimpleNotification(Text('New Notification'));
              }
            } else
              firstNotificationShown = true;
          }
        });
      });
    }
  }
}
