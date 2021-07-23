import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webapp/UI/screens/premium_signal_screen/watermark.dart';

import 'package:webapp/bloc/premium_signals_bloc/premium_signals_bloc.dart';
import 'package:webapp/models/premium_signal_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/services/alerts_service.dart';
import 'package:webapp/utils/service_locator.dart';

class PremiumSignals extends StatefulWidget {
  final UserModel user;

  const PremiumSignals({this.user});
  @override
  _PremiumSignalsState createState() => _PremiumSignalsState();
}

class _PremiumSignalsState extends State<PremiumSignals> {
  PremiumSignalsBloc _signalsBloc = PremiumSignalsBloc();
  List<PremiumSignalModel> premiumSignals;

  StreamSubscription listener;
  AlertsService alertsService = locator<AlertsService>();

  @override
  void initState() {
    _signalsBloc.add(GetInitialSignals());
    updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WaterMark(widget.user.uniqueCode +
                  "-" +
                  widget.user.userName +
                  "-dharmaik" ??
              widget.user.userId + "-" + widget.user.userName + "-dharmaik"),
          BlocListener<PremiumSignalsBloc, PremiumSignalsState>(
            bloc: _signalsBloc,
            listener: (context, state) {
              if (state is PremiumSignalsLoaded) {
                if (premiumSignals == null) premiumSignals = List();
                premiumSignals.addAll(state.premiumSignals);

                if (this.listener == null) {
                  UserModel user = locator<UserModel>();

                  if (user.membershipId != null) {
                    alertsService.listeningToSignals = true;
                    listener = alertsService.realtimeSignals.listen((model) {
                      if (!checkIfSignalExists(model))
                        setState(() {
                          model.isNewSignal = true;
                          this.premiumSignals.insert(0, model);
                        });
                    });
                  }
                }
                setState(() {});
              }
            },
            child: (premiumSignals == null)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : (premiumSignals.isEmpty)
                    ? Center(
                        child: Text('No signals'),
                      )
                    : Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 500),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return PremiumSignalsCard(
                                signalModel: premiumSignals[index],
                                id: widget.user.uniqueCode +
                                        "-" +
                                        widget.user.userName +
                                        "-dharmaik" ??
                                    widget.user.userId +
                                        "-" +
                                        widget.user.userName +
                                        "-dharmaik",
                              );
                            },
                            itemCount: premiumSignals.length,
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  bool checkIfSignalExists(PremiumSignalModel signalModel) {
    if (premiumSignals == null) return false;
    var signal = premiumSignals.firstWhere(
        (element) => signalModel.signalId == element.signalId,
        orElse: () => null);
    return signal != null;
  }

  @override
  void dispose() {
    if (listener != null) {
      alertsService.listeningToSignals = false;
      listener.cancel();
    }
    super.dispose();
  }

  void updateUser() async {
    UserModel user = locator<UserModel>();

    if (user != null) {
      user.lastSignalViewed = DateTime.now().millisecondsSinceEpoch;
      var userRepo = UserRepository();
      userRepo.setUserId(user.userId);

      await userRepo.updateUserDataOnDatabase(user);
    } else {
      print('user is null cannot update time viewed');
    }
  }
}

