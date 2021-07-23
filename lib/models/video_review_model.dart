import 'package:cloud_firestore/cloud_firestore.dart';

class VideoReviewModel {
  String reviewId;
  String reviewText;

  String videoId;
  String videoTitle;
  String videoThumbnailURL;

  String userId;
  String userName;

  int rating;

  bool active;

  Timestamp timestamp;

  VideoReviewModel(
      {this.reviewText,
      this.videoId,
      this.videoTitle,
      this.videoThumbnailURL,
      this.rating,
      this.userId,
      this.userName});

  VideoReviewModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.active = snapshot.data()['active'],
        this.reviewId = snapshot.data()['reviewId'],
        this.reviewText = snapshot.data()['reviewText'],
        this.videoId = snapshot.data()['videoId'],
        this.videoTitle = snapshot.data()['videoTitle'],
        this.videoThumbnailURL = snapshot.data()['videoThumbnailURL'],
        this.userId = snapshot.data()['userId'],
        this.rating = snapshot.data()['rating'],
        this.userName = snapshot.data()['userName'],
        this.timestamp = snapshot.data()['timestamp'];
  // : this.active = snapshot.data['active'],
  //   this.reviewId = snapshot.data['reviewId'],
  //   this.reviewText = snapshot.data['reviewText'],
  //   this.videoId = snapshot.data['videoId'],
  //   this.videoTitle = snapshot.data['videoTitle'],
  //   this.videoThumbnailURL = snapshot.data['videoThumbnailURL'],
  //   this.userId = snapshot.data['userId'],
  //   this.rating = snapshot.data['rating'],
  //   this.userName = snapshot.data['userName'],
  //   this.timestamp = snapshot.data['timestamp'];

  Map<String, Object> toDocument() {
    return {
      'active': false,
      'reviewId': this.reviewId,
      'reviewText': this.reviewText,
      'videoId': this.videoId,
      'videoTitle': this.videoTitle,
      'rating': this.rating,
      'videoThumbnailURL': this.videoThumbnailURL,
      'userId': this.userId,
      'userName': this.userName,
      'timestamp': FieldValue.serverTimestamp()
    };
  }
}
