import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/models/premium_signal_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/utils/service_locator.dart';

class PremiumSignalsRepo {
  // Firestore _firestore;
  FirebaseFirestore _firestore;
  DocumentSnapshot lastSnapshot;

  // PremiumSignalsRepo() {
  //   _firestore = Firestore.instance;
  // }

  PremiumSignalsRepo() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<List<PremiumSignalModel>> getPremiumSignalsByTime(int time) async {
    try {
      UserModel user = locator<UserModel>();
      List<PremiumSignalModel> premiumSignals = List();

      if (user.membershipId == null) return premiumSignals;
      // var snapshot = await _firestore
      //     .collection('premium_signals')
      //     .where('membershipIds', arrayContains: user.membershipId)
      //     .orderBy('signalTimestamp', descending: true)
      //     .limit(10)
      //     .getDocuments();

      var snapshot = await _firestore
          .collection('premium_signals')
          .where('membershipIds', arrayContains: user.membershipId)
          .orderBy('signalTimestamp', descending: true)
          .limit(10)
          .get();

      // snapshot.documents.forEach((element) {
      //   var signal = PremiumSignalModel.fromDocumentSnapshot(element);

      //   if (time == null)
      //     time =
      //         DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
      //   var lastViewed = DateTime.fromMillisecondsSinceEpoch(time);
      //   var signalTime = DateTime.fromMillisecondsSinceEpoch(
      //       signal.signalTimestamp.millisecondsSinceEpoch);

      //   if (lastViewed.isBefore(signalTime)) {
      //     premiumSignals.add(signal);
      //   } else {
      //     print('its after $lastViewed  and signal time $signalTime}');
      //   }

      //   //lastSnapshot = element;
      // });

      snapshot.docs.forEach((element) {
        var signal = PremiumSignalModel.fromDocumentSnapshot(element);

        if (time == null)
          time =
              DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
        var lastViewed = DateTime.fromMillisecondsSinceEpoch(time);
        var signalTime = DateTime.fromMillisecondsSinceEpoch(
            signal.signalTimestamp.millisecondsSinceEpoch);

        if (lastViewed.isBefore(signalTime)) {
          premiumSignals.add(signal);
        } else {
          print('its after $lastViewed  and signal time $signalTime}');
        }

        //lastSnapshot = element;
      });
      print(
          "fhgskdfghsj dghsdfjlghsdfhdsfnghsnfkdsdklfsdfgnskdfgskdfgsdjfklgksdfghskgsjlfhgf" +
              premiumSignals.length.toString());
      return premiumSignals;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<PremiumSignalModel>> getPremiumSignals() async {
    try {
      UserModel user = locator<UserModel>();
      List<PremiumSignalModel> premiumSignals = List();

      if (user.membershipId == null) return premiumSignals;
      // var snapshot = await _firestore
      //     .collection('premium_signals')
      //     .where('membershipIds', arrayContains: user.membershipId)
      //     .orderBy('signalTimestamp', descending: true)
      //     // .limit(10)
      //     .getDocuments();

      // snapshot.documents.forEach((element) {
      //   premiumSignals.add(PremiumSignalModel.fromDocumentSnapshot(element));
      //   lastSnapshot = element;
      // });

      var snapshot = await _firestore
          .collection('premium_signals')
          .where('membershipIds', arrayContains: user.membershipId)
          .orderBy('signalTimestamp', descending: true)
          // .limit(10)
          .get();

      snapshot.docs.forEach((element) {
        premiumSignals.add(PremiumSignalModel.fromDocumentSnapshot(element));
        lastSnapshot = element;
      });

      return premiumSignals;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<PremiumSignalModel>> getNextSignals() async {
    try {
      List<PremiumSignalModel> premiumSignals = List();

      // var snapshot = await _firestore
      //     .collection('premium_signals')
      //     .orderBy('signalTimestamp')
      //     .limit(10)
      //     .startAfterDocument(lastSnapshot)
      //     .getDocuments();

      // snapshot.documents.forEach((element) {
      //   premiumSignals.add(PremiumSignalModel.fromDocumentSnapshot(element));
      //   lastSnapshot = element;
      // });

      var snapshot = await _firestore
          .collection('premium_signals')
          .orderBy('signalTimestamp')
          .limit(10)
          .startAfterDocument(lastSnapshot)
          .get();

      snapshot.docs.forEach((element) {
        premiumSignals.add(PremiumSignalModel.fromDocumentSnapshot(element));
        lastSnapshot = element;
      });

      return premiumSignals;
    } catch (e) {
      throw e;
    }
  }
}
