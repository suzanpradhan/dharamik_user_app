part of 'saved_videos_bloc.dart';

@immutable
abstract class SavedVideosState {}

class SavedVideosLoading extends SavedVideosState {}

class SavedVideosLoaded extends SavedVideosState{
  final List<SavedVideoModel> savedVideos;
  SavedVideosLoaded(this.savedVideos);
}

