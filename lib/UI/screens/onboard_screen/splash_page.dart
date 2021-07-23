import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/UI/screens/main_screen.dart';
import 'package:webapp/UI/screens/onboard_screen/login_page.dart';
import 'package:webapp/UI/screens/onboard_screen/user_details_screen.dart';
import 'package:webapp/bloc/splash_bloc.dart';
import 'package:webapp/utils/screen_utils.dart';

class SplashPage extends StatelessWidget {
  static const String route = '/';
  SplashBloc _splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    ScreenUtil()..init(context);
    _splashBloc.add(CheckLoginStatus());
    return Scaffold(
      body: Center(
        child: BlocListener<SplashBloc, SplashState>(
          bloc: _splashBloc,
          listener: (context, state) {
            if (state is LoggedInState)
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainPage()));
            else if (state is NewUserState)
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserDetailsScreen()));
            else if (state is NotLoggedInState)
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            else if (state is LoginSessionRemovedError) {
              Navigator.of(context).pop();
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Login Session Invalid'),
                        content: Text('You have to Login again'),
                        actions: [
                          RaisedButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              })
                        ],
                      ));
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Dharamik',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setHeight(100),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Image(
                image: AssetImage('images/logo.png'),
                width: ScreenUtil.getInstance().setWidth(500),
                height: ScreenUtil.getInstance().setHeight(500),
              ),
              CircularProgressIndicator(
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
