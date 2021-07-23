part of 'video_details_screen_bloc.dart';

@immutable
abstract class VideoDetailsScreenEvent {}

class GetVideoDetails extends VideoDetailsScreenEvent {
  final String videoId;
  GetVideoDetails(this.videoId);
}

class GetNextVideoReviews extends VideoDetailsScreenEvent{
  final String videoId;
  GetNextVideoReviews(this.videoId);
}

class SubmitReview extends VideoDetailsScreenEvent {
  final VideoReviewModel videoReviewModel;
  SubmitReview(this.videoReviewModel);
}

class SaveVideoToProfile extends VideoDetailsScreenEvent {
  final SavedVideoModel savedVideoModel;
  SaveVideoToProfile(this.savedVideoModel);
}

class UnsaveVideo extends VideoDetailsScreenEvent {
  final String videoId;
  UnsaveVideo(this.videoId);
}
