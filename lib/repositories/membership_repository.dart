import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/models/membership_model.dart';

class MembershipsRepo {
  // final Firestore _firestore;
  final FirebaseFirestore _firestore;

  // MembershipsRepo() : _firestore = Firestore.instance;

  MembershipsRepo() : _firestore = FirebaseFirestore.instance;

  Future<List<MembershipModel>> getMemberships() async {
    try {
      List<MembershipModel> memberships = List();

      // var snapshot = await _firestore
      //     .collection('memberships')
      //     .orderBy('level')
      //     .getDocuments();

      var snapshot =
          await _firestore.collection('memberships').orderBy('level').get();

      // snapshot.documents.forEach((element) {
      //   var v = MembershipModel.fromDocumentSnapshot(element);
      //   v.membershipId = element.documentID;
      //   memberships.add(v);
      // });

      snapshot.docs.forEach((element) {
        var v = MembershipModel.fromDocumentSnapshot(element);
        v.membershipId = element.id;
        memberships.add(v);
      });

      return memberships;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
