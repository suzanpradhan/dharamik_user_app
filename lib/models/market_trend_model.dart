import 'package:cloud_firestore/cloud_firestore.dart';

class MarketTrendModel {
  String marketTrendText;
  String marketTrendPhotoURL;
  Timestamp lastUpdated;

  MarketTrendModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : this.marketTrendText = documentSnapshot.data()['marketTrendText'],
        this.marketTrendPhotoURL =
            documentSnapshot.data()['marketTrendPhotoURL'],
        this.lastUpdated = documentSnapshot.data()['lastUpdated'];
  // : this.marketTrendText = documentSnapshot.data['marketTrendText'],
  //   this.marketTrendPhotoURL = documentSnapshot.data['marketTrendPhotoURL'],
  //   this.lastUpdated = documentSnapshot.data['lastUpdated'];

  MarketTrendModel({this.marketTrendText, this.marketTrendPhotoURL});
}
