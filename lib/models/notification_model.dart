import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String notificationId;
  String notificationTitle;
  String notificationText;
  Timestamp timestamp;
  List<String> membershipIds;

  NotificationModel(
      {this.notificationTitle, this.notificationText, this.membershipIds});

  NotificationModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.notificationId = snapshot.data()['notificationId'],
        this.notificationTitle = snapshot.data()['notificationTitle'],
        this.notificationText = snapshot.data()['notificationText'],
        this.timestamp = snapshot.data()['timestamp'],
        this.membershipIds = snapshot
                .data()['filters']
                ?.map<String>((el) => el.toString())
                ?.toList() ??
            [];
  // this.notificationId = snapshot.data['notificationId'],
  // this.notificationTitle = snapshot.data['notificationTitle'],
  // this.notificationText = snapshot.data['notificationText'],
  // this.timestamp = snapshot.data['timestamp'],
  // this.membershipIds = snapshot.data['filters']?.map<String>((el)=>el.toString())?.toList()??[];
}
