import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:webapp/bloc/video_details_screen_bloc/video_details_screen_bloc.dart';
import 'package:webapp/models/saved_video_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/models/video_model.dart';
import 'package:webapp/models/video_review_model.dart';
import 'package:webapp/utils/screen_utils.dart';
import 'package:webapp/utils/service_locator.dart';
import 'package:webapp/utils/time_helper.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/utils/video_controls_overlay.dart';

class VideoDetailsScreen extends StatefulWidget {
  final String videoId;
  VideoDetailsScreen(this.videoId);
  @override
  _VideoDetailsScreenState createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  VideoPlayerController _controller;
  String currentPosition = '00:00';
  bool isFullscreen = false;
  UserModel userModel = locator<UserModel>();
  int videoRating = 0;

  TextEditingController reviewTextController = TextEditingController();
  VideoDetailsScreenBloc _videoDetailsScreenBloc = VideoDetailsScreenBloc();
  VideoModel videoModel;

  @override
  void initState() {
    _videoDetailsScreenBloc.add(GetVideoDetails(widget.videoId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VideoDetailsScreenBloc, VideoDetailsScreenState>(
        bloc: _videoDetailsScreenBloc,
        listener: (context, state) {
          if (state is VideoDetailsScreenLoaded) {
            this.videoModel = state.videoModel;
            if (_controller == null) initVideoController();
          }
        },
        builder: (context, state) {
          if (state is VideoDetailsScreenLoaded) {
            return Stack(
              children: [
                _controller.value.initialized
                    ? Scaffold(
                        appBar: AppBar(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  videoModel.videoTitle,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              getSaveButton(state.isSaved)
                            ],
                          ),
                        ),
                        body: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 500),
                            child: ListView(
                              children: [
                                SizedBox(
                                  width: (context.mdWindowSize ==
                                              MobileWindowSize.small ||
                                          context.mdWindowSize ==
                                              MobileWindowSize.xsmall)
                                      ? 500
                                      : context.screenHeight * 0.7,
                                  height: (context.mdWindowSize ==
                                              MobileWindowSize.small ||
                                          context.mdWindowSize ==
                                              MobileWindowSize.xsmall)
                                      ? context.screenHeight * 0.3
                                      : context.screenHeight * 0.76,
                                  child: Container(),
                                ),
                                (context.mdWindowSize ==
                                            MobileWindowSize.small ||
                                        context.mdWindowSize ==
                                            MobileWindowSize.xsmall)
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: ScreenUtil.getInstance()
                                                  .setHeight(24),
                                            ),
                                            Text(
                                              'Description',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            SizedBox(height: 8),
                                            Text(videoModel.videoDesc,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption),
                                            SizedBox(height: 20),
                                            state.isReviewed
                                                ? Offstage()
                                                : getPostReviewField(),
                                            SizedBox(height: 8),
                                            Text(
                                              'Reviews',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            SizedBox(height: 8),
                                            getReviewsList(state.videoReviews)
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                Align(
                    alignment:
                        (context.mdWindowSize == MobileWindowSize.small ||
                                context.mdWindowSize == MobileWindowSize.xsmall)
                            ? Alignment.topCenter
                            : Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (_controller.value.initialized)
                            ? Container(
                                margin: EdgeInsets.only(top: kToolbarHeight),
                                height: (context.screenWidth * 0.7) /
                                    _controller.value.aspectRatio,
                                width: context.screenWidth * 0.7,
                              )
                            : Container(),
                        (context.mdWindowSize == MobileWindowSize.small ||
                                context.mdWindowSize == MobileWindowSize.xsmall)
                            ? Container()
                            : Container(
                                child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    SizedBox(height: 8),
                                    Text(videoModel.videoDesc,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                  ],
                                ),
                              )),
                      ],
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 35.0, left: 30.0, right: 10.0),
                    width: MediaQuery.of(context).size.width * 0.28,
                    child: (context.mdWindowSize == MobileWindowSize.small ||
                            context.mdWindowSize == MobileWindowSize.xsmall)
                        ? Container()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(24),
                              ),
                              SizedBox(height: 20),
                              // state.isReviewed
                              //     ? Offstage()
                              //     : getPostReviewField(),
                              state.isReviewed
                                  ? Offstage()
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.49,
                                      child: getPostReviewField()),
                              SizedBox(height: 8),
                              Text(
                                'Reviews',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 8),
                              getReviewsList(state.videoReviews)
                            ],
                          ),
                  ),
                ),
                getVideoView(),
              ],
            );
          } else
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
        },
      ),
    );
  }

  Widget getSaveButton(bool isSaved) {
    return IconButton(
        tooltip: isSaved ? 'Remove from Saved' : 'Save Video',
        icon: isSaved ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
        onPressed: () {
          if (isSaved)
            _videoDetailsScreenBloc.add(UnsaveVideo(videoModel.videoId));
          else {
            var savedVideoModel = SavedVideoModel(
                videoId: videoModel.videoId,
                videoTitle: videoModel.videoTitle,
                videoThumbnailURL: videoModel.videoThumbnailURL);
            _videoDetailsScreenBloc.add(SaveVideoToProfile(savedVideoModel));
          }
        });
  }

  Widget getPostReviewField() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Give a Review',
              style: Theme.of(context).textTheme.headline5,
            )),
        SizedBox(height: 10),
        RatingBar(
            onRatingChanged: (rating) {
              this.videoRating = rating.toInt();
            },
            filledIcon: Icons.star,
            filledColor: Colors.yellow,
            emptyIcon: Icons.star_border),
        SizedBox(height: 10),
        TextField(
          controller: reviewTextController,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Your Review'),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: RaisedButton(
              color: Colors.red,
              child: Text('Submit Review'),
              onPressed: () {
                if (reviewTextController.text.isEmptyOrNull ||
                    videoRating == 0) {
                  Flushbar(
                    message: 'Review Fields can\'t be empty',
                    margin: EdgeInsets.all(8),
                    borderRadius: 8,
                    maxWidth: 500,
                    duration: Duration(seconds: 2),
                  )..show(context);
                } else {
                  var reviewModel = VideoReviewModel(
                    reviewText: reviewTextController.text,
                    videoId: videoModel.videoId,
                    videoTitle: videoModel.videoTitle,
                    videoThumbnailURL: videoModel.videoThumbnailURL,
                    rating: videoRating,
                    userId: userModel.userId,
                    userName: userModel.userName,
                  );
                  _videoDetailsScreenBloc.add(SubmitReview(reviewModel));
                }
              }),
        )
      ],
    );
  }

  Widget getReviewsList(List<VideoReviewModel> reviewsList) {
    if (reviewsList.isEmpty)
      return Center(child: Text('No Reviews'));
    else
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reviewsList[index].reviewText),
            subtitle: Text(reviewsList[index].userName),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(reviewsList[index].rating.toString()),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              ],
            ),
          );
        },
        itemCount: reviewsList.length,
      );
  }

  Widget getVideoView() {
    return _controller.value.initialized
        ? AnimatedContainer(
            margin: EdgeInsets.only(top: (isFullscreen) ? 0 : kToolbarHeight),
            height: (isFullscreen)
                ? context.screenHeight
                : (context.mdWindowSize == MobileWindowSize.small ||
                        context.mdWindowSize == MobileWindowSize.xsmall)
                    ? context.screenHeight * 0.3
                    : (context.screenWidth * 0.7) /
                        _controller.value.aspectRatio,
            width: (isFullscreen)
                ? context.screenWidth
                : (context.mdWindowSize == MobileWindowSize.small ||
                        context.mdWindowSize == MobileWindowSize.xsmall)
                    ? 500
                    : context.screenWidth * 0.7,
            duration: Duration(milliseconds: 500),
            child: Card(
              margin: EdgeInsets.all(0),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: GestureDetector(
                  child: Stack(
                    children: [
                      VideoPlayer(_controller),
                      PlayPauseOverlay(
                        controller: _controller,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            VideoProgressIndicator(
                              _controller,
                              padding: EdgeInsets.all(0.0),
                              allowScrubbing: true,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '$currentPosition/${printDuration(_controller.value.duration)}'),
                                      IconButton(
                                          icon: (isFullscreen)
                                              ? Icon(Icons.fullscreen_exit)
                                              : Icon(Icons.fullscreen),
                                          onPressed: () {
                                            setState(() {
                                              isFullscreen = !isFullscreen;
                                            });
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  initVideoController() {
    _controller = VideoPlayerController.network(videoModel.videoURL)
      ..initialize().then((_) {
        if (mounted) {
          _controller.addListener(() {
            if (mounted)
              setState(() {
                currentPosition = printDuration(_controller.value.position);
              });
          });
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
