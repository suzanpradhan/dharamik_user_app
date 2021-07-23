// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/screens/contact/contact_us.dart';
import 'package:webapp/UI/screens/onboard_screen/login_page.dart';
import 'package:webapp/UI/screens/saved_screen/saved_screen.dart';
import 'package:webapp/UI/widgets/loading_dialog.dart';

import 'package:webapp/UI/widgets/memberships_card.dart';
import 'package:webapp/models/membership_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/membership_repository.dart';
import 'package:webapp/repositories/razor_pay_repo.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/services/login_service.dart';
import 'package:webapp/utils/service_locator.dart';
import '../../widgets/memberships_card.dart';
import '../doubt_session_screen/doubtSection_screen.dart';

List<Map> premiumCardData = [
  {
    'cardName': 'Premium Membership',
    'cardRecommendation': 'Recommended For Equity Traders',
    'cardDiscription':
        'Duration for Premium Membership is 6 months. Lifetime Support from Our Tainers',
    'cardPrice': 18495,
    'onOffer': true
  },
  {
    'cardName': 'Platinum Membership',
    'cardRecommendation':
        'Recommended For All Segment Tyoe Traders Including Equity, Futurer ,Options & Commodities ',
    'cardDiscription':
        'Starting your own Business in Forex Signal , Work with Dharamik Opportunities',
    'cardPrice': 40495,
    'onOffer': true
  },
];

class ProfilePage extends StatelessWidget {
  final String membership;

  UserModel user = locator<UserModel>();
  ProfilePage({Key key, this.membership}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(context.mdWindowSize);

    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            ProfileWidgets(
              user: user,
              userMembership: membership,
            ),
            (context.mdWindowSize == MobileWindowSize.xsmall ||
                    context.mdWindowSize == MobileWindowSize.small)
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/logo.png'),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text('Dharamik', style: TextStyle(fontSize: 21)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text('Terms Condition',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                          ),
                          Text(' | ',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey)),
                          GestureDetector(
                            onTap: () {},
                            child: Text('Privacy Policy',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ));
  }
}

class ProfileWidgets extends StatefulWidget {
  const ProfileWidgets(
      {Key key, @required this.user, @required this.userMembership})
      : super(key: key);

  final UserModel user;
  final String userMembership;

  @override
  _ProfileWidgetsState createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {
  List<MembershipModel> memberships = [];
  List<Map> _listBuider;
  bool isImageLoading = false;
  Uint8List imageBytes;
  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    getMemberships();
    super.initState();
  }

