import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/widgets/logo_web.dart';

import 'package:webapp/services/login_service.dart';
import 'package:webapp/utils/error_handler.dart';
import 'package:webapp/utils/screen_utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailFieldController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();

  bool isLoading = false;
  LoginService _loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Close',
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: context.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Logo(),
            SizedBox(height: ScreenUtil.getInstance().setHeight(48)),
            Center(
              child: Text(
                'Forgot Password ?',
                style: TextStyle(
                    fontSize: (context.screenHeight > context.screenWidth)
                        ? ScreenUtil.getInstance().setHeight(58)
                        : ScreenUtil.getInstance().setWidth(30),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: (context.screenHeight > context.screenWidth)
                  ? ScreenUtil.getInstance().setHeight(58)
                  : ScreenUtil.getInstance().setWidth(30),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
                minHeight: ScreenUtil.getInstance().setHeight(100),
                maxHeight: ScreenUtil.getInstance().setHeight(150),
              ),
              child: Form(
                key: _emailFormKey,
                child: TextFormField(
                  controller: emailFieldController,
                  validator: (email) {
                    if (email.contains('@') && email.contains('.com'))
                      return null;

                    return 'Please Enter Valid Email';
                  },
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidEnvelope,
                      color: Colors.white,
                    ),
                    labelText: 'Email',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (context.screenHeight > context.screenWidth)
                  ? ScreenUtil.getInstance().setHeight(58)
                  : ScreenUtil.getInstance().setWidth(30),
            ),
            (isLoading)
                ? CircularProgressIndicator(
                    color: Colors.red,
                  )
                : FlatButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () async {
                      if (_emailFormKey.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await _loginService.sendForgotPasswordLink(
                              emailFieldController.text);
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Login Error'),
                                content: Text(
                                  handleAuthError(e),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Ok'))
                                ],
                              );
                            },
                          );
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
          ],
        ),
      ),
    );
  }
}
