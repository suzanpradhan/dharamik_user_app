import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String userId;
  String userName;
  String userEmail;
  String userPhoneNumber;
  String userPhotoURL;
  String membershipId;
  bool emailVerified;
  int lastSignalViewed;
  Timestamp lastNotificationRead;
  String uniqueCode;

  UserModel(this.userId,
      {this.userName,
      this.userEmail,
      this.userPhoneNumber,
      this.userPhotoURL,
      this.emailVerified});

  UserModel.fromFirebaseUser(User user)
      : this.userName = user.displayName,
        this.userId = user.uid,
        this.emailVerified = user.emailVerified,
        this.userEmail = user.email,
        this.userPhoneNumber = user.phoneNumber,
        this.userPhotoURL = user.photoURL;

  UserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : this.userId = documentSnapshot.data()['userId'],
        this.userName = documentSnapshot.data()['userName'],
        this.userEmail = documentSnapshot.data()['userEmail'],
        this.userPhoneNumber = documentSnapshot.data()['userPhoneNumber'],
        this.userPhotoURL = documentSnapshot.data()['userPhotoURL'],
        this.lastSignalViewed = documentSnapshot.data()['lastSignalViewed'],
        this.membershipId = documentSnapshot.data()['membershipId'],
        this.lastNotificationRead =
            documentSnapshot.data()['lastNotificationRead'],
        this.uniqueCode = documentSnapshot.data()['uniqueCode'];
  // this.userId = documentSnapshot.data['userId'],
  // this.userName = documentSnapshot.data['userName'],
  // this.userEmail = documentSnapshot.data['userEmail'],
  // this.userPhoneNumber = documentSnapshot.data['userPhoneNumber'],
  // this.userPhotoURL = documentSnapshot.data['userPhotoURL'],
  // this.lastSignalViewed = documentSnapshot.data['lastSignalViewed'],
  // this.membershipId = documentSnapshot.data['membershipId'],
  //       this.lastNotificationRead= documentSnapshot.data['lastNotificationRead'],
  //       this.uniqueCode= documentSnapshot.data['uniqueCode'];

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhoneNumber': userPhoneNumber,
      'userPhotoURL': userPhotoURL,
      'lastSignalViewed': lastSignalViewed,
      'lastNotificationRead': FieldValue.serverTimestamp(),
      'uniqueCode': uniqueCode
    };
  }
}
