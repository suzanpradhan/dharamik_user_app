import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/models/segment_model.dart';

class Segments extends StatefulWidget {
  final List<SegmentModel> segments;
  Segments(this.segments);
  @override
  _SegmentsState createState() => _SegmentsState();
}

class _SegmentsState extends State<Segments> {
  List<SegmentModel> segments;
  @override
  void initState() {
    this.segments = widget.segments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (context.mdWindowSize == MobileWindowSize.small ||
              context.mdWindowSize == MobileWindowSize.xsmall)
          ? EdgeInsets.all(10.0)
          : EdgeInsets.only(left: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Segments',
            style: TextStyle(
                fontSize: (context.mdWindowSize == MobileWindowSize.large ||
                        context.mdWindowSize == MobileWindowSize.xlarge ||
                        context.mdWindowSize == MobileWindowSize.medium)
                    ? 35
                    : 22,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            height:
                (context.mdWindowSize == MobileWindowSize.xsmall) ? 45.0 : 55,
            //ScreenUtil.getInstance().setHeight(128),
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 24);
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: segments.length,
              itemBuilder: (context, index) {
                return ActionSegments(
                  onPressed: () {
                    return ActionSegmentsBottomsheet(context, segments[index]);
                  },
                  text: segments[index].segmentName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActionSegments extends StatelessWidget {
  const ActionSegments({this.onPressed, this.text});
  final Function onPressed;

  final String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      hoverColor: Colors.white,
      color: Colors.red,
      onPressed: onPressed,
      child: Container(
        width: 135,
        height: 100,
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(32),
          color: Colors.transparent,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.black),
        )),
      ),
    );
  }
}

ActionSegmentsBottomsheet(BuildContext context, SegmentModel model) {
  Navigator.of(context).push(
    MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Segment(
              model: model,
            )),
  );
}

// Container buildSegment(BuildContext context, SegmentModel model) {
//   return
// }

class Segment extends StatelessWidget {
  final SegmentModel model;
  Segment({this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(model.segmentName),
      ),
      body: Container(
        alignment: Alignment.center,
        // padding: EdgeInsets.all(35),
        decoration: BoxDecoration(color: Colors.black),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // IconButton(
              //     icon: Icon(Icons.close),
              //     onPressed: () {
              //       Navigator.pop(context);
              //     }),
              // SizedBox(
              //   height: 40,
              // ),
              // Text(
              //   model.segmentName,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 25,
              //     fontWeight: FontWeight.w900,
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Card(
                  elevation: 8.0,
                  shadowColor: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 35.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: model.segmentPhotoURL != null
                        ? Image.network(
                            model.segmentPhotoURL,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  model.segmentText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
