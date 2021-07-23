part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoggedInState extends LoginState {
  LoggedInState();
}

class NewUserState extends LoginState{
  NewUserState();
}

class EmailPasswordFormState extends LoginState {
  EmailPasswordFormState();
}

class SignUpFormState extends LoginState {
  SignUpFormState();
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
}

class LoginSessionErrorState extends LoginState{
final LoginSessionModel loginSessionModel;
final String userId;
LoginSessionErrorState(this.loginSessionModel, this.userId);
}

class LoginErrorState extends LoginState {
  final String errorMessage;
  LoginErrorState(this.errorMessage);
}
