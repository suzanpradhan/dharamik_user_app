part of 'video_session_bloc.dart';

@immutable
abstract class VideoSessionState {
  VideoSessionState();
}

class VideoSessionInitial extends VideoSessionState {
  final List<MembershipModel> memberships;
  final List<VideoModel> videos;
  VideoSessionInitial(this.memberships, this.videos);
}

class VideosLoaded extends VideoSessionState{
   final List<MembershipModel> memberships;
  final List<VideoModel> videos;
  VideosLoaded(this.memberships, this.videos);
}

class VideosLoading extends VideoSessionState{
  VideosLoading();
}
