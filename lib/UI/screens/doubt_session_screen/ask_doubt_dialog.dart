// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webapp/UI/widgets/loading_dialog.dart';

import 'package:webapp/bloc/user_doubts_bloc/user_doubts_bloc.dart';
import 'package:webapp/models/doubt_category_model.dart';
import 'package:webapp/models/user_doubt_model.dart';
import 'package:webapp/models/user_model.dart';
import 'package:webapp/utils/service_locator.dart';

class AskDoubtDialog extends StatefulWidget {
  @override
  _AskDoubtDialogState createState() => _AskDoubtDialogState();
}

class _AskDoubtDialogState extends State<AskDoubtDialog> {
  UserDoubtsBloc _userDoubtsBloc = UserDoubtsBloc();
  TextEditingController _doubtTitleController = TextEditingController();
  TextEditingController _doubtDescController = TextEditingController();
  DoubtCategory selectedCategory;
  UserModel user = locator<UserModel>();

  Uint8List imageBytes;

  @override
  void initState() {
    _userDoubtsBloc.add(GetUserDoubtDialogInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ask a Doubt'),
          centerTitle: true,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: getFormLayout(),
          ),
        ));
  }

  Widget getFormLayout() {
    return BlocConsumer<UserDoubtsBloc, UserDoubtsState>(
        bloc: _userDoubtsBloc,
        listener: (context, state) {
          if (state is UserDoubtUploaded) {
            Fluttertoast.showToast(
                msg:
                    'Doubt sent to admin, it will be visible to you once admin replies');
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is UserDoubtsDialogInitial) {
            return ListView(
              padding: EdgeInsets.all(0),
              children: [
                (imageBytes != null) ? Image.memory(imageBytes) : Offstage(),
                SizedBox(
                  height: 10,
                ),
                //  getDoubtCategoriesButton(state.doubtCategories),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _doubtTitleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'What\'s your Doubt?'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _doubtDescController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Description'),
                ),
                SizedBox(height: 10),
                RaisedButton.icon(
                    label: Text('Attach Image'),
                    icon: Icon(Icons.attach_file),
                    onPressed: () async {
                      File file = await chooseImage();
                      if (file != null)
                        _userDoubtsBloc.add(ImageChangedEvent(file));
                    }),
                SizedBox(height: 5),
                RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_doubtTitleController.text.isNotEmpty &&
                          _doubtDescController.text.isNotEmpty &&
                          selectedCategory != null) {
                        var userDoubt = UserDoubtModel(
                          doubtTitle: _doubtTitleController.text,
                          doubtDescription: _doubtDescController.text,
                          doubtCategoryName:
                              selectedCategory.doubtCategoryName ?? '',
                          userId: user.userId,
                          userName: user.userName,
                          userEmail: user.userEmail,
                        );
                        _userDoubtsBloc.add(CreateDoubtEvent(userDoubt));
                      }
                    })
              ],
            );
          } else
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
        });
  }

  Widget getDoubtCategoriesButton(
    List<DoubtCategory> categories,
  ) {
    return Center(
      child: DropdownButton(
          hint: Text('Select Doubt Category'),
          value: selectedCategory,
          items: categories
              .map((e) =>
                  DropdownMenuItem(value: e, child: Text(e.doubtCategoryName)))
              .toList(),
          onChanged: (value) {
            selectedCategory = value;
            setState(() {});
          }),
    );
  }

  Future<File> chooseImage() async {
    // var file = await ImagePickerWeb.getImage(outputType: ImageType.file);
    // if (file != null) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => LoadingDialog(),
    //   );
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
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
    //   Navigator.of(context).pop();
    //   setState(() {});
    // });
    // reader.readAsArrayBuffer(file);
    // return file;
  }
}
