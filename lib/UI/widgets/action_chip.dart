import 'package:flutter/material.dart';

//videoStackCard and catergoryStackCard are in commmon widgets
class ActionChipsBuilder extends StatelessWidget {
  ActionChipsBuilder({this.onPressed, this.actionChipText});
  final String actionChipText;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ActionChip(
        label: Text(
          actionChipText,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        labelPadding: EdgeInsets.all(10),
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
