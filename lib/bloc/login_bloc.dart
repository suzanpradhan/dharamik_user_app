import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:webapp/models/login_session_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/services/login_service.dart';
import 'package:webapp/utils/error_handler.dart';
import 'package:webapp/utils/service_locator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginService _loginService = locator<LoginService>();
  UserRepository _userRepository = locator<UserRepository>();

  @override
  LoginState get initialState => EmailPasswordFormState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoginLoadingState();

    if (event is SignInWithEmailPassword) {
      try {
        var user = await _loginService.signInWithEmailPassword(
            event.email, event.password);

        var loginSession = await _loginService.getLoginSession(user.uid);

        if (loginSession != null) {
          //show already logged on in another device error
          yield LoginSessionErrorState(loginSession, user.uid);
        } else {
          _userRepository.setUserId(user.uid);
          await _loginService.createLoginSession(user.uid);
          if (await _userRepository.isNewUser()) {
            var userModel = UserModel.fromFirebaseUser(user);
            locator.registerSingleton<UserModel>(userModel);
            yield NewUserState();
          } else {
            var userModel = await _userRepository.getUserFromDatabase();
            // userModel.emailVerified = user.isEmailVerified;

            userModel.emailVerified = user.emailVerified;

            locator.registerSingleton<UserModel>(userModel);
            yield LoggedInState();
          }
        }
      } catch (e) {
        yield LoginErrorState(handleAuthError(e));
      }
    } else if (event is SignInWithGoogle) {
      try {
        var user = await _loginService.signInWithGoogle();

        var loginSession = await _loginService.getLoginSession(user.uid);

        if (loginSession != null) {
          //show already logged on in another device error
          yield LoginSessionErrorState(loginSession, user.uid);
        } else {
          _userRepository.setUserId(user.uid);
          await _loginService.createLoginSession(user.uid);

          if (await _userRepository.isNewUser()) {
            var userModel = UserModel.fromFirebaseUser(user);
            locator.registerSingleton<UserModel>(userModel);
            yield NewUserState();
          } else {
            var userModel = await _userRepository.getUserFromDatabase();
            // userModel.emailVerified = user.isEmailVerified;

            userModel.emailVerified = user.emailVerified;
            locator.registerSingleton<UserModel>(userModel);
            yield LoggedInState();
          }
        }
      } catch (e) {
        yield LoginErrorState(handleAuthError(e));
      }
    } else if (event is SignInWithFacebook) {
      try {
        var user = await _loginService.signInWithFacebook();

        var loginSession = await _loginService.getLoginSession(user.uid);

        if (loginSession != null) {
          //show already logged on in another device error
          yield LoginSessionErrorState(loginSession, user.uid);
        } else {
          _userRepository.setUserId(user.uid);
          await _loginService.createLoginSession(user.uid);

          if (await _userRepository.isNewUser()) {
            var userModel = UserModel.fromFirebaseUser(user);
            locator.registerSingleton<UserModel>(userModel);
            yield NewUserState();
          } else {
            var userModel = await _userRepository.getUserFromDatabase();
            // userModel.emailVerified = user.isEmailVerified;

            userModel.emailVerified = user.emailVerified;
            locator.registerSingleton<UserModel>(userModel);
            yield LoggedInState();
          }
        }
      } catch (e) {
        yield LoginErrorState(e.message);
      }
    } else if (event is ContinueLogin) {
      var user = await _loginService.getUser();
      await _loginService.deleteLoginSession(user.uid, event.loginSession);
      _userRepository.setUserId(user.uid);
      await _loginService.createLoginSession(user.uid);

      // if (!locator.isRegistered<UserModel>()) {
      if (await _userRepository.isNewUser()) {
        var userModel = UserModel.fromFirebaseUser(user);
        locator.unregister<UserModel>();
        locator.registerSingleton<UserModel>(userModel);
        yield NewUserState();
      } else {
        var userModel = await _userRepository.getUserFromDatabase();
        // userModel.emailVerified = user.isEmailVerified;

        userModel.emailVerified = user.emailVerified;
        locator.unregister<UserModel>();
        locator.registerSingleton<UserModel>(userModel);
        yield NewUserState();
      }
      // } else {
      //   yield LoggedInState();
      // }
    } else if (event is ShowEmailPasswordForm) {
      yield EmailPasswordFormState();
    } else if (event is ShowSignUpForm) {
      yield SignUpFormState();
    } else if (event is SignUpUser) {
      try {
        var user =
            await _loginService.createUserAccount(event.email, event.password);

        await _loginService.createLoginSession(user.uid);

        final userModel = UserModel(user.uid,
            // emailVerified: user.isEmailVerified,

            emailVerified: user.emailVerified,
            userName: event.userName,
            userEmail: user.email);
        locator.registerSingleton<UserModel>(userModel);
        yield NewUserState();
      } catch (e) {
        yield LoginErrorState(handleAuthError(e));
      }
    } else if (event is LogOut) {
      _loginService.signOut();
      yield EmailPasswordFormState();
    }
  }
}
