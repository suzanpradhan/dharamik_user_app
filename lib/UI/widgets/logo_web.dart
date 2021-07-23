import 'package:flutter/material.dart';
import 'package:webapp/utils/screen_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Image(
          image: AssetImage('images/logo.png'),
          width: (context.screenWidth > context.screenHeight)
              ? ScreenUtil.getInstance().setWidth(88)
              : 100,
          height: (context.screenHeight > context.screenWidth)
              ? ScreenUtil.getInstance().setHeight(198)
              : 100,
        ),
      ),
    );
  }
}
