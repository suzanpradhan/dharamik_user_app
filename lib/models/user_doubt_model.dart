// import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDoubtModel {
  String doubtId;
  String doubtTitle;
  String doubtDescription;
  String doubtCategoryName;
  Timestamp timestamp;
  String imageAttachmentURL;
  String videoAttachmentURL;

  String userId;
  String userName;
  String userEmail;

  File imageFile;

  UserDoubtModel reply;

  UserDoubtModel(
      {this.doubtTitle,
      this.doubtDescription,
      this.imageAttachmentURL,
      this.doubtCategoryName,
      this.userId,
      this.userName,
      this.userEmail});

  toDocument() {
    return {
      'doubtId': doubtId,
      'doubtTitle': doubtTitle,
      'doubtDescription': doubtDescription,
      'doubtCategoryName': doubtCategoryName,
      'timestamp': FieldValue.serverTimestamp(),
      'imageAttachmentURL': imageAttachmentURL,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'videoAttachmentUrl': videoAttachmentURL,
    };
  }

  UserDoubtModel.fromDocumentSnapshot(DocumentSnapshot snapshot,
      {reply = false}) {
    if (reply) {
      this.doubtId = snapshot.data()['reply']['doubtId'];
      this.doubtTitle = snapshot.data()['reply']['doubtTitle'];
      this.doubtDescription = snapshot.data()['reply']['doubtDescription'];
      this.timestamp = snapshot.data()['reply']['timestamp'];
      this.imageAttachmentURL = snapshot.data()['reply']['imageAttachmentURL'];
      this.videoAttachmentURL = snapshot.data()['reply']['videottachmentURL'];
      this.userId = snapshot.data()['reply']['userId'];
      this.userName = snapshot.data()['reply']['userName'];
      this.userEmail = snapshot.data()['reply']['userEmail'];
      // this.doubtId = snapshot.data['reply']['doubtId'];
      // this.doubtTitle = snapshot.data['reply']['doubtTitle'];
      // this.doubtDescription = snapshot.data['reply']['doubtDescription'];
      // this.timestamp = snapshot.data['reply']['timestamp'];
      // this.imageAttachmentURL = snapshot.data['reply']['imageAttachmentURL'];
      // this.videoAttachmentURL = snapshot.data['reply']['videottachmentURL'];
      // this.userId = snapshot.data['reply']['userId'];
      // this.userName = snapshot.data['reply']['userName'];
      // this.userEmail = snapshot.data['reply']['userEmail'];
      this.reply = null;
    } else {
      this.doubtId = snapshot.data()['doubtId'];
      this.doubtTitle = snapshot.data()['doubtTitle'];
      this.doubtDescription = snapshot.data()['doubtDescription'];
      this.timestamp = snapshot.data()['timestamp'];
      this.imageAttachmentURL = snapshot.data()['imageAttachmentURL'];
      this.videoAttachmentURL = snapshot.data()['videottachmentURL'];
      this.userId = snapshot.data()['userId'];
      this.userName = snapshot.data()['userName'];
      this.userEmail = snapshot.data()['userEmail'];
      this.reply = snapshot.data()['reply'] != null
          ? UserDoubtModel.fromDocumentSnapshot(snapshot, reply: true)
          : null;
      // this.doubtId = snapshot.data['doubtId'];
      // this.doubtTitle = snapshot.data['doubtTitle'];
      // this.doubtDescription = snapshot.data['doubtDescription'];
      // this.timestamp = snapshot.data['timestamp'];
      // this.imageAttachmentURL = snapshot.data['imageAttachmentURL'];
      // this.videoAttachmentURL = snapshot.data['videottachmentURL'];
      // this.userId = snapshot.data['userId'];
      // this.userName = snapshot.data['userName'];
      // this.userEmail = snapshot.data['userEmail'];
      // this.reply = snapshot.data['reply'] != null
      //     ? UserDoubtModel.fromDocumentSnapshot(snapshot, reply: true)
      //     : null;
    }
  }
  //  this.videoAttachmentURL = snapshot.data['videoAttachmentURL'];

}
