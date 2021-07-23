import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/screens/contact/contact_us.dart';
import 'package:webapp/UI/screens/doubt_session_screen/doubtSection_screen.dart';
import 'package:webapp/UI/screens/homeScreen/home_page.dart';
import 'package:webapp/UI/screens/major_news_screen/major_news.dart';
import 'package:webapp/UI/screens/notification_screen/notification_page.dart';
import 'package:webapp/UI/screens/premium_signal_screen/premium_signals.dart';
import 'package:webapp/UI/screens/premium_signal_screen/watermark.dart';
import 'package:webapp/UI/screens/profile_screen/profile_page.dart';
import 'package:webapp/UI/screens/video_session_screen/video_sessions.dart';
import 'package:webapp/UI/widgets/custom_buttons.dart';
import 'package:webapp/models/bug_model.dart';
import 'package:webapp/models/membership_model.dart';
import 'package:webapp/models/premium_signal_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/bug_repository.dart';
import 'package:webapp/repositories/membership_repository.dart';
import 'package:webapp/repositories/notification_repository.dart';
import 'package:webapp/repositories/premium_signals_repository.dart';
import 'package:webapp/services/alerts_service.dart';
import 'package:webapp/utils/service_locator.dart';

class MainPage extends StatefulWidget {
  static const String route = '/home';
  MainPage();
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _alertBoxFieldController = TextEditingController();
  bool isDropDownOpen = false;
  UserModel user = locator<UserModel>();

  bool isCollapsed = true;
  double containerWidth;

  String userMembership = '';

  int signalCount = 0;

  MainScreenModel selectedWidget;
  bool isRead = false;
  var timer;

  @override
  void initState() {
    selectedWidget =
        MainScreenModel(appBarTitle: 'Market Updates', widget: HomePage());
    isCollapsed = false;
    containerWidth = 250;

    locator.registerSingleton(AlertsService());
    getUserMembership();
    getNumberOfNotifications();
    super.initState();
  }

