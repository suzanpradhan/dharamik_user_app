part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class ShowEmailPasswordForm extends LoginEvent {
  ShowEmailPasswordForm();
}

class ShowSignUpForm extends LoginEvent {
  ShowSignUpForm();
}

class SignUpUser extends LoginEvent {
  final String userName, email, password;
  SignUpUser(this.userName, this.email, this.password);
}

class SignInWithGoogle extends LoginEvent {
  SignInWithGoogle();
}

class SignInWithEmailPassword extends LoginEvent {
  final String email, password;
  SignInWithEmailPassword(this.email, this.password);
}

class ContinueLogin extends LoginEvent {
  final LoginSessionModel loginSession;
  ContinueLogin(this.loginSession);
}

class LogOut extends LoginEvent{
  LogOut();
}

class SignInWithFacebook extends LoginEvent {
  SignInWithFacebook();
}
