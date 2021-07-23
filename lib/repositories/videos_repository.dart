import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/models/video_model.dart';
import 'package:webapp/models/video_review_model.dart';
import 'package:webapp/utils/service_locator.dart';

class VideosRepo {
  // final Firestore _firestore;

  final FirebaseFirestore _firestore;
  DocumentSnapshot lastSnapshot;
  DocumentSnapshot lastReviewSnapshot;
  final Algolia algolia;
  String membershipId;

  // VideosRepo()
  //     : _firestore = Firestore.instance,
  //       algolia = Algolia.init(
  //           applicationId: 'FE59CLSZJ0',
  //           apiKey: '2a43abe3f4cfe5267e86744f80601f3f');

  VideosRepo()
      : _firestore = FirebaseFirestore.instance,
        algolia = Algolia.init(
            applicationId: 'FE59CLSZJ0',
            apiKey: '2a43abe3f4cfe5267e86744f80601f3f');

  Future<List<VideoModel>> getVideos(String membershipId) async {
    try {
      List<VideoModel> videos = List();
      membershipId = membershipId;

      print('current membership Id $membershipId');

      // var snapshot = await _firestore
      //     .collection('videos')
      //     .where('membershipIds', arrayContains: membershipId)
      //     .orderBy('timestamp', descending: true)
      //     .limit(10)
      //     .getDocuments();

      // snapshot.documents.forEach((document) {
      //   print('Membership ID : ${document.data['membershipIds']}');
      //   videos.add(VideoModel.fromDocumentSnapshot(document));
      //   lastSnapshot = document;
      // });

      var snapshot = await _firestore
          .collection('videos')
          .where('membershipIds', arrayContains: membershipId)
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      snapshot.docs.forEach((document) {
        // print('Membership ID : ${document.data['membershipIds']}');
        videos.add(VideoModel.fromDocumentSnapshot(document));
        lastSnapshot = document;
      });

      return videos;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<VideoModel> getVideoDetails(String videoId) async {
    try {
      // return VideoModel.fromDocumentSnapshot(
      //     await _firestore.collection('videos').document(videoId).get());

      return VideoModel.fromDocumentSnapshot(
          await _firestore.collection('videos').doc(videoId).get());
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<VideoModel>> getNextVideos() async {
    try {
      List<VideoModel> videos = List();

      // var snapshot = await _firestore
      //     .collection('videos')
      //     .where('membershipIds', arrayContains: membershipId)
      //     .orderBy('timestamp', descending: true)
      //     .limit(10)
      //     .startAfterDocument(lastSnapshot)
      //     .getDocuments();

      // snapshot.documents.forEach((document) {
      //   videos.add(VideoModel.fromDocumentSnapshot(document));
      //   lastSnapshot = document;
      // });

      var snapshot = await _firestore
          .collection('videos')
          .where('membershipIds', arrayContains: membershipId)
          .orderBy('timestamp', descending: true)
          .limit(10)
          .startAfterDocument(lastSnapshot)
          .get();

      snapshot.docs.forEach((document) {
        videos.add(VideoModel.fromDocumentSnapshot(document));
        lastSnapshot = document;
      });

      return videos;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> isVideoSaved(String videoId) async {
    try {
      UserModel userModel = locator<UserModel>();
      // var document = await _firestore
      //     .collection('users')
      //     .document(userModel.userId)
      //     .collection('saved_videos')
      //     .document(videoId)
      //     .get();

      var document = await _firestore
          .collection('users')
          .doc(userModel.userId)
          .collection('saved_videos')
          .doc(videoId)
          .get();

      return document.exists;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> isVideoReviewed(String videoId) async {
    try {
      UserModel userModel = locator<UserModel>();
      // var snapshot = await _firestore
      //     .collection('videos')
      //     .document(videoId)
      //     .collection('video_reviews')
      //     .where('userId', isEqualTo: userModel.userId)
      //     .getDocuments();

      var snapshot = await _firestore
          .collection('videos')
          .doc(videoId)
          .collection('video_reviews')
          .where('userId', isEqualTo: userModel.userId)
          .get();

      // return snapshot.documents.isNotEmpty;

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future submitReview(VideoReviewModel videoReviewModel) async {
    try {
      // var docRef = _firestore
      //     .collection('videos')
      //     .document(videoReviewModel.videoId)
      //     .collection('video_reviews')
      //     .document();

      // videoReviewModel.reviewId = docRef.documentID;
      // await docRef.setData(videoReviewModel.toDocument());

      var docRef = _firestore
          .collection('videos')
          .doc(videoReviewModel.videoId)
          .collection('video_reviews')
          .doc();

      videoReviewModel.reviewId = docRef.id;
      await docRef.set(videoReviewModel.toDocument());
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<VideoReviewModel>> getVideoReviews(String videoId) async {
    try {
      List<VideoReviewModel> videoReviews = List();

      // var snapshot = await _firestore
      //     .collection('videos')
      //     .document(videoId)
      //     .collection('video_reviews')
      //     .where('active', isEqualTo: true)
      //     .orderBy('timestamp', descending: true)
      //     .limit(10)
      //     .getDocuments();

      // snapshot.documents.forEach((document) {
      //   videoReviews.add(VideoReviewModel.fromDocumentSnapshot(document));
      //   lastReviewSnapshot = document;
      // });

      var snapshot = await _firestore
          .collection('videos')
          .doc(videoId)
          .collection('video_reviews')
          .where('active', isEqualTo: true)
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      snapshot.docs.forEach((document) {
        videoReviews.add(VideoReviewModel.fromDocumentSnapshot(document));
        lastReviewSnapshot = document;
      });

      return videoReviews;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<VideoReviewModel>> getNextVideoReviews(String videoId) async {
    try {
      List<VideoReviewModel> videoReviews = List();

      // var snapshot = await _firestore
      //     .collection('videos')
      //     .document(videoId)
      //     .collection('video_reviews')
      //     .where('active', isEqualTo: true)
      //     .orderBy('timestamp', descending: true)
      //     .limit(10)
      //     .startAfterDocument(lastReviewSnapshot)
      //     .getDocuments();

      // snapshot.documents.forEach((document) {
      //   videoReviews.add(VideoReviewModel.fromDocumentSnapshot(document));
      //   lastReviewSnapshot = document;
      // });

      var snapshot = await _firestore
          .collection('videos')
          .doc(videoId)
          .collection('video_reviews')
          .where('active', isEqualTo: true)
          .orderBy('timestamp', descending: true)
          .limit(10)
          .startAfterDocument(lastReviewSnapshot)
          .get();

      snapshot.docs.forEach((document) {
        videoReviews.add(VideoReviewModel.fromDocumentSnapshot(document));
        lastReviewSnapshot = document;
      });

      return videoReviews;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<VideoModel>> searchVideo(String searchQuery) async {
    try {
      List<VideoModel> videos = List();
      AlgoliaQuery query = algolia.instance.index('videos').search(searchQuery);
      AlgoliaQuerySnapshot snapshot = await query.getObjects();
      snapshot.hits.forEach((element) {
        print(element.objectID);
        videos.add(VideoModel(
            videoTitle: element.data['videoTitle'], videoId: element.objectID));
      });
      return videos;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
