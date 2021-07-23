// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:webapp/UI/screens/main_screen.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/repositories/user_repository.dart';
import 'package:webapp/utils/screen_utils.dart';
import 'package:webapp/utils/service_locator.dart';
import 'package:velocity_x/velocity_x.dart';

class UserDetailsScreen extends StatefulWidget {
  static const String route = '/user_details';
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  TextEditingController nameFieldController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  UserRepository _userRepository = locator<UserRepository>();
  UserModel _userModel = locator<UserModel>();

  @override
  void initState() {
    nameFieldController = TextEditingController();
    if (_userModel.userName != null)
      nameFieldController.text = _userModel.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: (!isLoading)
            ? ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'User Details',
                          style: TextStyle(
                              fontSize:
                                  (context.screenHeight > context.screenWidth)
                                      ? ScreenUtil.getInstance().setHeight(58)
                                      : ScreenUtil.getInstance().setWidth(30),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: (context.screenHeight > context.screenWidth)
                            ? ScreenUtil.getInstance().setHeight(58)
                            : ScreenUtil.getInstance().setWidth(30),
                      ),
                      Stack(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: ScreenUtil.getInstance().setHeight(96),
                            child: Icon(FontAwesomeIcons.userAlt),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            top: 0,
                            left: 0,
                            child: Container(
                              alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: (_userModel.userPhotoURL != null)
                                          ? Image.network(
                                                  _userModel.userPhotoURL)
                                              .image
                                          : Image.asset('images/logo.png')
                                              .image)),
                              height: ScreenUtil.getInstance().setHeight(96),
                              width: ScreenUtil.getInstance().setHeight(96),
                              child: FloatingActionButton(
                                  mini: true,
                                  child: Icon(Icons.edit),
                                  onPressed: () async {
                                    try {
                                      ImagePicker picker = ImagePicker();
                                      PickedFile pickedFile =
                                          await picker.getImage(
                                              source: ImageSource.gallery);
                                      File file = File(pickedFile.path);

                                      // var file = await ImagePickerWeb.getImage(
                                      //     outputType: ImageType.file);
                                      if (file != null) {
                                        _scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('Uploading Image')));
                                        var url = await _userRepository
                                            .uploadUserImage(file);
                                        _userModel.userPhotoURL = url;
                                        print(url);
                                        setState(() {});
                                      }
                                    } catch (e) {
                                      print('${e.code} ${e.message}');
                                    }
                                  }),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: (context.screenHeight > context.screenWidth)
                            ? ScreenUtil.getInstance().setHeight(58)
                            : ScreenUtil.getInstance().setWidth(30),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: ScreenUtil.getInstance().setHeight(100),
                          maxHeight: ScreenUtil.getInstance().setHeight(150),
                        ),
                        child: TextFormField(
                          controller: nameFieldController,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.userAlt,
                              color: Colors.white,
                            ),
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(24),
                      ),
                      FlatButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (!nameFieldController.text.isEmptyOrNull) {
                            setState(() {
                              isLoading = true;
                            });
                            _userModel.userName =
                                nameFieldController.text.toString();
                            try {
                              await _userRepository
                                  .updateUserDataOnDatabase(_userModel);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()));
                            } catch (e) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Some Error Occurred')));
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else
                            _scaffoldKey.currentState.showSnackBar(
                                SnackBar(content: Text('Enter your name')));
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              )
            : CircularProgressIndicator(
                color: Colors.red,
              ),
      ),
    );
  }
}
