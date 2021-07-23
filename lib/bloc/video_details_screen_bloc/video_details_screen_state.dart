part of 'video_details_screen_bloc.dart';

@immutable
abstract class VideoDetailsScreenState {}

class VideoDetailsScreenLoaded extends VideoDetailsScreenState {
  final bool isSaved;
  final bool isReviewed;
  final List<VideoReviewModel> videoReviews;
  final VideoModel videoModel;

  VideoDetailsScreenLoaded(this.isSaved, this.isReviewed, this.videoReviews, this.videoModel);
}

class VideoDetailsScreenLoading extends VideoDetailsScreenState {}
