// import 'dart:html';

import 'dart:io';
// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase/firebase.dart';
import 'package:webapp/models/doubt_category_model.dart';
import 'package:webapp/models/user_doubt_model.dart';

class UserDoubtsRepo {
  // final Firestore _firestore;
  final FirebaseFirestore _firestore;
  // final StorageReference _storageReference;

  final Reference _storageReference;

  // UserDoubtsRepo() : _firestore = Firestore.instance;

  // UserDoubtsRepo() : _firestore = FirebaseFirestore.instance;
  // UserDoubtsRepo()
  //     : _firestore = Firestore.instance,
  //       _storageReference = storage().ref('/');

  UserDoubtsRepo()
      : _firestore = FirebaseFirestore.instance,
        _storageReference = FirebaseStorage.instance.ref('/');

  // Future<String> uploadImage(String fileName, File file) async {
  //   try {
  //     var uploadTask = _storageReference
  //         .child('userDoubtImages')
  //         .child('$fileName.${file.path.split('.').last}')
  //         .put(file);

  //     var snapshot = await uploadTask.future;
  //     return (await snapshot.ref.getDownloadURL()).toString();
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future<String> uploadImage(String fileName, File file) async {
    try {
      var uploadTask = _storageReference
          .child('userDoubtImages')
          .child('$fileName.${file.path.split('.').last}')
          .putFile(file);

      var snapshot = uploadTask.snapshot;
      return (await snapshot.ref.getDownloadURL()).toString();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future createDoubt(UserDoubtModel doubtModel) async {
    try {
      // var docRef = _firestore.collection('common_doubts').document();

      var docRef = _firestore.collection('common_doubts').doc();
      doubtModel.doubtId = docRef.id;

      if (doubtModel.imageFile != null) {
        doubtModel.imageAttachmentURL =
            await uploadImage('${doubtModel.doubtId}', doubtModel.imageFile);
      }
      await docRef.set(doubtModel.toDocument());
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<DoubtCategory>> getDoubtCategories() async {
    try {
      List<DoubtCategory> doubtCategories = List();
      // var snapshot =
      //     await _firestore.collection('doubtCategories').getDocuments();
      // snapshot.documents.forEach((document) {
      //   doubtCategories.add(DoubtCategory.fromDocumentSnapshot(document));
      // });

      var snapshot = await _firestore.collection('doubtCategories').get();
      snapshot.docs.forEach((document) {
        doubtCategories.add(DoubtCategory.fromDocumentSnapshot(document));
      });
      return doubtCategories;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
