import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/models/common_doubts_model.dart';
import 'package:webapp/models/user_doubt_model.dart';

class CommonDoubtsRepo {
  final FirebaseFirestore _firestore;
  // final Firestore _firestore;

  DocumentSnapshot lastSnapshot;

  // CommonDoubtsRepo() : _firestore = Firestore.instance;
  CommonDoubtsRepo() : _firestore = FirebaseFirestore.instance;

  Future<List<UserDoubtModel>> getCommonDoubts() async {
    try {
      List<UserDoubtModel> commonDoubts = List();

      // var snapshot = await _firestore
      //     .collection('common_doubts')
      //     .orderBy('timestamp', descending: true)
      //     .limit(10)
      //     .getDocuments();

      var snapshot = await _firestore
          .collection('common_doubts')
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      // snapshot.documents.forEach((document) {
      //   var doubt = UserDoubtModel.fromDocumentSnapshot(document);
      //   if(doubt.reply!=null) {
      //     commonDoubts.add(doubt);
      //     lastSnapshot = document;
      //   }
      // });

      snapshot.docs.forEach((document) {
        var doubt = UserDoubtModel.fromDocumentSnapshot(document);
        if (doubt.reply != null) {
          commonDoubts.add(doubt);
          lastSnapshot = document;
        }
      });

      return commonDoubts;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<UserDoubtModel>> getNextCommonDoubts() async {
    try {
      List<UserDoubtModel> commonDoubts = List();

      // var snapshot = await _firestore
      //     .collection('common_doubts')
      //     .orderBy('timestamp', descending: true)
      //     .limit(10)
      //     .startAfterDocument(lastSnapshot)
      //     .getDocuments();

      var snapshot = await _firestore
          .collection('common_doubts')
          .orderBy('timestamp', descending: true)
          .limit(10)
          .startAfterDocument(lastSnapshot)
          .get();

      // snapshot.documents.forEach((document) {
      //   var doubt = UserDoubtModel.fromDocumentSnapshot(document);
      //   if (doubt.reply != null) {
      //     commonDoubts.add(doubt);
      //     lastSnapshot = document;
      //   }
      // });

      snapshot.docs.forEach((document) {
        var doubt = UserDoubtModel.fromDocumentSnapshot(document);
        if (doubt.reply != null) {
          commonDoubts.add(doubt);
          lastSnapshot = document;
        }
      });

      return commonDoubts;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
