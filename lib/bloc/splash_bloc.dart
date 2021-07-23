import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/services/login_service.dart';
import 'package:webapp/utils/service_locator.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  LoginService _loginService = LoginService();
  UserRepository _userRepository = locator<UserRepository>();

  @override
  SplashState get initialState => SplashInitial();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is CheckLoginStatus) {
      var user = await _loginService.getUser();
      if (user != null) {
        var sessionId = await _loginService.getLoginSessionFromStorage();
        if (sessionId != null) {
          //validate session
          var session = await _loginService.getLoginSession(user.uid,
              sessionId: sessionId);
          if (session == null) {
            //show error
            await _loginService.signOut();
            yield LoginSessionRemovedError();
          } else {
            //update login session and show main screen
            await _loginService.updateLoginSession(user.uid, session);
            _userRepository.setUserId(user.uid);

            // if (!locator.isRegistered<UserModel>()) {
            if (await _userRepository.isNewUser()) {
              // locator.unregister<UserModel>();
              locator.registerSingleton<UserModel>(
                  UserModel.fromFirebaseUser(user));
              yield NewUserState();
            } else {
              var userModel = await _userRepository.getUserFromDatabase();
              // userModel.emailVerified = user.isEmailVerified;

              userModel.emailVerified = user.emailVerified;
              locator.unregister<UserModel>();
              locator.registerSingleton<UserModel>(userModel);
              yield LoggedInState();
            }
            // } else {
            //   await _loginService.signOut();
            //   yield NewUserState();
            // }
          }
        } else {
          await _loginService.signOut();
          yield NotLoggedInState();
        }
      } else
        yield NotLoggedInState();
    }
  }
}
