import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/screens/video_session_screen/video_details_screen.dart';
import 'package:webapp/UI/widgets/stack_card.dart';
import 'package:webapp/bloc/video_session_bloc/video_session_bloc.dart';
import 'package:webapp/models/membership_model.dart';
import 'package:webapp/models/video_model.dart';
import 'package:webapp/repositories/videos_repository.dart';
import 'package:webapp/utils/service_locator.dart';

String imagePath = 'images/logo.png';
bool isCollapsed = true;

class VideoSessions extends StatefulWidget {
  @override
  _VideoSessionsState createState() => _VideoSessionsState();
}

class _VideoSessionsState extends State<VideoSessions> {
  VideoSessionBloc _videoSessionBloc = VideoSessionBloc();
  String selectedMembershipId;
  TextEditingController searchController = TextEditingController();

  VideosRepo videosRepo = locator<VideosRepo>();
  List<VideoModel> searchResults = List();
  bool showSearch = false;
  bool _isChipSelected = false;

  @override
  void initState() {
    _videoSessionBloc.add(GetInitialVideos());
    searchController.addListener(() {
      if (searchController.text.isEmpty)
        setState(() {
          searchResults = [];
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: (context.mdWindowSize == MobileWindowSize.large ||
                context.mdWindowSize == MobileWindowSize.xlarge)
            ? const EdgeInsets.all(20.0)
            : const EdgeInsets.all(0.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  Container(
                                    child: Text(
                                      'Start learning \n with our sessions',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              (!showSearch)
                                  ? ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 500),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(45.0)),
                                        child: ListTile(
                                          title: Text('Search Videos'),
                                          trailing: Icon(Icons.search),
                                          onTap: () {
                                            setState(() {
                                              this.showSearch = true;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<VideoSessionBloc, VideoSessionState>(
                  bloc: _videoSessionBloc,
                  builder: (context, state) {
                    if (state is VideoSessionInitial) {
                      return getMembershipsAndVideo(state.memberships,
                          state.videos, state.memberships[0].membershipId);
                    } else if (state is VideosLoaded) {
                      return getMembershipsAndVideo(state.memberships,
                          state.videos, selectedMembershipId);
                    } else
                      return SliverToBoxAdapter(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        )),
                      );
                  },
                ),
                BlocBuilder<VideoSessionBloc, VideoSessionState>(
                  bloc: _videoSessionBloc,
                  builder: (context, state) {
                    if (state is VideoSessionInitial) {
                      return videoItem(context, state.videos);
                    } else if (state is VideosLoaded) {
                      return videoItem(context, state.videos);
                    } else
                      return SliverToBoxAdapter(
                        child: Offstage(),
                      );
                  },
                ),
              ],
            ),
            (showSearch)
                ? Container(
                    height: context.screenHeight,
                    width: context.screenWidth,
                    color: Colors.black54,
                  )
                : Offstage(),
            (showSearch)
                ? Positioned(
                    top: 172,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: (context.screenWidth < 500)
                              ? context.screenWidth - 32
                              : 500),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: Icon(Icons.cancel),
                                  tooltip: 'Close Search',
                                  onPressed: () {
                                    searchResults = [];
                                    searchController.clear();
                                    setState(() {
                                      this.showSearch = false;
                                    });
                                  }),
                            ),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: searchController,
                                  onSubmitted: (value) {
                                    if (value.length > 3) searchVideo(value);
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search),
                                        tooltip: 'Search Video',
                                        onPressed: () {
                                          if (searchController.text.length > 3)
                                            searchVideo(searchController.text);
                                        }),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40.0),
                                      ),
                                    ),
                                    labelText: 'Search for Course',
                                    hoverColor: Colors.white,
                                  ),
                                )),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title:
                                        Text(searchResults[index].videoTitle),
                                    onTap: () {
                                      var id = searchResults[index].videoId;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VideoDetailsScreen(id),
                                        ),
                                      );
                                      searchResults = [];
                                      searchController.clear();
                                      showSearch = false;
                                    },
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  )
                : Offstage(),
          ],
        ),
      ),
    );
  }

  Widget getMembershipsAndVideo(List<MembershipModel> memberships,
      List<VideoModel> videos, String selectedMembership) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Plan categories',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              actionCategoryItem(context, memberships, selectedMembership)
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Video Lectures',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }

  actionCategoryItem(BuildContext context, List<MembershipModel> memberships,
      String selectedMembership) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: memberships.length,
        itemBuilder: (context, index) {
          return RaisedButton(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            color: Colors.white,
            hoverColor: Colors.red,
            elevation: (_isChipSelected) ? 5.0 : 1.0,
            onPressed: () {
              setState(() {
                _isChipSelected = !_isChipSelected;
              });
              selectedMembershipId = memberships[index].membershipId;
              _videoSessionBloc.add(GetMembershipVideos(selectedMembershipId));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              height: 50,
              child: Text(
                memberships[index].membershipName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );

          // ChoiceChip(
          //   tooltip: 'tool tip',
          //   shadowColor: Colors.white,
          //   selectedShadowColor: Colors.red,
          //   elevation: 8.0,
          //   pressElevation: 8.0,
          //   autofocus: true,
          //   materialTapTargetSize: MaterialTapTargetSize.padded,
          //   backgroundColor: Colors.white,
          //   selectedColor: Colors.red[500],
          //   onSelected: (isSelected) {
          //     if (isSelected) {}
          //   },
          //   //Theme.of(context).accentColor,
          //   label: Container(
          //     alignment: Alignment.center,
          //     height: 50,
          //     child: Text(
          //       memberships[index].membershipName,
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 18.0,
          //         fontWeight:
          //             (_isChipSelected) ? FontWeight.w900 : FontWeight.normal,
          //       ),
          //     ),
          //   ),

          //   selected: memberships[index].membershipId == selectedMembership,
          // );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10,
          );
        },
      ),
    );
  }

  _getMaxCrossAxisExtent() {
    if (context.mdWindowSize == MobileDeviceSize.small ||
        context.mdWindowSize == MobileWindowSize.xsmall) {
      return 210.0;
    } else {
      return 320.0;
    }
  }

  _getScreenAspectRatio() {
    if (context.mdWindowSize == MobileDeviceSize.small ||
        context.mdWindowSize == MobileWindowSize.xsmall) {
      return 1.5;
    } else {
      return 1.6;
    }
  }

  _getCrossAxisSpacing() {
    if (context.mdWindowSize == MobileDeviceSize.small ||
        context.mdWindowSize == MobileWindowSize.xsmall) {
      return 1.0;
    } else {
      return 2.0;
    }
  }

  _getMainAxisSpacing() {
    if (context.mdWindowSize == MobileDeviceSize.small ||
        context.mdWindowSize == MobileWindowSize.xsmall) {
      return 1.0;
    } else {
      return 1.922;
    }
  }

  videoItem(BuildContext context, List<VideoModel> videos) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: _getMaxCrossAxisExtent(),
        mainAxisSpacing: _getMainAxisSpacing(),
        crossAxisSpacing: _getCrossAxisSpacing(),
        childAspectRatio: _getScreenAspectRatio(),
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: VideoStackCard(
              cardText: videos[index].videoTitle,
              imagePath: videos[index].videoThumbnailURL,
              rating: videos[index].videoRating,
              duration: videos[index].videoDuration,
              discText: videos[index].videoDesc,
              playButton: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoDetailsScreen(videos[index].videoId),
                  ),
                );
              },
            ),
          );
        },
        childCount: videos.length,
      ),
    );
  }

  Future searchVideo(String query) async {
    try {
      searchResults = await videosRepo.searchVideo(query);
      setState(() {});
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