  getUserMembership() async {
    if (user != null && user.membershipId != null) {
      List<MembershipModel> memberships =
          await MembershipsRepo().getMemberships();

      userMembership = memberships
          .firstWhere((element) => element.membershipId == user.membershipId)
          .membershipName;
      setState(() {});

      Timer.periodic(Duration(seconds: 2), (Timer t) async {
        timer = t;

        print('timer running');

        List<PremiumSignalModel> signals = await PremiumSignalsRepo()
            .getPremiumSignalsByTime(user.lastSignalViewed);
        signalCount = signals.length;
        print("herrrrrrrrrrrrrrrrrrrrrrrr" + signalCount.toString());
        setState(() {});
        await getNumberOfNotifications();

        if (this.mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (context.mdWindowSize == MobileWindowSize.xsmall ||
              context.mdWindowSize == MobileWindowSize.small)
          ? Stack(
              children: [
                FloatingActionButton(
                    elevation: 0,
                    mini: (context.mdWindowSize == MobileWindowSize.xsmall)
                        ? true
                        : false,
                    backgroundColor: Colors.red,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.5),
                        child: Image(
                          image: AssetImage('images/logo.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedWidget = MainScreenModel(
                            appBarTitle: 'Premium Signals',
                            widget: PremiumSignals(
                              user: user,
                            ));
                      });
                    }),
                if (signalCount != 0)
                  Positioned(
                    // right: 2,
                    right: 8,
                    top: 4,

                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: (context.mdWindowSize == MobileWindowSize.xsmall ||
              context.mdWindowSize == MobileWindowSize.small)
          ? getBottomBar()
          : null,
      appBar: (context.mdWindowSize == MobileWindowSize.xsmall ||
              context.mdWindowSize == MobileWindowSize.small)
          ? AppBar(
              backgroundColor: Colors.transparent,
              title: (context.mdWindowSize == MobileWindowSize.xsmall ||
                      context.mdWindowSize == MobileWindowSize.small)
                  ? Text(
                      selectedWidget.appBarTitle,
                      style: TextStyle(
                          fontSize:
                              (context.mdWindowSize == MobileWindowSize.xsmall)
                                  ? 19
                                  : 24),
                    )
                  : Container(),
              centerTitle: false,
              actions: <Widget>[
                (context.mdWindowSize == MobileWindowSize.xsmall ||
                        context.mdWindowSize == MobileWindowSize.small)
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            this.selectedWidget = MainScreenModel(
                                appBarTitle: 'Profile', widget: ProfilePage());
                          });
                        },
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('images/profileIcon.png'),
                              height: 25.0,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  width: 30,
                ),
                (context.mdWindowSize == MobileWindowSize.xsmall ||
                        context.mdWindowSize == MobileWindowSize.small)
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          notificationScreen(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.notifications),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Notifications',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  width: 40,
                ),
                (context.mdWindowSize == MobileWindowSize.xsmall ||
                        context.mdWindowSize == MobileWindowSize.small)
                    ? Stack(
                        children: [
                          if (isRead == true)
                            Positioned(
                              // right: 2,
                              left: 10,
                              top: 4,

                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              notificationScreen(context);
                            },
                          ),
                        ],
                      )
                    : Container()
              ],
            )
          : null,
      body: Row(
        children: <Widget>[
          (context.mdWindowSize == MobileWindowSize.xlarge ||
                  context.mdWindowSize == MobileWindowSize.large ||
                  context.mdWindowSize == MobileWindowSize.medium)
              ? getCollapsingSideBar()
              : Container(),
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: (context.mdWindowSize == MobileWindowSize.xlarge ||
                          context.mdWindowSize == MobileWindowSize.large ||
                          context.mdWindowSize == MobileWindowSize.medium)
                      ? context.screenWidth - containerWidth
                      : context.screenWidth),
              child: selectedWidget.widget),
        ],
      ),
    );
  }

  Widget getBottomBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: BottomAppBar(
        elevation: 5.0,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    this.selectedWidget = MainScreenModel(
                        appBarTitle: 'Market Updates', widget: HomePage());
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Image(
                    image: AssetImage('images/dashboardIcon.png'),
                    height: 25.0,
                    color: (selectedWidget.appBarTitle == 'Market Updates')
                        ? Theme.of(context).accentColor
                        : Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    this.selectedWidget = MainScreenModel(
                        appBarTitle: 'News', widget: MajorNewsScreen());
                  });
                },
                child: Image(
                  image: AssetImage('images/newsIcon.png'),
                  height: 24.0,
                  color: (selectedWidget.appBarTitle == 'News')
                      ? Theme.of(context).accentColor
                      : Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    this.selectedWidget = MainScreenModel(
                        appBarTitle: 'Videos', widget: VideoSessions());
                  });
                },
                child: Image(
                  image: AssetImage('images/videoIcon.png'),
                  height: 26.0,
                  width: 28.0,
                  color: (selectedWidget.appBarTitle == 'Videos')
                      ? Theme.of(context).accentColor
                      : Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    this.selectedWidget = MainScreenModel(
                        appBarTitle: 'Profile', widget: ProfilePage());
                  });
                },
                child: Image(
                  image: AssetImage('images/profileIcon.png'),
                  height: 25.0,
                  color: (selectedWidget.appBarTitle == 'Profile')
                      ? Theme.of(context).accentColor
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCollapsingSideBar() {
    (isCollapsed) ? containerWidth = 80 : containerWidth = 200;
    return AnimatedContainer(
      width: containerWidth,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.only(
          topRight: (isCollapsed == true)
              ? Radius.circular(70.0)
              : Radius.circular(0.0),
          bottomRight: (isCollapsed == true)
              ? Radius.circular(70)
              : Radius.circular(0.0),
        ),
      ),
      duration: Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
      child: ListView(
        //physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              (isCollapsed == false)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 45.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            this.selectedWidget = MainScreenModel(
                                appBarTitle: 'Profile', widget: ProfilePage());
                          });
                        },
                        child: Container(
                          // height: 175,
                          // width: 175,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(1.0, 6.0),
                                  blurRadius: 25.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              user.userPhotoURL != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(user.userPhotoURL),
                                      radius: 60,
                                      backgroundColor: Colors.red,
                                    )
                                  : Container(),
                              SizedBox(
                                width: 22.0,
                              ),
                              Text(
                                user.userName.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                userMembership,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 40.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.userPhotoURL),
                        radius: 30,
                        backgroundColor: Colors.red,
                      ),
                    ),
              SizedBox(
                height: 40.0,
              ),
              getNavigationContent(),
              SizedBox(
                height: 25.0,
              ),
              FlatButton(
                child: Icon(
                  (isCollapsed == true)
                      ? Icons.arrow_forward_ios
                      : Icons.arrow_back_ios,
                ),
                onPressed: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getNavigationContent() {
    List<Map> _navigationItems = [
      (context.mdWindowSize == MobileWindowSize.xsmall ||
              context.mdWindowSize == MobileWindowSize.small)
          ? {'buttonText': ''}
          : {
              'iconPath': 'images/dashboardIcon.png',
              'icon': Icons.dashboard,
              'iconColor': (context.mdWindowSize == MobileWindowSize.xsmall ||
                      context.mdWindowSize == MobileWindowSize.small)
                  ? Colors.black
                  : Colors.grey.shade500,
              'textColor': Colors.white,
              'signalCount': 0,
              'buttonText': 'Home',
              'onPressed': () {
                setState(() {
                  this.selectedWidget = MainScreenModel(
                      appBarTitle: 'Market Updates', widget: HomePage());
                });
              }
            },
      (context.mdWindowSize == MobileWindowSize.xsmall ||
              context.mdWindowSize == MobileWindowSize.small)
          ? {'buttonText': ''}
          : {
              'iconPath': 'images/newsIcon.png',
              'icon': Icons.new_releases,
              'iconColor': (context.mdWindowSize == MobileWindowSize.xsmall ||
                      context.mdWindowSize == MobileWindowSize.small)
                  ? Colors.black
                  : Colors.grey.shade500,
              'textColor': Colors.white,
              'buttonText': 'Major News',
              'signalCount': 0,
              'onPressed': () {
                setState(() {
                  this.selectedWidget = MainScreenModel(
                      appBarTitle: 'News', widget: MajorNewsScreen());
                });
              }
            },
      (context.mdWindowSize == MobileWindowSize.xsmall ||
              context.mdWindowSize == MobileWindowSize.small)
          ? {'buttonText': ''}
          : {
              'iconPath': 'images/premiumIcon.png',
              'icon': Icons.graphic_eq,
              'iconColor': (context.mdWindowSize == MobileWindowSize.xsmall ||
                      context.mdWindowSize == MobileWindowSize.small)
                  ? Colors.black
                  : Colors.grey.shade500,
              'textColor': Colors.white,
              'buttonText': 'Premium Signals',
              'signalCount': signalCount,
              'onPressed': () {
                setState(() {
                  this.selectedWidget = MainScreenModel(
                      appBarTitle: 'Premium Signals',
                      widget: PremiumSignals(
                        user: user,
                      ));
                });
              }
            },
      (context.mdWindowSize == MobileWindowSize.xsmall ||
              context.mdWindowSize == MobileWindowSize.small)
          ? {'buttonText': ''}
          : {
              'iconPath': 'images/videoIcon.png',
              'icon': Icons.videocam,
              'iconColor': (context.mdWindowSize == MobileWindowSize.xsmall ||
                      context.mdWindowSize == MobileWindowSize.small)
                  ? Colors.black
                  : Colors.grey.shade500,
              'textColor': Colors.white,
              'buttonText': 'Video Session',
              'signalCount': 0,
              'onPressed': () {
                setState(() {
                  this.selectedWidget = MainScreenModel(
                      appBarTitle: 'Videos', widget: VideoSessions());
                });
              }
            },
      {
        'iconPath': 'images/contactIcon.png',
        'icon': Icons.phone,
        'iconColor': (context.mdWindowSize == MobileWindowSize.xsmall ||
                context.mdWindowSize == MobileWindowSize.small)
            ? Colors.black
            : Colors.grey.shade500,
        'textColor': Colors.white,
        'buttonText': 'Contact Us',
        'signalCount': 0,
        'onPressed': () {
          print('i am pressed');
          this.selectedWidget =
              MainScreenModel(appBarTitle: 'Contact Us', widget: ContactPage());
          setState(() {});
        },
      },
      {
        'iconPath': 'images/helpSupportIcon.png',
        'icon': Icons.live_help,
        'iconColor': (context.mdWindowSize == MobileWindowSize.xsmall ||
                context.mdWindowSize == MobileWindowSize.small)
            ? Colors.black
            : Colors.grey.shade500,
        'textColor': Colors.white,
        'signalCount': 0,
        'buttonText': 'Help and Support',
        'onPressed': () {
          setState(() {
            this.selectedWidget = MainScreenModel(
                appBarTitle: 'Common Doubts', widget: DoubtSection());
          });
        },
      },
      {
        'iconPath': 'images/reportIcon.png',
        'icon': Icons.error,
        'iconColor': (context.mdWindowSize == MobileWindowSize.xsmall ||
                context.mdWindowSize == MobileWindowSize.small)
            ? Colors.black
            : Colors.grey.shade500,
        'textColor': Colors.white,
        'buttonText': 'Report a bug',
        'signalCount': 0,
        'onPressed': () {
          TextEditingController title = TextEditingController();
          TextEditingController desc = TextEditingController();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Report a Bug'),
                content: Container(
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        controller: title,
                        decoration: InputDecoration(hintText: 'Bug Title'),
                      ),
                      TextField(
                        decoration:
                            InputDecoration(hintText: 'Bug Description'),
                        controller: desc,
                        maxLines: 10,
                        minLines: 1,
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print(title.text);
                      print(desc.text);

                      if (title.text != null &&
                          title.text != "" &&
                          desc.text != null &&
                          desc.text != "") {
                        Navigator.of(context).pop();
                        await BugRepository.addNewBug(
                            BugModel(null, title.text, desc.text));
                        Fluttertoast.showToast(
                            msg: 'Bug Reported Successfully');
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Both fields are mandatory.');
                      }
                    },
                    child: Text('Report'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ],
              );
            },
          );
        },
      },
      (context.mdWindowSize == MobileWindowSize.xsmall ||
              context.mdWindowSize == MobileWindowSize.small)
          ? {'buttonText': ''}
          : {
              'iconPath': 'images/profileIcon.png',
              'icon': Icons.videocam,
              'iconColor': (context.mdWindowSize == MobileWindowSize.xsmall ||
                      context.mdWindowSize == MobileWindowSize.small)
                  ? Colors.black
                  : Colors.grey.shade500,
              'textColor': Colors.white,
              'buttonText': 'Profile',
              'signalCount': 0,
              'onPressed': () {
                setState(() {
                  this.selectedWidget = MainScreenModel(
                      appBarTitle: 'Profile',
                      widget: ProfilePage(membership: userMembership));
                });
              }
            },
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,

      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround, //for bottomSpacing
      children: <Widget>[
        (isCollapsed == true)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    _navigationItems.length,
                    (index) => Column(
                          children: [
                            SizedBox(
                              height: 55.0,
                            ),
                            GestureDetector(
                              onTap: _navigationItems[index]['onPressed'],
                              child: Image(
                                height: 25.0,
                                width: 80.0,
                                image: AssetImage(
                                  _navigationItems[index]['iconPath']
                                      .toString(),
                                ),
                              ),
                            ),
                          ],
                        )))
            : Column(
                children: List.generate(
                  _navigationItems.length,
                  (index) => Column(
                    children: [
                      (context.mdWindowSize == MobileWindowSize.xlarge ||
                              context.mdWindowSize == MobileWindowSize.large ||
                              context.mdWindowSize == MobileWindowSize.medium)
                          ? SizedBox(
                              height: 30.0,
                            )
                          : Container(),
                      CustomButton(
                        iconPath: _navigationItems[index]['iconPath'],
                        //icon: null,
                        iconColor: _navigationItems[index]['iconColor'],
                        textColor: (isCollapsed == true)
                            ? null
                            : _navigationItems[index]['textColor'],
                        buttonText: (isCollapsed == true)
                            ? ''
                            : _navigationItems[index]['buttonText'].toString(),
                        signalCount:
                            _navigationItems[index]['signalCount'] ?? 0,
                        onPressed: _navigationItems[index]['onPressed'],
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  getNumberOfNotifications() async {
    int a = await NotificationsRepo().getNoNotifications();
    if (a == 1) {
      if (this.mounted) {
        setState(() {
          isRead = true;
        });
      }
    } else {
      if (this.mounted) {
        setState(() {
          isRead = false;
        });
      }
    }

    print('aa $a');
  }
}

class MainScreenModel {
  String appBarTitle;
  Widget widget;
  MainScreenModel({this.appBarTitle, this.widget});
}