  getMemberships() async {
    if (this.mounted) {
      setState(() {
        load = true;
      });
    }

    memberships = await MembershipsRepo().getMemberships();

    print('memebershipts');

    print(memberships);

    print(widget.user.membershipId);
    MembershipModel myMembership;
    try {
      if (widget.user.membershipId != null) {
        myMembership = memberships.firstWhere(
            (element) => element.membershipId == widget.user.membershipId);
      }

      if (myMembership != null) {
        //filter memberships
        print(myMembership.level);
        memberships = memberships
            .where((element) => element.level < myMembership.level)
            .toList();
        print(memberships);
      }
    } catch (e) {
      print(e);
    }
    print('my membership');

    print(myMembership);

    if (this.mounted) {
      setState(() {
        load = false;
      });
    }

    _listBuider = [
      // {
      //   'icon': FontAwesomeIcons.addressCard,
      //   'iconColor': Colors.red,
      //   'title': '${myMembership?.membershipName??"Premium Membership"}',
      //   'subtitle': 'BUY/UPGRADE Membership',
      //   'textColor': Colors.black,
      //   'onPressed': () {
      //     premiumBottomSheet(context,memberships);
      //   },
      // },
      {
        'icon': FontAwesomeIcons.save,
        'iconColor': Colors.red,
        'title': 'Saved',
        'subtitle': 'Saved Content',
        'textColor': Colors.black,
        'onPressed': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SavedScreen();
          }));
        },
      },
      {
        'icon': FontAwesomeIcons.building,
        'iconColor': Colors.red,
        'title': 'Contact Us',
        'subtitle': 'Get in touch with us',
        'textColor': Colors.black,
        'onPressed': () {
          // this.selectedWidget = MainScreenModel(
          //     appBarTitle: 'Contact Us', widget: ContactPage());
          // setState(() {
          //
          // });
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactPage();
          }));
        },
      },
      {
        'icon': FontAwesomeIcons.question,
        'iconColor': Colors.red,
        'title': 'Doubt Section',
        'subtitle': 'Ask Question get answer',
        'textColor': Colors.black,
        'onPressed': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DoubtSection();
          }));
        },
      },
      {
        'icon': FontAwesomeIcons.lock,
        'iconColor': Colors.red,
        'title': 'Privacy Policy',
        'subtitle': 'See How we manage your data',
        'textColor': Colors.black,
        'onPressed': () {
          launch('https://www.dharamik.com/tnc/');
        },
      },
      {
        'icon': Icons.account_balance_wallet,
        'iconColor': Colors.red,
        'title': 'Terms and Condition',
        'subtitle': 'Get through our Terms and Contditions',
        'textColor': Colors.black,
        'onPressed': () {
          launch('https://www.dharamik.com/tnc/');
        },
      },
      {
        'icon': Icons.exit_to_app,
        'iconColor': Colors.red,
        'title': 'Sign Out',
        'subtitle': '',
        'textColor': Colors.black,
        'onPressed': () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    content: ConfirmSignOutDialog(
                      onConfirmPressed: () async {
                        await locator<LoginService>().signOut();
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                    ),
                  ));
        },
      },
    ];
  }

  Future<File> chooseImage() async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);

    File file = File(pickedFile.path);

    // var file = await ImagePickerWeb.getImage(outputType: ImageType.file);
    if (file != null) {
      // showDialog(context: context, builder: (context) => LoadingDialog());

      // ImagePicker picker = ImagePicker();
      // PickedFile pickedFile =
      //     await picker.getImage(source: ImageSource.gallery);
      pickedFile.readAsBytes().then((value) {
        imageBytes = value;
        // Navigator.of(context).pop();
        setState(() {});
      });
      File file = File(pickedFile.path);
      return file;

      // final FileReader reader = new FileReader();
      // Uint8List uintlist;
      // reader.onLoad.listen((e) {
      //   uintlist = new Uint8List.fromList(reader.result);
      //   imageBytes = uintlist;
      //   // Navigator.of(context).pop();
      //   setState(() {});
      // });
      // reader.readAsArrayBuffer(file);
      // return file;
    }
  }

  uploadImage() async {
    var file = await chooseImage().then((value) async {
      if (value != null) {
        if (this.mounted) {
          setState(() {
            isImageLoading = true;
          });
        }

        await UserRepository().uploadUserImage(value).then((imageUrl) {
          if (imageUrl != null) {
            print("here1");
            if (this.mounted) {
              setState(() {
                widget.user.userPhotoURL = imageUrl;
                isImageLoading = false;
              });
            }

            UserRepository().updateUserDataOnDatabase(widget.user);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.red,
          ))
        : Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              //Top Bizzcard
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          top: 40, left: 10.0, right: 10.0, bottom: 10.0),
                      margin: EdgeInsets.only(
                          top: 40.0, right: 10.0, left: 10.0, bottom: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(
                              (context.mdWindowSize == MobileWindowSize.xsmall)
                                  ? 10
                                  : 20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            children: [
                              SizedBox(
                                height: 21.0,
                              ),
                              InkWell(
                                onTap: () {
                                  uploadImage();
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.edit),
                                      Text("Edit Profile Photo")
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                widget.user.userName.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: (context.mdWindowSize ==
                                            MobileWindowSize.xsmall)
                                        ? 19
                                        : 25),
                              ),
                              Text(
                                'User Name',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      widget.user.userEmail,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: (context.mdWindowSize ==
                                                  MobileWindowSize.xsmall)
                                              ? 16
                                              : 20),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                      SizedBox(width: 4),
                                      (widget.user.emailVerified != null &&
                                              !widget.user.emailVerified)
                                          ? FlatButton(
                                              onPressed: () async {
                                                await locator<LoginService>()
                                                    .sendVerificationEmail(
                                                        widget.user.userId);
                                                Flushbar(
                                                  message:
                                                      'Verification Email Sent to ${widget.user.userEmail}',
                                                  margin: EdgeInsets.all(8),
                                                  borderRadius: 8,
                                                  maxWidth: 500,
                                                  duration:
                                                      Duration(seconds: 2),
                                                )..show(context);
                                              },
                                              child: Text(
                                                'Verify',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ))
                                          : Offstage()
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  // Text(
                                  //   (widget.user.userPhoneNumber.toString() == 'null')
                                  //       ? 'Not Linked'
                                  //       : widget.user.userPhoneNumber.toString(),
                                  //   //'1234567890',
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: (context.mdWindowSize ==
                                  //               MobileWindowSize.xsmall)
                                  //           ? 16
                                  //           : 25),
                                  // ),

                                  Text(
                                    '${widget.userMembership ?? ''}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: (context.mdWindowSize ==
                                                MobileWindowSize.xsmall)
                                            ? 10
                                            : 12),
                                  ),
                                  Text(
                                    'Membership',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    isImageLoading
                        ? CircleAvatar(
                            radius: 45,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            ),
                            backgroundColor: Colors.red,
                          )
                        : CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                                widget.user.userPhotoURL.toString()),
                            backgroundColor: Colors.red,
                          ),
                  ],
                ),
              ),

              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                      _listBuider.length,
                      (index) => Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 500),
                              child: CustomListTile(
                                onPressed: _listBuider[index]['onPressed'],
                                icon: _listBuider[index]['icon'],
                                iconColor: _listBuider[index]['iconColor'],
                                title: _listBuider[index]['title'].toString(),
                                subTitle:
                                    _listBuider[index]['subtitle'].toString(),
                              ),
                            ),
                          )))
            ],
          );
  }
}

