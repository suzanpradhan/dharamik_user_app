import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webapp/models/common_doubts_model.dart';
import 'package:webapp/models/user_doubt_model.dart';
import 'package:webapp/utils/screen_utils.dart';
import 'package:webapp/utils/time_helper.dart';
import 'package:webapp/utils/video_controls_overlay.dart';

class DoubtDetailsScreen extends StatefulWidget {
  final UserDoubtModel doubtsModel;
  DoubtDetailsScreen(this.doubtsModel);
  @override
  _DoubtDetailsScreenState createState() => _DoubtDetailsScreenState();
}

class _DoubtDetailsScreenState extends State<DoubtDetailsScreen> {
  VideoPlayerController _controller;
  String currentPosition = '00:00';

  @override
  void initState() {
    print('video attachment url ${widget.doubtsModel.videoAttachmentURL}');
    if (widget.doubtsModel.videoAttachmentURL != null) initVideoController();
    super.initState();
  }

  initVideoController() {
    _controller =
        VideoPlayerController.network(widget.doubtsModel.videoAttachmentURL)
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
          ),
          child: (widget.doubtsModel.videoAttachmentURL==null || widget.doubtsModel.videoAttachmentURL != null &&
                  _controller.value.initialized)
              ? Container(
                  
                  child: ListView(
                    children: [
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(24),
                      ),
                      Row(
                        children: [
                          (widget.doubtsModel.imageAttachmentURL != null)
                              ? Expanded(
                                  child: Image.network(
                                      widget.doubtsModel.imageAttachmentURL))
                              : Offstage(),
                          (widget.doubtsModel.videoAttachmentURL != null)
                              ? Expanded(child: getVideoView())
                              : Offstage(),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(24),
                      ),
                      Text(
                        widget.doubtsModel.doubtTitle,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(24),
                      ),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      Text(widget.doubtsModel.doubtDescription,
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Widget getVideoView() {
    return _controller.value.initialized
        ? Card(
            margin: EdgeInsets.all(0),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Text(
                                '$currentPosition/${printDuration(_controller.value.duration)}'),
                          ),
                          VideoProgressIndicator(
                            _controller,
                            padding: EdgeInsets.all(0.0),
                            allowScrubbing: true,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          )
        : Container();
  }
}
