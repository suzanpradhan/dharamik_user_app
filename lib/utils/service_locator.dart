import 'package:get_it/get_it.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/common_doubts_repository.dart';
import 'package:webapp/repositories/dashboard_repository.dart';
import 'package:webapp/repositories/membership_repository.dart';
import 'package:webapp/repositories/news_repository.dart';
import 'package:webapp/repositories/notification_repository.dart';
import 'package:webapp/repositories/user_doubts_repository.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/repositories/videos_repository.dart';
import 'package:webapp/services/login_service.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerLazySingleton(() => LoginService());
  locator.registerLazySingleton(() => DashboardRepo());
  locator.registerLazySingleton(() => UserModel(null));
  locator.registerLazySingleton(() => NewsRepo());
  locator.registerLazySingleton(() => MembershipsRepo());
  locator.registerLazySingleton(() => VideosRepo());
  locator.registerLazySingleton(() => CommonDoubtsRepo());
  locator.registerLazySingleton(() => UserDoubtsRepo());
  locator.registerLazySingleton(() => NotificationsRepo());
}
