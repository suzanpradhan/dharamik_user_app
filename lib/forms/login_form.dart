import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/screens/main_screen.dart';
import 'package:webapp/UI/widgets/login_button.dart';
import 'package:webapp/bloc/login_bloc.dart';
import 'package:webapp/models/login_session_model.dart';
import 'package:webapp/utils/screen_utils.dart';

import '../UI/screens/onboard_screen/forgot_password_page.dart';
import '../UI/screens/onboard_screen/user_details_screen.dart';
import '../utils/screen_utils.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailPasswordFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  final TextEditingController signUpNameFieldController =
      TextEditingController();
  final TextEditingController signUpEmailFieldController =
      TextEditingController();
  final TextEditingController signUpPasswordFieldController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordFieldController =
      TextEditingController();
  double _textFieldWidth = 410;
  LoginBloc _loginBloc = LoginBloc();
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSessionErrorState) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    content: PreviousLoginDetectedDialog(
                      onConfirmPressed: () {
                        _loginBloc.add(ContinueLogin(state.loginSessionModel));
                        Navigator.of(context).pop();
                      },
                      onCancelPressed: () {
                        _loginBloc.add(LogOut());
                        Navigator.of(context).pop();
                      },
                      loginSessionModel: state.loginSessionModel,
                    ),
                  );
                });
          } else if (state is LoginErrorState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Login Error'),
                  content: Text(
                    state.errorMessage,
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
          } else if (state is LoggedInState) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return MainPage();
            }));
          } else if (state is NewUserState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => UserDetailsScreen()));
          }
        },
        bloc: _loginBloc,
        builder: (context, state) {
          if (state is EmailPasswordFormState || state is LoginErrorState) {
            return getEmailLoginForm();
          } else if (state is SignUpFormState) {
            return getSignUpForm();
          }

          return Container(
            height: context.screenHeight * 0.4,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        });
  }

  Widget getEmailLoginForm() {
    return ListView(
      //mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      shrinkWrap: true,
      children: <Widget>[
        Center(
          child: Text(
            'Login',
            style: TextStyle(
                fontSize: (context.screenHeight > context.screenWidth)
                    ? ScreenUtil.getInstance().setHeight(88)
                    : ScreenUtil.getInstance().setWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        SizedBox(
          height: (context.screenHeight > context.screenWidth)
              ? ScreenUtil.getInstance().setHeight(38)
              : ScreenUtil.getInstance().setWidth(10),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Form(
            key: _emailPasswordFormKey,
            child: AutofillGroup(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 40,
                      maxHeight: 60,
                    ),
                    child: Container(
                      width: 430,
                      height: ScreenUtil.getInstance().setHeight(120),
                      child: TextFormField(
                        autofillHints: [AutofillHints.email],
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
                              Radius.circular(30.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.solidEnvelope,
                            size: 24,
                            color: Colors.white,
                          ),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(24),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 40,
                      maxHeight: 60,
                    ),
                    child: Container(
                      width: 430,
                      height: ScreenUtil.getInstance().setHeight(120),
                      child: TextFormField(
                        autofillHints: [AutofillHints.password],
                        controller: passwordFieldController,
                        validator: (password) {
                          if (password.length < 8) return 'Password Too Short';

                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (_emailPasswordFormKey.currentState.validate()) {
                            _loginBloc.add(SignInWithEmailPassword(
                                emailFieldController.text,
                                passwordFieldController.text));
                          }
                        },
                        obscureText: _passwordVisible,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(_passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.lock,
                            size: 24,
                            color: Colors.white,
                          ),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 60,
                      maxHeight: 80,
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () async {
                        bool showSnackbar = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));

                        if (showSnackbar != null && showSnackbar)
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Password Reset link sent. Check your email.'),
                          ));
                      },
                      child: Text(
                        'Forgot password ?',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: ScreenUtil.getInstance().setHeight(100)),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    _loginBloc.add(ShowSignUpForm());
                  },
                  child: Text('Sign Up'),
                ),
                SizedBox(
                  width: ScreenUtil.getInstance().setHeight(48),
                ),
                FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    if (_emailPasswordFormKey.currentState.validate()) {
                      _loginBloc.add(SignInWithEmailPassword(
                          emailFieldController.text,
                          passwordFieldController.text));
                    }
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: (context.screenHeight > context.screenWidth)
              ? ScreenUtil.getInstance().setHeight(38)
              : ScreenUtil.getInstance().setWidth(10),
        ),
        Center(child: Text("OR")),
        SizedBox(
          height: (context.screenHeight > context.screenWidth)
              ? ScreenUtil.getInstance().setHeight(36)
              : ScreenUtil.getInstance().setWidth(10),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16.0,
          runSpacing: 8.0,
          children: <Widget>[
            getGoogleLoginButton(),
            getFacebookLoginButton(),
          ],
        ),
      ],
    );
  }

  Widget getSignUpForm() {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
                fontSize: (context.screenHeight > context.screenWidth)
                    ? ScreenUtil.getInstance().setHeight(88)
                    : ScreenUtil.getInstance().setWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        SizedBox(
          height: (context.screenHeight > context.screenWidth)
              ? ScreenUtil.getInstance().setHeight(48)
              : ScreenUtil.getInstance().setWidth(18),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Form(
            key: _signUpFormKey,
            child: AutofillGroup(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: ScreenUtil.getInstance().setHeight(100),
                      maxHeight: ScreenUtil.getInstance().setHeight(150),
                    ),
                    child: Container(
                      width: _textFieldWidth,
                      child: TextFormField(
                        autofillHints: [AutofillHints.name],
                        controller: signUpNameFieldController,
                        validator: (name) {
                          if (name.isNotEmpty) return null;

                          return 'Please Enter your full name';
                        },
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.white,
                          ),
                          labelText: 'Full Name',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(16),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: ScreenUtil.getInstance().setHeight(100),
                      maxHeight: ScreenUtil.getInstance().setHeight(150),
                    ),
                    child: Container(
                      width: _textFieldWidth,
                      child: TextFormField(
                        autofillHints: [AutofillHints.email],
                        controller: signUpEmailFieldController,
                        validator: (email) {
                          if (email.contains('@') && email.contains('.com'))
                            return null;

                          return 'Please Enter Valid Email';
                        },
                        textAlign: TextAlign.left,
                        textInputAction: TextInputAction.next,
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
                    height: ScreenUtil.getInstance().setHeight(18),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: ScreenUtil.getInstance().setHeight(100),
                      maxHeight: ScreenUtil.getInstance().setHeight(150),
                    ),
                    child: Container(
                      width: _textFieldWidth,
                      child: TextFormField(
                        autofillHints: [AutofillHints.newPassword],
                        controller: signUpPasswordFieldController,
                        validator: (password) {
                          if (password.length < 8) return 'Password Too Short';

                          return null;
                        },
                        obscureText: true,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.lockOpen,
                            color: Colors.white,
                          ),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(24),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: ScreenUtil.getInstance().setHeight(100),
                      maxHeight: ScreenUtil.getInstance().setHeight(150),
                    ),
                    child: Container(
                      width: _textFieldWidth,
                      child: TextFormField(
                        controller: signUpConfirmPasswordFieldController,
                        validator: (password) {
                          if (signUpPasswordFieldController.text != password)
                            return 'Passwords don\'t match';

                          return null;
                        },
                        obscureText: true,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.white,
                          ),
                          labelText: 'Confirm Password',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(33),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: ScreenUtil.getInstance().setHeight(100)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {
                  _loginBloc.add(ShowEmailPasswordForm());
                },
                child: Text('Log In'),
              ),
              SizedBox(
                width: ScreenUtil.getInstance().setWidth(38),
              ),
              FlatButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {
                  if (_signUpFormKey.currentState.validate()) {
                    _loginBloc.add(SignUpUser(
                        signUpNameFieldController.text,
                        signUpEmailFieldController.text,
                        signUpPasswordFieldController.text));
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: (context.screenHeight > context.screenWidth)
              ? ScreenUtil.getInstance().setHeight(43)
              : ScreenUtil.getInstance().setWidth(15),
        ),
        Text("OR"),
        SizedBox(
          height: (context.screenHeight > context.screenWidth)
              ? ScreenUtil.getInstance().setHeight(43)
              : ScreenUtil.getInstance().setWidth(15),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16.0,
          runSpacing: 8.0,
          children: <Widget>[
            getGoogleLoginButton(),
            getFacebookLoginButton(),
          ],
        )
      ],
    );
  }

  LoginButton getEmailLoginButton() {
    return LoginButton(
      textColor: Colors.black,
      color: Colors.white,
      icon: FontAwesomeIcons.envelope,
      onPressed: () {
        _loginBloc.add(ShowEmailPasswordForm());
      },
      text: 'Sign in with Email',
      iconColor: Colors.black,
    );
  }

  LoginButton getFacebookLoginButton() {
    return LoginButton(
      color: Colors.blue[900],
      icon: FontAwesomeIcons.facebook,
      onPressed: () {
        _loginBloc.add(SignInWithFacebook());
      },
      text: 'Sign in with Facebook',
    );
  }

//   Widget getGoogleLoginButton() {
//     return LoginButton(
//       textColor: Colors.black,
//       icon: FontAwesomeIcons.google,
//       text: 'Sign in with Google',
//       onPressed: () {
//           _loginBloc.add(SignInWithGoogle());
//       },
//       color: Colors.white,
//       iconColor: Colors.black,
//     );
//   }
// }

  Widget getGoogleLoginButton() {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: ScreenUtil.getInstance().setHeight(100)),
      child: RaisedButton(
        elevation: 60,
        padding: EdgeInsets.only(left: 10, right: 8),
        hoverElevation: 40,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/gicon.png'),
              width: 25,
              height: 25,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        onPressed: () {
          _loginBloc.add(SignInWithGoogle());
        },
      ),
    );
  }
}

class PreviousLoginDetectedDialog extends StatelessWidget {
  final Function onCancelPressed;
  final Function onConfirmPressed;
  final LoginSessionModel loginSessionModel;
  PreviousLoginDetectedDialog(
      {this.onConfirmPressed, this.onCancelPressed, this.loginSessionModel});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Container(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Previous Login Detected in ${loginSessionModel.platform}',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 8),
            (loginSessionModel.platform == 'WebApp')
                ? Text(
                    'We have detected that you previously logged into our ${loginSessionModel.platform}(${loginSessionModel.browser}, ${loginSessionModel.operatingSystem}). Due to security reasons, you can\'t login to more than one device. If you wish to continue, your previous login session will be removed.')
                : Text(
                    'We have detected that you previously logged into our ${loginSessionModel.platform}(${loginSessionModel.operatingSystem}). Due to security reasons, you can\'t login to more than one device. If you wish to continue, your previous login session will be removed.'),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    color: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: onCancelPressed,
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: onConfirmPressed,
                    color: Theme.of(context).accentColor,
                    child: Text('Confirm'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