class PremiumSignalsCard extends StatelessWidget {
  PremiumSignalsCard({this.signalModel, this.id});
  final PremiumSignalModel signalModel;
  final id;
  var style = TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.2));
  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(
        signalModel.signalTimestamp.millisecondsSinceEpoch);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(DateFormat('dd-MM-yyyy').format(dateTime)),
                    SizedBox(
                      width: 15,
                    ),
                    Text(DateFormat('HH:mm').format(dateTime)),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                (signalModel.isNewSignal == true)
                    ? Image(
                        image: AssetImage('images/new.png'),
                      )
                    : Offstage(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      bottomLeft: Radius.circular(20.0),
                      topRight: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0))),
              //color: Colors.white,
              child: InkWell(
                //splashColor: Colors.redAccent.shade100,
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.all(15),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),

                                // Text(id, style: TextStyle(fontSize: 20,color: Colors.white.withOpacity(0.2)),),
                                // SizedBox(width: 3,),
                                // Text(id, style: TextStyle(fontSize: 20,color: Colors.white.withOpacity(0.2)),),
                              ],
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.2)),
                                ),
                                SizedBox(
                                  width: 3,
                                ),

                                // Text(id, style: TextStyle(fontSize: 20,color: Colors.white.withOpacity(0.2)),),
                                // SizedBox(width: 3,),
                                // Text(id, style: TextStyle(fontSize: 20,color: Colors.white.withOpacity(0.2)),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 25,
                              color: Colors.black,
                            ),
                            Expanded(
                              child: Linkify(
                                onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                  } else {
                                    throw 'Could not launch $link';
                                  }
                                },
                                text: signalModel.signalText
                                        ?.replaceAll("<", "")
                                        ?.replaceAll("<", "") ??
                                    '',
                                linkStyle: TextStyle(color: Colors.red),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            // StyledText(
                            //   text: signalModel.signalText
                            //           ?.replaceAll("<", "")
                            //           ?.replaceAll("<", "") ??
                            //       '',
                            //   overflow: TextOverflow.clip,
                            //   style: TextStyle(color: Colors.black),
                            //   newLineAsBreaks: true,
                            //   styles: {
                            //     '*': TextStyle(fontWeight: FontWeight.bold),
                            //     'red': TextStyle(color: Colors.red),
                            //     'green': TextStyle(color: Colors.green),
                            //     'yellow': TextStyle(color: Colors.yellow),
                            //     'blue': TextStyle(color: Colors.blue),
                            //     '_': TextStyle(fontStyle: FontStyle.italic),
                            //     '~': TextStyle(
                            //         decoration: TextDecoration.lineThrough),
                            //     'link': ActionTextStyle(
                            //       decoration: TextDecoration.underline,
                            //       onTap: (text, attributes) {
                            //         final String link = attributes['href'];
                            //         launch(link);
                            //         print('The $link link is tapped');
                            //       },
                            //     )
                            //   },
                            // ),

                            signalModel.imageUrl != null &&
                                    signalModel.imageUrl != ""
                                ? (context.mdWindowSize ==
                                            MobileWindowSize.xsmall ||
                                        context.mdWindowSize ==
                                            MobileWindowSize.small)
                                    ? SizedBox(
                                        height: 140,
                                        width: 140,
                                        child: InkWell(
                                            child: Image.network(
                                              signalModel.imageUrl,
                                              height: 200,
                                            ),
                                            onTap: () {
                                              launch(signalModel.imageUrl);
                                            }))
                                    : SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: InkWell(
                                            child: Image.network(
                                              signalModel.imageUrl,
                                              height: 200,
                                            ),
                                            onTap: () {
                                              launch(signalModel.imageUrl);
                                            }))
                                : SizedBox()
                          ],
                        ),
                      ),
                      // ListTile(
                      //   onTap: () {
                      //     print('i am pressed');
                      //     if (signalModel.signalText != null &&
                      //         signalModel.signalText != "" &&
                      //         signalModel.signalText.contains('http')) {
                      //       launch(signalModel.signalText.substring(
                      //           signalModel.signalText.indexOf("<") + 1,
                      //           signalModel.signalText.indexOf(">")));
                      //     }
                      //   },
                      //   leading: Icon(
                      //     Icons.trending_up,
                      //     size: 25,
                      //     color: Colors.black,
                      //   ),
                      //   title: StyledText(
                      //     text: signalModel.signalText
                      //             ?.replaceAll("<", "")
                      //             ?.replaceAll("<", "") ??
                      //         '',
                      //     overflow: TextOverflow.clip,
                      //     style: TextStyle(color: Colors.black),
                      //     newLineAsBreaks: true,
                      //     styles: {
                      //       '*': TextStyle(fontWeight: FontWeight.bold),
                      //       'red': TextStyle(color: Colors.red),
                      //       'green': TextStyle(color: Colors.green),
                      //       'yellow': TextStyle(color: Colors.yellow),
                      //       'blue': TextStyle(color: Colors.blue),
                      //       '_': TextStyle(fontStyle: FontStyle.italic),
                      //       '~': TextStyle(
                      //           decoration: TextDecoration.lineThrough),
                      //       'link': ActionTextStyle(
                      //         decoration: TextDecoration.underline,
                      //         onTap: (text, attributes) {
                      //           final String link = attributes['href'];
                      //           launch(link);
                      //           print('The $link link is tapped');
                      //         },
                      //       )
                      //     },
                      //   ),
                      //   trailing: signalModel.imageUrl != null &&
                      //           signalModel.imageUrl != ""
                      //       ? SizedBox(
                      //           height: 200,
                      //           width: 200,
                      //           child: InkWell(
                      //               child: Image.network(
                      //                 signalModel.imageUrl,
                      //                 height: 200,
                      //               ),
                      //               onTap: () {
                      //                 launch(signalModel.imageUrl);
                      //               }))
                      //       : SizedBox(),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
