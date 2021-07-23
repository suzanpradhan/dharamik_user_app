// import 'package:platform_detect/platform_detect.dart' as Platform;
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginSessionModel {
  String loginSessionId;
  Timestamp lastLoggedIn;
  String platform;
  String browser;
  String operatingSystem;

  LoginSessionModel();

  LoginSessionModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : this.loginSessionId = documentSnapshot.data()['loginSessionId'],
        this.lastLoggedIn = documentSnapshot.data()['lastLoggedIn'],
        this.platform = documentSnapshot.data()['platform'],
        this.browser = documentSnapshot.data()['browser'],
        this.operatingSystem = documentSnapshot.data()['operatingSystem'];
  // : this.loginSessionId = documentSnapshot.data['loginSessionId'],
  //   this.lastLoggedIn = documentSnapshot.data['lastLoggedIn'],
  //   this.platform = documentSnapshot.data['platform'],
  //   this.browser = documentSnapshot.data['browser'],
  //   this.operatingSystem = documentSnapshot.data['operatingSystem'];

  Map<String, Object> toDocument() {
    return {
      'loginSessionId': loginSessionId,
      'lastLoggedIn': FieldValue.serverTimestamp(),
      'platform': 'WebApp',
      // 'browser': Platform.browser.name,
      // 'operatingSystem': Platform.operatingSystem.name
    };
  }
}
