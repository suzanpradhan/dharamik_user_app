import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {@required this.buttonText,
      this.icon,
      this.onPressed,
      this.iconColor,
      this.textColor,
        this.signalCount,
      @required this.iconPath});
  final IconData icon;
  final String buttonText;
  final Function onPressed;
  final Color iconColor;
  final int signalCount;
  final Color textColor;
  final String iconPath;

  @override
  Widget build(BuildContext context) {


    return FlatButton(
      splashColor: Colors.grey,
      hoverColor: Colors.transparent,
      child: Row(
        children: <Widget>[
          Image(
            height: 25.0,
            image: AssetImage(iconPath.toString()),
          ),
          SizedBox(
            width: 8.0,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: buttonText,style: TextStyle(color: textColor, fontSize: 16.0)),
                TextSpan(text: '  '),
                TextSpan(text:'${signalCount==0?'':signalCount}',style: TextStyle(color: Colors.red, fontSize: 16.0),),
              ]
            ),
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}
