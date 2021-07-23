part of 'saved_videos_bloc.dart';

@immutable
abstract class SavedVideosEvent {}

class GetSavedVideos extends SavedVideosEvent{}

class RemoveSavedVideo extends SavedVideosEvent{
  final String videoId;
  RemoveSavedVideo(this.videoId);
}
