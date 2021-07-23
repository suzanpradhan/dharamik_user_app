import 'package:cloud_firestore/cloud_firestore.dart';

class MembershipModel {
  String membershipId;
  String membershipName;
  int level;
  int price;
  int duration;

  MembershipModel({this.membershipName, this.level});

  MembershipModel.fromDocumentSnapshot(DocumentSnapshot document)
      : membershipId = document.data()['membershipId'],
        membershipName = document.data()['membershipName'],
        level = document.data()['level'],
        price = document.data()['price'],
        duration = document.data()["duration"];
  // membershipId = document.data['membershipId'],
  // membershipName = document.data['membershipName'],
  // level = document.data['level'],
  // price = document.data['price'],
  // duration = document.data["duration"];

}
