import 'package:cloud_firestore/cloud_firestore.dart';

class CommonDoubtsModel {
  String doubtId;
  String doubtName;
  String doubtText;
  String thumbnailURL;
  Timestamp timestamp;
  String imageAttachmentURL;
  String videoAttachmentURL;

  CommonDoubtsModel(
      {this.doubtName,
      this.doubtText,
      this.thumbnailURL,
      this.imageAttachmentURL,
      this.videoAttachmentURL});

  CommonDoubtsModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.doubtId = snapshot.get('doubtId'),
        this.doubtName = snapshot.get('doubtName'),
        this.doubtText = snapshot.get('doubtText'),
        this.timestamp = snapshot.get('timestamp'),
        this.thumbnailURL = snapshot.get('thumbnailURL'),
        this.imageAttachmentURL = snapshot.get('imageAttachmentURL'),
        this.videoAttachmentURL = snapshot.get('videoAttachmentURL');

  // this.doubtId = snapshot.data['doubtId'],
  // this.doubtName = snapshot.data['doubtName'],
  // this.doubtText = snapshot.data['doubtText'],
  // this.timestamp = snapshot.data['timestamp'],
  // this.thumbnailURL = snapshot.data['thumbnailURL'],
  // this.imageAttachmentURL = snapshot.data['imageAttachmentURL'],
  // this.videoAttachmentURL = snapshot.data['videoAttachmentURL'];
}
