// import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:webapp/models/saved_video_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/utils/service_locator.dart';

class UserRepository {
  // final Firestore _firestore;
  final FirebaseFirestore _firestore;
  // final firebase.StorageReference _storageRef;

  final Reference _storageRef;
  DocumentReference _userDocRef;
  String _uid;
  // firebase.StorageReference _userStorageRef;

  // firebase.StorageReference _userStorageRef;

  Reference _userStorageRef;

  // UserRepository() : _firestore = Firestore.instance;

  // UserRepository() : _firestore = FirebaseFirestore.instance;
  // UserRepository()
  //     : _firestore = Firestore.instance,
  //       _storageRef = firebase.storage().ref('/');

  UserRepository()
      : _firestore = FirebaseFirestore.instance,
        _storageRef = FirebaseStorage.instance.ref('/');

  setUserId(String id) {
    _uid = id;
    // _userStorageRef = _storageRef.child('userImages').child(_uid);
    // _userDocRef = _firestore.collection('users').document(_uid);

    _userDocRef = _firestore.collection('users').doc(_uid);
    _userStorageRef = _storageRef.child('userImages').child(_uid);
  }

  Future<bool> isNewUser() async {
    try {
      // FirebaseUser u = await FirebaseAuth.instance.currentUser();
      // var snapshot = await _firestore.collection('users').document(u.uid).get();

      User u = FirebaseAuth.instance.currentUser;
      var snapshot = await _firestore.collection('users').doc(u.uid).get();
      return !snapshot.exists;
    } catch (e) {
      print(
          'error while checking new user code - ${e.code} message - ${e.message}');
      throw e;
    }
  }

  Future<UserModel> getUserFromDatabase() async {
    try {
      // FirebaseUser u = await FirebaseAuth.instance.currentUser();
      // return UserModel.fromDocumentSnapshot(
      //     await _firestore.collection('users').document(u.uid).get());

      User u = FirebaseAuth.instance.currentUser;
      return UserModel.fromDocumentSnapshot(
          await _firestore.collection('users').doc(u.uid).get());
    } catch (e) {
      print(
          'error while getting user details code - ${e.code} message - ${e.message}');
      throw e;
    }
  }

  Future<UserModel> getCurrentUserFromDatabase() async {
    try {
      // FirebaseUser u = await FirebaseAuth.instance.currentUser();
      // print('uid {$u.uid}');
      // var doc =
      //     await Firestore.instance.collection('users').document(u.uid).get();
      // return UserModel.fromDocumentSnapshot(doc);

      User u = await FirebaseAuth.instance.currentUser;
      print('uid {$u.uid}');
      var doc =
          await FirebaseFirestore.instance.collection('users').doc(u.uid).get();
      return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print(
          'error while getting user details code - ${e.code} message - ${e.message}');
      throw e;
    }
  }

  Future UpdateReadTime() async {
    try {
      UserModel user = locator<UserModel>();
      print('uid ${user.userId}');
      // var doc = await Firestore.instance
      //     .collection('users')
      //     .document(user.userId)
      //     .updateData({'lastNotificationRead': FieldValue.serverTimestamp()});

      var doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.userId)
          .update({'lastNotificationRead': FieldValue.serverTimestamp()});
      return '';
    } catch (e) {
      print(
          'error while getting user details code - ${e.code} message - ${e.message}');
      throw e;
    }
  }

  // Future<String> uploadUserImage(File userImage) async {
  //   try {
  //     User u = FirebaseAuth.instance.currentUser;
  //     var uploadTask = _storageRef
  //         .child('userImages')
  //         .child(u.uid)
  //         .child('${u.uid}.${userImage.path.split(".").last}')
  //         .put(userImage);
  //     var snapshot = await uploadTask.future;
  //     var imageUrl = (await snapshot.ref.getDownloadURL()).toString();
  //     print(imageUrl);
  //     return imageUrl;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<String> uploadUserImage(File userImage) async {
    try {
      User u = FirebaseAuth.instance.currentUser;
      var uploadTask = _storageRef
          .child('userImages')
          .child(u.uid)
          .child('${u.uid}.${userImage.path.split(".").last}')
          .putFile(userImage);
      var snapshot = uploadTask.snapshot;
      var imageUrl = (await snapshot.ref.getDownloadURL()).toString();
      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUserDataOnDatabase(UserModel user) async {
    try {
      // FirebaseUser u = await FirebaseAuth.instance.currentUser();
      // await _firestore
      //     .collection('users')
      //     .document(u.uid)
      //     .setData(user.toDocument(), merge: true);

      User u = FirebaseAuth.instance.currentUser;
      await _firestore
          .collection('users')
          .doc(u.uid)
          .set(user.toDocument(), SetOptions(merge: true));
    } catch (e) {
      throw e;
    }
  }

  Future<List<SavedVideoModel>> getSavedVideos() async {
    try {
      List<SavedVideoModel> savedVideos = List();
      // var snapshot =
      //     await _userDocRef.collection('saved_videos').getDocuments();
      // snapshot.documents.forEach((document) {
      //   savedVideos.add(SavedVideoModel.fromDocumentSnapshot(document));
      // });

      var snapshot = await _userDocRef.collection('saved_videos').get();
      snapshot.docs.forEach((document) {
        savedVideos.add(SavedVideoModel.fromDocumentSnapshot(document));
      });

      return savedVideos;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future saveVideo(SavedVideoModel savedVideoModel) async {
    try {
      // await _userDocRef
      //     .collection('saved_videos')
      //     .document(savedVideoModel.videoId)
      //     .setData(savedVideoModel.toDocument());

      await _userDocRef
          .collection('saved_videos')
          .doc(savedVideoModel.videoId)
          .set(savedVideoModel.toDocument());
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future unSaveVideo(String videoId) async {
    try {
      // await _userDocRef.collection('saved_videos').document(videoId).delete();
      await _userDocRef.collection('saved_videos').doc(videoId).delete();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
