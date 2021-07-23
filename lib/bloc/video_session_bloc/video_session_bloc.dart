import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/membership_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/models/video_model.dart';
import 'package:webapp/repositories/membership_repository.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/repositories/videos_repository.dart';
import 'package:webapp/utils/service_locator.dart';

part 'video_session_event.dart';
part 'video_session_state.dart';

class VideoSessionBloc extends Bloc<VideoSessionEvent, VideoSessionState> {
  final membershipRepo = locator<MembershipsRepo>();
  final videosRepo = locator<VideosRepo>();
  List<MembershipModel> memberships;
  List<VideoModel> videosList = [];

  @override
  VideoSessionState get initialState => VideosLoading();

  @override
  Stream<VideoSessionState> mapEventToState(
    VideoSessionEvent event,
  ) async* {
    if (event is GetInitialVideos) {
      yield VideosLoading();
      memberships = await membershipRepo.getMemberships();
      // var u = await FirebaseAuth.instance.currentUser();
      var u = FirebaseAuth.instance.currentUser;
      var repo = UserRepository();
      repo.setUserId(u.uid);
      UserModel user = await repo.getUserFromDatabase();

      MembershipModel membershipModel = memberships
          .firstWhere((element) => element.membershipId == user.membershipId);
      List<MembershipModel> temp = [];
      for (int i = 0; i < memberships.length; i++) {
        if (membershipModel.level <= memberships[i].level) {
          temp.add(memberships[i]);
        }
      }

      print('temp categories');
      print(temp);

      memberships = temp;

      var videos = await videosRepo.getVideos(user.membershipId);
      yield VideoSessionInitial(memberships, videos);
    } else if (event is GetMembershipVideos) {
      yield VideosLoading();
      videosList.clear();
      var videos = await videosRepo.getVideos(event.membershipId);
      videosList.addAll(videos);
      yield VideosLoaded(memberships, videosList);
    } else if (event is GetNextVideos) {
      var videos = await videosRepo.getNextVideos();
      videosList.addAll(videos);
      yield VideosLoaded(memberships, videosList);
    }
  }
}
