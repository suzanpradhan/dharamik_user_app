import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/saved_video_model.dart';
import 'package:webapp/models/video_model.dart';
import 'package:webapp/models/video_review_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/repositories/videos_repository.dart';
import 'package:webapp/utils/service_locator.dart';

part 'video_details_screen_event.dart';
part 'video_details_screen_state.dart';

class VideoDetailsScreenBloc extends Bloc<VideoDetailsScreenEvent, VideoDetailsScreenState> {
  final VideosRepo _videosRepo = locator<VideosRepo>();
  final UserRepository _userRepository = locator<UserRepository>();
  bool isSaved, isReviewed;
  List<VideoReviewModel> videoReviews;
  VideoModel videoModel;

  @override
  VideoDetailsScreenState get initialState => VideoDetailsScreenLoading();

  @override
  Stream<VideoDetailsScreenState> mapEventToState(
    VideoDetailsScreenEvent event,
  ) async* {
    if(event is GetVideoDetails){
      yield VideoDetailsScreenLoading();
      videoModel = await _videosRepo.getVideoDetails(event.videoId);
      isSaved = await _videosRepo.isVideoSaved(event.videoId);
      isReviewed = await _videosRepo.isVideoReviewed(event.videoId);
      videoReviews = await _videosRepo.getVideoReviews(event.videoId);
      yield VideoDetailsScreenLoaded(isSaved, isReviewed, videoReviews,videoModel);
    } else if(event is GetNextVideoReviews){
      var reviews = await _videosRepo.getNextVideoReviews(event.videoId);
      videoReviews.addAll(reviews);
      yield VideoDetailsScreenLoaded(isSaved, isReviewed, videoReviews,videoModel);
    } else if(event is SubmitReview){
      yield VideoDetailsScreenLoading();
      await _videosRepo.submitReview(event.videoReviewModel);
      isReviewed = true;
      yield VideoDetailsScreenLoaded(isSaved, isReviewed, videoReviews,videoModel);
    } else if(event is SaveVideoToProfile){
      await _userRepository.saveVideo(event.savedVideoModel);
      isSaved = true;
      yield VideoDetailsScreenLoaded(isSaved, isReviewed, videoReviews,videoModel);
    } else if(event is UnsaveVideo){
      await _userRepository.unSaveVideo(event.videoId);
      isSaved = false;
      yield VideoDetailsScreenLoaded(isSaved, isReviewed, videoReviews,videoModel);
    }
  }
}
