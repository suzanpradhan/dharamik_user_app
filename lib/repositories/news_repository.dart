import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/models/news_model.dart';

class NewsRepo {
  // final Firestore _firestore;
  final FirebaseFirestore _firestore;
  DocumentSnapshot lastSnapshot;

  // NewsRepo() : _firestore = Firestore.instance;

  NewsRepo() : _firestore = FirebaseFirestore.instance;

  Future<List<NewsModel>> getNewsItems() async {
    try {
      List<NewsModel> newsItems = List();

      // var snapshot = await _firestore
      //     .collection('news')
      //     .orderBy('timestamp', descending: true)
      //     .limit(10)
      //     .getDocuments();

      // snapshot.documents.forEach((document) {
      //   newsItems.add(NewsModel.fromDocumentSnapshot(document));
      //   lastSnapshot = document;
      // });

      var snapshot = await _firestore
          .collection('news')
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      snapshot.docs.forEach((document) {
        newsItems.add(NewsModel.fromDocumentSnapshot(document));
        lastSnapshot = document;
      });

      return newsItems;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<NewsModel>> getFeaturedNewsItems() async {
    try {
      List<NewsModel> newsItems = List();

      // var snapshot = await _firestore
      //     .collection('news')
      //     .orderBy('timestamp', descending: true)
      //     .where('isFeatured', isEqualTo: true)
      //     .getDocuments();

      // snapshot.documents.forEach((document) {
      //   newsItems.add(NewsModel.fromDocumentSnapshot(document));
      //   lastSnapshot = document;
      // });

      var snapshot = await _firestore
          .collection('news')
          .orderBy('timestamp', descending: true)
          .where('isFeatured', isEqualTo: true)
          .get();

      snapshot.docs.forEach((document) {
        newsItems.add(NewsModel.fromDocumentSnapshot(document));
        lastSnapshot = document;
      });

      return newsItems;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<NewsModel>> getNextNewsItems() async {
    try {
      List<NewsModel> newsItems = List();

      // var snapshot = await _firestore
      //     .collection('news')
      //     .orderBy('timestamp', descending: true)
      //     .limit(10)
      //     .startAfterDocument(lastSnapshot)
      //     .getDocuments();

      // snapshot.documents.forEach((document) {
      //   newsItems.add(NewsModel.fromDocumentSnapshot(document));
      //   lastSnapshot = document;
      // });

      var snapshot = await _firestore
          .collection('news')
          .orderBy('timestamp', descending: true)
          .limit(10)
          .startAfterDocument(lastSnapshot)
          .get();

      snapshot.docs.forEach((document) {
        newsItems.add(NewsModel.fromDocumentSnapshot(document));
        lastSnapshot = document;
      });

      return newsItems;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
