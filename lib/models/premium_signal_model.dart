import 'package:cloud_firestore/cloud_firestore.dart';

class PremiumSignalModel {
  String signalId;
  String signalText;
  List<dynamic> membershipIds;
  Timestamp signalTimestamp;

  String imageUrl;

  bool isNewSignal = false;

  PremiumSignalModel({this.membershipIds, this.signalText});

  PremiumSignalModel.fromDocumentSnapshot(DocumentSnapshot document)
      : signalId = document.data()['signalId'],
        signalText = document.data()['signalText'],
        membershipIds = document.data()['membershipIds'],
        signalTimestamp = document.data()['signalTimestamp'],
        imageUrl = document.data()['imageAttachmentURL'];
  // signalId = document.data['signalId'],
  // signalText = document.data['signalText'],
  // membershipIds = document.data['membershipIds'],
  // signalTimestamp = document.data['signalTimestamp'],
  // imageUrl = document.data['imageAttachmentURL'];

  Map<String, Object> toDocument() {
    return {
      'signalId': this.signalId,
      'signalText': this.signalText,
      'membershipIds': this.membershipIds,
      'imageAttachmentURL': this.imageUrl,
      'signalTimestamp': FieldValue.serverTimestamp(),
    };
  }
}
