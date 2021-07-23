import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/models/market_trend_model.dart';
import 'package:webapp/models/segment_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/utils/service_locator.dart';

class DashboardRepo {
  // final Firestore _firestore;

  final FirebaseFirestore _firestore;

  // DashboardRepo():
  // _firestore = Firestore.instance;

  DashboardRepo() : _firestore = FirebaseFirestore.instance;

  Future<MarketTrendModel> getMarketTrendDetails() async {
    try {
      // var snapshot =
      //     await _firestore.collection('homeData').document('marketTrend').get();

      var snapshot =
          await _firestore.collection('homeData').doc('marketTrend').get();

      if (!snapshot.exists) return null;

      return MarketTrendModel.fromDocumentSnapshot(snapshot);
    } catch (e) {
      throw e;
    }
  }

  Future<List<SegmentModel>> getSegments() async {
    try {
      UserModel user = locator<UserModel>();
      List<SegmentModel> segments = [];

      print('usermembership id ${user.membershipId}');

      // var querySnapshot = await _firestore
      //     .collection('segments')
      //     .where('memberships', arrayContains: user.membershipId)
      //     .getDocuments();

      var querySnapshot = await _firestore
          .collection('segments')
          .where('memberships', arrayContains: user.membershipId)
          .get();

      if (querySnapshot != null) {
        print('fetching segments');

        // querySnapshot.documents.forEach((element) {
        //   segments.add(SegmentModel.fromDocumentSnapshot(element));
        // });

        querySnapshot.docs.forEach((element) {
          segments.add(SegmentModel.fromDocumentSnapshot(element));
        });

        print(segments);
      }
      return segments;
    } catch (e) {
      throw e;
    }
  }

  Future<SegmentModel> getSegment(String segmentId) async {
    try {
      // var snapshot =
      //     await _firestore.collection('segments').document(segmentId).get();

      var snapshot =
          await _firestore.collection('segments').doc(segmentId).get();

      return SegmentModel.fromDocumentSnapshot(snapshot);
    } catch (e) {
      throw e;
    }
  }
}
