import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String videoId;
  String videoTitle;
  String videoDesc;
  String videoURL;
  String videoDuration;
  String videoThumbnailURL;
  int videoRating;
  Timestamp timestamp;
  List<dynamic> membershipIds;
  List<dynamic> membershipNames;

  VideoModel(
      {this.videoId,
      this.videoTitle,
      this.videoRating,
      this.videoDesc,
      this.videoDuration,
      this.membershipIds,
      this.membershipNames});

  VideoModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.videoId = snapshot.data()['videoId'],
        this.videoTitle = snapshot.data()['videoTitle'],
        this.videoDesc = snapshot.data()['videoDesc'],
        this.videoURL = snapshot.data()['videoURL'],
        this.videoDuration = snapshot.data()['videoDuration'],
        this.videoRating = snapshot.data()['videoRating'],
        this.timestamp = snapshot.data()['timestamp'],
        this.membershipIds = snapshot.data()['membershipIds'],
        this.membershipNames = snapshot.data()['membershipNames'],
        this.videoThumbnailURL = snapshot.data()['videoThumbnailURL'];
  // this.videoId = snapshot.data['videoId'],
  // this.videoTitle = snapshot.data['videoTitle'],
  // this.videoDesc = snapshot.data['videoDesc'],
  // this.videoURL = snapshot.data['videoURL'],
  // this.videoDuration = snapshot.data['videoDuration'],
  // this.videoRating = snapshot.data['videoRating'],
  // this.timestamp = snapshot.data['timestamp'],
  // this.membershipIds = snapshot.data['membershipIds'],
  // this.membershipNames = snapshot.data['membershipNames'],
  // this.videoThumbnailURL = snapshot.data['videoThumbnailURL'];
}
