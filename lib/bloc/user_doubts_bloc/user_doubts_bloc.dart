import 'dart:async';
import 'dart:io';
// import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/doubt_category_model.dart';
import 'package:webapp/models/user_doubt_model.dart';
import 'package:webapp/repositories/user_doubts_repository.dart';
import 'package:webapp/utils/service_locator.dart';

part 'user_doubts_event.dart';
part 'user_doubts_state.dart';

class UserDoubtsBloc extends Bloc<UserDoubtsEvent, UserDoubtsState> {
  UserDoubtModel userDoubtModel;
  List<DoubtCategory> doubtCategories;
  final UserDoubtsRepo userDoubtsRepo = locator<UserDoubtsRepo>();

  @override
  UserDoubtsState get initialState => UserDoubtsDialogLoading();

  @override
  Stream<UserDoubtsState> mapEventToState(
    UserDoubtsEvent event,
  ) async* {
    yield UserDoubtsDialogLoading();

    if (event is GetUserDoubtDialogInfo) {
      doubtCategories = await userDoubtsRepo.getDoubtCategories();
      yield UserDoubtsDialogInitial(doubtCategories);
    } else if (event is ImageChangedEvent) {
      if (event.file != null) {
        if (userDoubtModel == null) userDoubtModel = UserDoubtModel();
        userDoubtModel.imageFile = event.file;
      }
      yield UserDoubtsDialogInitial(doubtCategories);
    } else if (event is CreateDoubtEvent) {
      userDoubtModel.doubtTitle = event.userDoubtModel.doubtTitle;
      userDoubtModel.doubtDescription = event.userDoubtModel.doubtDescription;
      userDoubtModel.userId = event.userDoubtModel.userId;
      userDoubtModel.userName = event.userDoubtModel.userName;
      userDoubtModel.userEmail = event.userDoubtModel.userEmail;
      userDoubtModel.doubtCategoryName = event.userDoubtModel.doubtCategoryName;
      await userDoubtsRepo.createDoubt(userDoubtModel);
      yield UserDoubtUploaded();
    }
  }
}
