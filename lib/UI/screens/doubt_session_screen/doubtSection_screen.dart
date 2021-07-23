import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/screens/doubt_session_screen/ask_doubt_dialog.dart';
import 'package:webapp/UI/screens/doubt_session_screen/doubt_details_screen.dart';
import 'package:webapp/bloc/common_doubts_bloc/common_doubts_bloc.dart';

class DoubtSection extends StatelessWidget {
  CommonDoubtsBloc _commonDoubtsBloc = CommonDoubtsBloc();
  @override
  Widget build(BuildContext context) {
    _commonDoubtsBloc.add(GetInitialCommonDoubts());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (context.mdWindowSize == MobileWindowSize.xlarge ||
                    context.mdWindowSize == MobileWindowSize.large ||
                    context.mdWindowSize == MobileWindowSize.medium)
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, left: 32, right: 32, bottom: 64),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => AskDoubtDialog(),
                        ));
                      },
                      child: Container(
                        height: 200,
                        width: 410,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: (context.mdWindowSize ==
                                    MobileWindowSize.xsmall)
                                ? BorderRadius.circular(20)
                                : BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              'Raise your doubt !',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: (context.mdWindowSize ==
                                          MobileWindowSize.xsmall)
                                      ? 25
                                      : 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image(
                              image: AssetImage('images/logo.png'),
                              width: 100.0,
                              height: 100.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  !(context.mdWindowSize == MobileWindowSize.xlarge ||
                          context.mdWindowSize == MobileWindowSize.large ||
                          context.mdWindowSize == MobileWindowSize.medium)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, left: 32, right: 32, bottom: 64),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => AskDoubtDialog(),
                              ));
                            },
                            child: Container(
                              height: 200,
                              width: 410,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: (context.mdWindowSize ==
                                          MobileWindowSize.xsmall)
                                      ? BorderRadius.circular(20)
                                      : BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Raise your doubt !',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: (context.mdWindowSize ==
                                                MobileWindowSize.xsmall)
                                            ? 25
                                            : 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image(
                                    image: AssetImage('images/logo.png'),
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                  Container(
                    child: (context.mdWindowSize == MobileWindowSize.xlarge ||
                            context.mdWindowSize == MobileWindowSize.large ||
                            context.mdWindowSize == MobileWindowSize.medium)
                        ? Text(
                            'Common Doubts',
                            style: TextStyle(color: Colors.white, fontSize: 42),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Common Doubts',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                  BlocBuilder<CommonDoubtsBloc, CommonDoubtsState>(
                    bloc: _commonDoubtsBloc,
                    builder: (context, state) {
                      if (state is CommonDoubtsLoaded)
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.commonDoubts.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expandable(
                                  primaryWidget: Container(
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                          state.commonDoubts[index].doubtTitle),
                                    ),
                                  ),
                                  secondaryWidget: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: state.commonDoubts[index]
                                                      .imageAttachmentURL !=
                                                  null
                                              ? Image(
                                                  image: NetworkImage(state
                                                      .commonDoubts[index]
                                                      .imageAttachmentURL))
                                              : Container(),
                                          title: Text(state
                                              .commonDoubts[index].doubtTitle),
                                          trailing: InkWell(
                                              child: Text('Detail'
                                                  // Icons.arrow_forward_ios,
                                                  // size: 15,
                                                  ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DoubtDetailsScreen(
                                                                state.commonDoubts[
                                                                    index])));
                                              }),
                                        ),
                                        Container(
                                          child: Text(
                                            'Admin Reply',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        ListTile(
                                          leading: state
                                                      .commonDoubts[index]
                                                      .reply
                                                      .imageAttachmentURL !=
                                                  null
                                              ? Image(
                                                  image: NetworkImage(state
                                                      .commonDoubts[index]
                                                      .reply
                                                      .imageAttachmentURL))
                                              : Container(),
                                          title: Text(state.commonDoubts[index]
                                              .reply.doubtTitle),
                                          trailing: InkWell(
                                              child: Text('Detail'
                                                  // Icons.arrow_forward_ios,
                                                  // size: 15,
                                                  ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DoubtDetailsScreen(
                                                                state
                                                                    .commonDoubts[
                                                                        index]
                                                                    .reply)));
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  showArrowIcon: true,
                                  centralizePrimaryWidget: true,
                                  isClickable: true,
                                  padding: EdgeInsets.all(5.0),
                                ),
                              );
                            });
                      else
                        return Container(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.red,
                          )),
                        );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
