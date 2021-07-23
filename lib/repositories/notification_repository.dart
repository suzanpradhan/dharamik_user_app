import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/models/notification_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/utils/service_locator.dart';

class NotificationsRepo {
  // final Firestore _firestore;
  final FirebaseFirestore _firestore;
  DocumentSnapshot lastSnapshot;
  DocumentSnapshot lastSnapshot2;

  // NotificationsRepo() : _firestore = Firestore.instance;

  NotificationsRepo() : _firestore = FirebaseFirestore.instance;

  Future getNotifications() async {
    try {
      UserModel user = locator<UserModel>();
      List<NotificationModel> notifications = [];
      QuerySnapshot snapshot;
      if (user.membershipId != null) {
        // snapshot = await _firestore
        //     .collection('notifications')
        //     .where('filters', arrayContains: user.membershipId)
        //     .orderBy('timestamp', descending: true)
        //     .limit(10)
        //     .getDocuments();

        // snapshot.documents.forEach((document) {
        //   notifications.add(NotificationModel.fromDocumentSnapshot(document));
        //   lastSnapshot = document;
        // });

        snapshot = await _firestore
            .collection('notifications')
            .where('filters', arrayContains: user.membershipId)
            .orderBy('timestamp', descending: true)
            .limit(10)
            .get();

        snapshot.docs.forEach((document) {
          notifications.add(NotificationModel.fromDocumentSnapshot(document));
          lastSnapshot = document;
        });
      }

      return notifications;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future getNoNotifications() async {
    try {
      List<NotificationModel> notifications = [];
      QuerySnapshot snapshot;

      int isNewNotification = 0;
      UserModel u = await UserRepository().getCurrentUserFromDatabase();

      print('timestamp ${u.lastNotificationRead.seconds.toString()}');
      if (u.membershipId != null) {
        // snapshot = await _firestore
        //     .collection('notifications')
        //     .where('filters', arrayContains: u.membershipId)
        //     .orderBy('timestamp', descending: true)
        //     .getDocuments();

        snapshot = await _firestore
            .collection('notifications')
            .where('filters', arrayContains: u.membershipId)
            .orderBy('timestamp', descending: true)
            .get();
        // snapshot.documents.forEach((document) {
        //   NotificationModel m =
        //       NotificationModel.fromDocumentSnapshot(document);
        //   print(m.notificationId);

        snapshot.docs.forEach((document) {
          NotificationModel m =
              NotificationModel.fromDocumentSnapshot(document);
          print(m.notificationId);

          if (m.timestamp != null && u.lastNotificationRead != null) {
            if (DateTime.fromMillisecondsSinceEpoch(
                    m.timestamp.millisecondsSinceEpoch)
                .isAfter(DateTime.fromMillisecondsSinceEpoch(
                    u.lastNotificationRead.millisecondsSinceEpoch))) {
              print(
                  'first ${DateTime.fromMillisecondsSinceEpoch(m.timestamp.millisecondsSinceEpoch)}');
              print(
                  'second ${DateTime.fromMillisecondsSinceEpoch(u.lastNotificationRead.millisecondsSinceEpoch)}');
              isNewNotification++;
            }
          }

          // lastSnapshot2 = document;
        });
      }
      print('dsd');

// NotificationModel m= NotificationModel.fromDocumentSnapshot( snapshot.documents[0]);
// print(m.notificationId);
//       print('cc ${u.lastNotificationRead.compareTo(m.timestamp)}');
//
//       return u.lastNotificationRead.compareTo(m.timestamp);

      return isNewNotification;
    } catch (e) {
      print(e);
      return 0;
      throw e;
    }
  }

  Future getNextNotifications() async {
    try {
      UserModel user = locator<UserModel>();
      List<NotificationModel> notifications = [];
      QuerySnapshot snapshot;
      if (user.membershipId != null) {
        // snapshot = await _firestore
        //     .collection('notifications')
        //     .where('membershipIds', arrayContains: user.membershipId)
        //     .orderBy('timestamp', descending: true)
        //     .limit(10)
        //     .startAfterDocument(lastSnapshot)
        //     .getDocuments();

        // snapshot.documents.forEach((document) {
        //   notifications.add(NotificationModel.fromDocumentSnapshot(document));
        //   lastSnapshot = document;
        // });

        snapshot = await _firestore
            .collection('notifications')
            .where('membershipIds', arrayContains: user.membershipId)
            .orderBy('timestamp', descending: true)
            .limit(10)
            .startAfterDocument(lastSnapshot)
            .get();

        snapshot.docs.forEach((document) {
          notifications.add(NotificationModel.fromDocumentSnapshot(document));
          lastSnapshot = document;
        });
      }
      return notifications;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
