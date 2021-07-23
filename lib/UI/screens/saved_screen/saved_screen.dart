import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/UI/screens/video_session_screen/video_details_screen.dart';
import 'package:webapp/bloc/saved_videos_bloc/saved_videos_bloc.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  SavedVideosBloc _savedVideosBloc = SavedVideosBloc();

  @override
  void initState() {
    _savedVideosBloc.add(GetSavedVideos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Videos'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: BlocBuilder(
              bloc: _savedVideosBloc,
              builder: (context, state) {
                if (state is SavedVideosLoaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(state.savedVideos[index].videoTitle),
                          leading: Image.network(
                              state.savedVideos[index].videoThumbnailURL),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VideoDetailsScreen(
                                    state.savedVideos[index].videoId),
                              ),
                            );
                          },
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              tooltip: 'Remove from Saved Videos',
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          content: RemoveSavedVideoDialog(() {
                                            Navigator.of(context).pop();
                                            _savedVideosBloc.add(
                                                RemoveSavedVideo(state
                                                    .savedVideos[index]
                                                    .videoId));
                                          }),
                                        ));
                              }),
                        ),
                      );
                    },
                    itemCount: state.savedVideos.length,
                  );
                } else
                  return CircularProgressIndicator(
                    color: Colors.red,
                  );
              }),
        ),
      ),
    );
  }
}

class RemoveSavedVideoDialog extends StatelessWidget {
  Function onConfirmed;
  RemoveSavedVideoDialog(this.onConfirmed);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Container(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you Sure?',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 8),
            Text('Do you really want to remove this video from saved videos?'),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    color: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: onConfirmed,
                    color: Theme.of(context).accentColor,
                    child: Text('Yes'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
