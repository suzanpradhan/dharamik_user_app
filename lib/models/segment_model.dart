import 'package:cloud_firestore/cloud_firestore.dart';

class SegmentModel {
  String segmentId;
  String segmentName;
  String segmentText;
  String segmentPhotoURL;
  Timestamp lastUpdated;

  SegmentModel(
      {this.segmentId,
      this.segmentName,
      this.segmentText,
      this.segmentPhotoURL});

  SegmentModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : segmentId = documentSnapshot.data()['segmentId'],
        segmentName = documentSnapshot.data()['segmentName'],
        segmentText = documentSnapshot.data()['segmentText'],
        segmentPhotoURL = documentSnapshot.data()['segmentPhotoURL'],
        lastUpdated = documentSnapshot.data()['lastUpdated'];
  // segmentId = documentSnapshot.data['segmentId'],
  // segmentName = documentSnapshot.data['segmentName'],
  // segmentText = documentSnapshot.data['segmentText'],
  // segmentPhotoURL = documentSnapshot.data['segmentPhotoURL'],
  // lastUpdated = documentSnapshot.data['lastUpdated'];

}
