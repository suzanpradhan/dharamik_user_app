import 'package:cloud_firestore/cloud_firestore.dart';

class SavedVideoModel {
  String videoId;
  String videoTitle;
  String videoThumbnailURL;
  Timestamp timestamp;

  SavedVideoModel({this.videoId, this.videoTitle, this.videoThumbnailURL});

  SavedVideoModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.videoId = snapshot.data()['videoId'],
        this.videoTitle = snapshot.data()['videoTitle'],
        this.timestamp = snapshot.data()['timestamp'],
        this.videoThumbnailURL = snapshot.data()['videoThumbnailURL'];
  // : this.videoId = snapshot.data['videoId'],
  //   this.videoTitle = snapshot.data['videoTitle'],
  //   this.timestamp = snapshot.data['timestamp'],
  //   this.videoThumbnailURL = snapshot.data['videoThumbnailURL'];

  Map<String, Object> toDocument() {
    return {
      'videoId': this.videoId,
      'videoTitle': this.videoTitle,
      'timestamp': FieldValue.serverTimestamp(),
      'videoThumbnailURL': this.videoThumbnailURL
    };
  }
}
