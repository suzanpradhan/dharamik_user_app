import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/screens/homeScreen/market_trends.dart';
import 'package:webapp/UI/screens/homeScreen/nifty_levels.dart';
import 'package:webapp/UI/screens/homeScreen/segments.dart';
import 'package:webapp/UI/screens/major_news_screen/major_news.dart';
import 'package:webapp/UI/screens/notification_screen/notification_page.dart';
import 'package:webapp/bloc/dashboard_bloc.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/notification_repository.dart';
import 'package:webapp/utils/screen_utils.dart';
import 'package:webapp/utils/service_locator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DashboardBloc _dashboardBloc = DashboardBloc();
  bool isRead = false;

  UserModel user = locator<UserModel>();
  var timer;
  @override
  void initState() {
    _dashboardBloc.add(GetDashboardData());

    // timer = Timer.periodic(Duration(seconds: 2), (Timer t) async {
    //   timer = t;
    //   await getNumberOfNotifications();
    // });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: context.screenWidth, maxHeight: context.screenHeight),
        child: (context.mdWindowSize == MobileWindowSize.xlarge ||
                context.mdWindowSize == MobileWindowSize.large ||
                context.mdWindowSize == MobileWindowSize.medium)
            ?
            //column for large layout
            //expanded to fill remaining space with sidebar
            BlocBuilder<DashboardBloc, DashboardState>(
                bloc: _dashboardBloc,
                builder: (context, state) {
                  if (state is DashboardLoaded)
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(50),
                              ),
                              Expanded(
                                child: Center(
                                  child: NiftyLevels(state
                                      .marketTrendModel.marketTrendPhotoURL),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(40),
                              ),
                              MarketTrends(
                                  state.marketTrendModel.marketTrendText),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(40),
                              ),
                              Center(child: Segments(state.segments)),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(40),
                              ),
                              Container(),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(40),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: kToolbarHeight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Stack(
                                            children: [
                                              if (isRead == true)
                                                Positioned(
                                                  // right: 2,
                                                  left: 14,

                                                  child: Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                              FlatButton.icon(
                                                  label: Text(('Notification')),
                                                  icon:
                                                      Icon(Icons.notifications),
                                                  onPressed: () {
                                                    notificationScreen(context);
                                                    //   timer = Timer.periodic(Duration(seconds: 2), (Timer t)async{
                                                    //
                                                    //     timer = t;
                                                    //     await getNumberOfNotifications();
                                                    //   });
                                                  }),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Major News',
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Expanded(
                                        child: CustomScrollView(
                                      slivers: <Widget>[
                                        SliverToBoxAdapter(child: null),
                                        MajorNews(state.news)
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  else
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                },
              )
            : BlocBuilder<DashboardBloc, DashboardState>(
                bloc: _dashboardBloc,
                builder: (context, state) {
                  if (state is DashboardLoaded)
                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 550),
                        child: CustomScrollView(
                          shrinkWrap: true,
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: context.screenHeight * 0.4),
                                  child: NiftyLevels(state
                                      .marketTrendModel.marketTrendPhotoURL)),
                            ),
                            SliverToBoxAdapter(
                              child: MarketTrends(
                                  state.marketTrendModel.marketTrendText),
                            ),
                            SliverToBoxAdapter(
                              child: Segments(state.segments),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                margin: (context.mdWindowSize ==
                                            MobileWindowSize.small ||
                                        context.mdWindowSize ==
                                            MobileWindowSize.xsmall)
                                    ? EdgeInsets.all(10)
                                    : EdgeInsets.only(left: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Major News',
                                      style: TextStyle(
                                          fontSize: (context.mdWindowSize ==
                                                      MobileWindowSize.large ||
                                                  context.mdWindowSize ==
                                                      MobileWindowSize.xlarge ||
                                                  context.mdWindowSize ==
                                                      MobileWindowSize.medium)
                                              ? 45
                                              : 22,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            MajorNews(state.news),
                          ],
                        ),
                      ),
                    );
                  else
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                },
              ),
      ),
    );
  }

  getNumberOfNotifications() async {
    int a = await NotificationsRepo().getNoNotifications();
    if (a >= 1) {
      setState(() {
        isRead = true;
      });
    } else {
      setState(() {
        isRead = false;
      });
    }

    print('aa $a');
  }
}
