import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/saved_video_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/utils/service_locator.dart';

part 'saved_videos_event.dart';
part 'saved_videos_state.dart';

class SavedVideosBloc extends Bloc<SavedVideosEvent, SavedVideosState> {
  final UserRepository userRepository = locator<UserRepository>();
  final UserModel userModel = locator<UserModel>();
  List<SavedVideoModel> savedVideos = List();

  @override
  SavedVideosState get initialState => SavedVideosLoading();
  @override
  Stream<SavedVideosState> mapEventToState(
    SavedVideosEvent event,
  ) async* {
    if (event is GetSavedVideos) {
      yield SavedVideosLoading();
      savedVideos = await userRepository.getSavedVideos();
      yield SavedVideosLoaded(savedVideos);
    } else if (event is RemoveSavedVideo) {
      await userRepository.unSaveVideo(event.videoId);
      savedVideos.removeWhere((element) => element.videoId == event.videoId);
      yield SavedVideosLoaded(savedVideos);
    }
  }
}
