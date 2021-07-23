import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MarketTrends extends StatelessWidget {
  final String marketTrendText;

  MarketTrends(this.marketTrendText);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500),
          child: Container(margin: (context.mdWindowSize == MobileWindowSize.small ||
              context.mdWindowSize == MobileWindowSize.xsmall)
          ? EdgeInsets.all(10)
          : EdgeInsets.only(left: 40),
          //  padding: EdgeInsets.all(10),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
                    'Market Trends',
                    style: TextStyle(fontSize: (context.mdWindowSize == MobileWindowSize.large ||
                          context.mdWindowSize == MobileWindowSize.xlarge ||
                          context.mdWindowSize == MobileWindowSize.medium)
                      ? 35
                      : 22, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    marketTrendText,
                    style: TextStyle(
                       fontSize: (context.mdWindowSize == MobileWindowSize.large ||
                          context.mdWindowSize == MobileWindowSize.xlarge ||
                          context.mdWindowSize == MobileWindowSize.medium)
                      ? 25
                      : 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
            
          ],
        ),
      ),
    );
  }
}
