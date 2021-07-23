part of 'video_session_bloc.dart';

@immutable
abstract class VideoSessionEvent {
  VideoSessionEvent();
}

class GetInitialVideos extends VideoSessionEvent{
  GetInitialVideos();
}

class GetMembershipVideos extends VideoSessionEvent{
  final String membershipId;
  GetMembershipVideos(this.membershipId);
}

class GetNextVideos extends VideoSessionEvent{
  GetNextVideos();
}
