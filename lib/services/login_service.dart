import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webapp/models/login_session_model.dart';

class LoginService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  // final Firestore _firestore;
  final FirebaseFirestore _firestore;
  SharedPreferences _prefs;

  // LoginService()
  //     : _firebaseAuth = FirebaseAuth.instance,
  //       _firestore = Firestore.instance,
  //       _googleSignIn = GoogleSignIn();

  LoginService()
      : _firebaseAuth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance,
        _googleSignIn = GoogleSignIn();

  // Future<FirebaseUser> getUser() async {
  //   var user = await _firebaseAuth.currentUser();
  //   if (user == null) {
  //     user = await _firebaseAuth.onAuthStateChanged.first;
  //   }
  //   return user;
  // }

  Future<User> getUser() async {
    var user = _firebaseAuth.currentUser;
    if (user == null) {
      user = await _firebaseAuth.authStateChanges().first;
    }
    return user;
  }

  // Future<FirebaseUser> signInWithEmailPassword(
  //     String email, String password) async {
  //   try {
  //     var authResult = await _firebaseAuth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     return authResult.user;
  //   } catch (error) {
  //     print(error.code);
  //     throw error;
  //   }
  // }

  Future<User> signInWithEmailPassword(String email, String password) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return authResult.user;
    } catch (error) {
      print(error.code);
      throw error;
    }
  }

  Future sendForgotPasswordLink(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }

  // Future sendVerificationEmail(String uid) async {
  //   try {
  //     var user = await _firebaseAuth.currentUser();
  //     await user.sendEmailVerification();
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future sendVerificationEmail(String uid) async {
    try {
      var user = _firebaseAuth.currentUser;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Future<FirebaseUser> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleSignInAccount.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.getCredential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     var authResult = await _firebaseAuth.signInWithCredential(credential);
  //     return authResult.user;
  //   } catch (error) {
  //     print(error.code);
  //     throw error;
  //   }
  // }

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var authResult = await _firebaseAuth.signInWithCredential(credential);
      return authResult.user;
    } catch (error) {
      print(error.code);
      throw error;
    }
  }

  // Future<FirebaseUser> signInWithFacebook() async {
  //   try {
  //     // addFacebookScript();
  //     // await fbAsyncInit();
  //     // init(
  //     //   FbInitOption(
  //     //     appId: '232643578161748',
  //     //     cookies: true,
  //     //     xfbml: true,
  //     //     version: 'v2.9',
  //     //   ),
  //     // );

  //     // var response = await getLoginStatus();
  //     // if (response.status != LoginStatus.connected) {
  //     //   print(response.status);
  //     //   response = await login(['email', 'public_profile']);
  //     // }
  //     // print(response.status);
  //     // if (response.status != LoginStatus.connected) {
  //     //   throw PlatformException(
  //     //       code: 'fb-login-error', message: 'Facebook Login Error');
  //     // }
  //     // var accessToken = response.authResponse.accessToken;
  //     // final AuthCredential fbAuthCredential =
  //     //     FacebookAuthProvider.getCredential(accessToken: accessToken);
  //     // final authResult =
  //     //     await _firebaseAuth.signInWithCredential(fbAuthCredential);
  //     // return authResult.user;
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future<User> signInWithFacebook() async {
    try {
      // addFacebookScript();
      // await fbAsyncInit();
      // init(
      //   FbInitOption(
      //     appId: '232643578161748',
      //     cookies: true,
      //     xfbml: true,
      //     version: 'v2.9',
      //   ),
      // );

      // var response = await getLoginStatus();
      // if (response.status != LoginStatus.connected) {
      //   print(response.status);
      //   response = await login(['email', 'public_profile']);
      // }
      // print(response.status);
      // if (response.status != LoginStatus.connected) {
      //   throw PlatformException(
      //       code: 'fb-login-error', message: 'Facebook Login Error');
      // }
      // var accessToken = response.authResponse.accessToken;
      // final AuthCredential fbAuthCredential =
      //     FacebookAuthProvider.getCredential(accessToken: accessToken);
      // final authResult =
      //     await _firebaseAuth.signInWithCredential(fbAuthCredential);
      // return authResult.user;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Future<FirebaseUser> createUserAccount(String email, String password) async {
  //   try {
  //     var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     return authResult.user;
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future<User> createUserAccount(String email, String password) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Future<LoginSessionModel> getLoginSession(String userId,
  //     {String sessionId}) async {
  //   try {
  //     if (sessionId == null) {
  //       var snapshot = await _firestore
  //           .collection('users')
  //           .document(userId)
  //           .collection('loginSessions')
  //           .getDocuments();

  //       if (snapshot.documents.isNotEmpty) {
  //         return LoginSessionModel.fromDocumentSnapshot(snapshot.documents[0]);
  //       } else
  //         return null;
  //     } else {
  //       var documentSnapshot = await _firestore
  //           .collection('users')
  //           .document(userId)
  //           .collection('loginSessions')
  //           .document(sessionId)
  //           .get();

  //       if (documentSnapshot.exists)
  //         return LoginSessionModel.fromDocumentSnapshot(documentSnapshot);
  //       else
  //         return null;
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future<LoginSessionModel> getLoginSession(String userId,
      {String sessionId}) async {
    try {
      if (sessionId == null) {
        var snapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('loginSessions')
            .get();

        if (snapshot.docs.isNotEmpty) {
          return LoginSessionModel.fromDocumentSnapshot(snapshot.docs[0]);
        } else
          return null;
      } else {
        var documentSnapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('loginSessions')
            .doc(sessionId)
            .get();

        if (documentSnapshot.exists)
          return LoginSessionModel.fromDocumentSnapshot(documentSnapshot);
        else
          return null;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Future createLoginSession(String userId) async {
  //   try {
  //     var loginSession = LoginSessionModel();
  //     var docRef = _firestore
  //         .collection('users')
  //         .document(userId)
  //         .collection('loginSessions')
  //         .document();

  //     loginSession.loginSessionId = docRef.documentID;

  //     await docRef.setData(loginSession.toDocument());
  //     await putLoginSessionToStorage(loginSession.loginSessionId);
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future createLoginSession(String userId) async {
    try {
      var loginSession = LoginSessionModel();
      var docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('loginSessions')
          .doc();

      loginSession.loginSessionId = docRef.id;

      await docRef.set(loginSession.toDocument());
      await putLoginSessionToStorage(loginSession.loginSessionId);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Future updateLoginSession(
  //     String userId, LoginSessionModel sessionModel) async {
  //   try {
  //     await _firestore
  //         .collection('users')
  //         .document(userId)
  //         .collection('loginSessions')
  //         .document(sessionModel.loginSessionId)
  //         .setData(sessionModel.toDocument());
  //     await putLoginSessionToStorage(sessionModel.loginSessionId);
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future updateLoginSession(
      String userId, LoginSessionModel sessionModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('loginSessions')
          .doc(sessionModel.loginSessionId)
          .set(sessionModel.toDocument());
      await putLoginSessionToStorage(sessionModel.loginSessionId);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Future deleteLoginSession(
  //     String userId, LoginSessionModel sessionModel) async {
  //   try {
  //     await _firestore
  //         .collection('users')
  //         .document(userId)
  //         .collection('loginSessions')
  //         .document(sessionModel.loginSessionId)
  //         .delete();
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future deleteLoginSession(
      String userId, LoginSessionModel sessionModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('loginSessions')
          .doc(sessionModel.loginSessionId)
          .delete();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String> getLoginSessionFromStorage() async {
    try {
      if (_prefs == null) _prefs = await SharedPreferences.getInstance();

      var sessionId = _prefs.getString('loginSessionId');
      return sessionId;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future putLoginSessionToStorage(String loginSessionId) async {
    try {
      if (_prefs == null) _prefs = await SharedPreferences.getInstance();

      await _prefs.setString('loginSessionId', loginSessionId);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      if (_prefs == null) _prefs = await SharedPreferences.getInstance();
      _prefs.clear();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
