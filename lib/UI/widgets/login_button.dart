import 'package:flutter/material.dart';
import 'package:webapp/utils/screen_utils.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {this.text,
      this.icon,
      this.onPressed,
      this.color,
      this.iconColor,
      this.textColor});
  final IconData icon;
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: ScreenUtil.getInstance().setHeight(100)),
      child: RaisedButton(
        elevation: 60,
        padding: EdgeInsets.only(left: 10, right: 8),
        hoverElevation: 40,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: color,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: iconColor,
              size: ScreenUtil.getInstance().setHeight(40),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
