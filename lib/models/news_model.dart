import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  String newsId;
  String newsTitle;
  String newsDesc;
  String newsContent;
  String newsThumbnail;
  bool isFeatured;
  Timestamp timestamp;

  NewsModel(
      {this.newsTitle,
      this.newsDesc,
      this.newsContent,
      this.newsThumbnail,
      this.isFeatured});

  NewsModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : this.newsId = snapshot.data()['newsId'],
        this.newsTitle = snapshot.data()['newsTitle'],
        this.newsDesc = snapshot.data()['newsDesc'],
        this.newsContent = snapshot.data()['newsContent'],
        this.newsThumbnail = snapshot.data()['newsThumbnail'],
        this.isFeatured = snapshot.data()['isFeatured'],
        this.timestamp = snapshot.data()['timestamp'];
  // this.newsId = snapshot.data['newsId'],
  // this.newsTitle = snapshot.data['newsTitle'],
  // this.newsDesc = snapshot.data['newsDesc'],
  // this.newsContent = snapshot.data['newsContent'],
  // this.newsThumbnail = snapshot.data['newsThumbnail'],
  // this.isFeatured = snapshot.data['isFeatured'],
  // this.timestamp = snapshot.data['timestamp'];

}
