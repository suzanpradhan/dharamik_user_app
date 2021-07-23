import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class NiftyLevels extends StatelessWidget {
  final String imageURL;
  NiftyLevels(this.imageURL);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (context.mdWindowSize == MobileWindowSize.small ||
              context.mdWindowSize == MobileWindowSize.xsmall)
          ? EdgeInsets.all(10)
          : EdgeInsets.only(left: 40),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Bank Nifty Levels',
              style: TextStyle(
                  fontSize: (context.mdWindowSize == MobileWindowSize.large ||
                          context.mdWindowSize == MobileWindowSize.xlarge ||
                          context.mdWindowSize == MobileWindowSize.medium)
                      ? 35
                      : 22,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 5),
            Expanded(
              child: (context.mdWindowSize == MobileWindowSize.xlarge ||
                      context.mdWindowSize == MobileWindowSize.large ||
                      context.mdWindowSize == MobileWindowSize.medium)
                  ? Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          imageURL,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        imageURL,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
