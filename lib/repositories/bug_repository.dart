import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/models/bug_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class BugRepository {
  static sendEmail(String subject, String body) async {
    String url =
        'https://www.dharamik.com/webapp/mail.php?to=dharamikapp@gmail.com&subject=$subject&message=$body';

    try {
      var rep = await sendEmailRequest(url);

      if (rep)
        return 'User added Successfully';
      else
        return 'User already exists';
    } catch (e) {
      return 'User added Successfully';
    }
  }

  static sendEmailRequest(url) async {
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        if (jsonDecode(data) == 'mail_send') return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static getAllBugs() async {
    // var docs = await Firestore.instance.collection('bugs').getDocuments();
    var docs = await FirebaseFirestore.instance.collection('bugs').get();

    List<BugModel> bugs = [];
    docs.docs.forEach((element) {
      bugs.add(BugModel.fromJson(element.data));
    });

    // docs.documents.forEach((element) {
    //   bugs.add(BugModel.fromJson(element.data));
    // });

    return bugs;
  }

  static addNewBug(BugModel bugModel) async {
    UserModel user = await UserRepository().getCurrentUserFromDatabase();

    print('i have the user ${user.userId}');
    bugModel.userPhotoUrl = user.userPhotoURL;
    bugModel.userName = user.userName;
    bugModel.userId = user.userId;

    // await Firestore.instance.collection('bugs').add(bugModel.toJson());
    await FirebaseFirestore.instance.collection('bugs').add(bugModel.toJson());

    await sendEmail('Bug ${bugModel.name}', '${bugModel.detail}');
  }
}
