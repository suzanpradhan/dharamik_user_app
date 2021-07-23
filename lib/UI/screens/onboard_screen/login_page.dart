import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/widgets/logo_web.dart';

import 'package:webapp/forms/login_form.dart';
import 'package:webapp/utils/screen_utils.dart';

class LoginPage extends StatelessWidget {
  static const String route = '/login';
  @override
  Widget build(BuildContext context) {
    ScreenUtil()..init(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: context.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Logo(),
            SizedBox(height: ScreenUtil.getInstance().setHeight(48)),
            LoginForm(),
            SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                
                children: [
                  TextSpan(
                  
                      text: 'By Signing up, you agree with the ',
                      style: TextStyle(color: Colors.white)),
                  TextSpan(
                      text: 'Terms and Condition',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.dharamik.com/tnc/');
                          print('Terms and condition');
                        }),
                  TextSpan(
                      text: ' and ', style: TextStyle(color: Colors.white)),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.dharamik.com/tnc/');
                        }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget containerBuilder() {
//   return Container(
//     height: 890,
//     width: 890,
//     decoration: BoxDecoration(
//         //  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 40)],
//         color: Colors.black26,
//         borderRadius: BorderRadius.circular(890)),
//   );
// }
