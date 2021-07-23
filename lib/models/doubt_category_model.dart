import 'package:cloud_firestore/cloud_firestore.dart';

class DoubtCategory {
  String doubtCategoryId;
  String doubtCategoryName;

  DoubtCategory({this.doubtCategoryName});

  DoubtCategory.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : this.doubtCategoryId = documentSnapshot.data()['doubtCategoryId'],
        this.doubtCategoryName = documentSnapshot.data()['doubtCategoryName'];
  // : this.doubtCategoryId = documentSnapshot.data['doubtCategoryId'],
  //   this.doubtCategoryName = documentSnapshot.data['doubtCategoryName'];

  Map<String, Object> toDocument() {
    return {
      'doubtCategoryId': this.doubtCategoryId,
      'doubtCategoryName': this.doubtCategoryName
    };
  }
}
