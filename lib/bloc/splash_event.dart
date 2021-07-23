part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {
  SplashEvent();
}

class CheckLoginStatus extends SplashEvent{
  CheckLoginStatus();
}