//memberShip card builder
premiumBottomSheet(BuildContext context, List<MembershipModel> memberships) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => premiumCards(context, memberships));
}

Container premiumCards(
    BuildContext context, List<MembershipModel> memberships) {
  return Container(
      padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 11),
      color: Colors.black54,
      child: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                height: 30,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400.0),
                child: Text(
                  'Get VIP Signals,\nPremium video, sessions and much more',
                  style: TextStyle(color: Colors.white, fontSize: 27),
                ),
              ),
              for (int i = 0; i < memberships.length; i++)
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  width: 430,
                  child: MemberShipCard(
                    cardName: memberships[i].membershipName,
                    cardRecommendation: '',
                    cardDiscription:
                        'Starting your own Business in Forex Signal , Work with Dharamik Opportunities',
                    cardPrice: memberships[i].price,
                    onOffer: true,
                    callback: () async {
                      UserModel user =
                          await UserRepository().getCurrentUserFromDatabase();

                      RazorPayRepository.setCallbacks((success) async {
                        user.membershipId = memberships[i].membershipId;
                        await UserRepository().updateUserDataOnDatabase(user);
                      }, (error) {
                        print(error);
                      }, (resp) {
                        print(resp);
                      });

                      RazorPayRepository.makePayment(
                          memberships[i].price, memberships[i], user);
                    },
                  ),
                ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: () {
                    print('support');
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.leaf,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Support',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {this.icon, this.subTitle, this.title, this.iconColor, this.onPressed});
  final IconData icon;
  final String title;
  final String subTitle;
  final Color iconColor;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child: Text(title)),
        ],
      ),
      subtitle: Row(
        children: [
          SizedBox(
            width: 35,
          ),
          Expanded(child: Text(subTitle)),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
    );
  }
}

class ConfirmSignOutDialog extends StatelessWidget {
  final Function onConfirmPressed;
  ConfirmSignOutDialog({this.onConfirmPressed});
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
            Text('Do you really want to sign out?'),
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
                    onPressed: onConfirmPressed,
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
