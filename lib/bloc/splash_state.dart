part of 'splash_bloc.dart';

@immutable
abstract class SplashState {
  SplashState();
}

class SplashInitial extends SplashState{
  SplashInitial();
}

class LoggedInState extends SplashState{
  LoggedInState();
}

class LoginSessionRemovedError extends SplashState{
  LoginSessionRemovedError();
}

class NewUserState extends SplashState{
  NewUserState();
}

class NotLoggedInState extends SplashState{
  NotLoggedInState();
}


