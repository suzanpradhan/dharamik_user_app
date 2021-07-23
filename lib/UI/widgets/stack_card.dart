import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VideoStackCard extends StatelessWidget {
  const VideoStackCard(
      {Key key,
      this.cardText,
      this.playButton,
      this.imagePath,
      this.duration,
      this.rating,
      this.discText})
      : super(key: key);
  final String cardText;
  final String imagePath;
  final Function playButton;
  final String duration;
  final int rating;
  final String discText;

  @override
  Widget build(BuildContext context) {
    // double   _getMargin(){

    //   if(context.mdWindowSize == MobileWindowSize.small || context.mdWindowSize == MobileWindowSize.xsmall)
    //   return 25;
    //   else
    //   return 55;
    // }
    return Container(
      // constraints: BoxConstraints(maxWidth: 200, minWidth: 200),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          InkWell(
            onTap: playButton,
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              constraints: BoxConstraints(minWidth: 210),
              margin: EdgeInsets.only(
                  left: (context.mdWindowSize == MobileWindowSize.small ||
                          context.mdWindowSize == MobileWindowSize.xsmall)
                      ? 25.0
                      : 55.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                constraints: BoxConstraints(minWidth: 210),
                padding: EdgeInsets.all(
                  (context.mdWindowSize == MobileWindowSize.small ||
                          context.mdWindowSize == MobileWindowSize.xsmall)
                      ? 5.0
                      : 10.0,
                ),
                margin: EdgeInsets.only(
                  left: (context.mdWindowSize == MobileWindowSize.small ||
                          context.mdWindowSize == MobileWindowSize.xsmall)
                      ? 35.0
                      : 55.0,
                ),
                height: (context.mdWindowSize == MobileWindowSize.small ||
                        context.mdWindowSize == MobileWindowSize.xsmall)
                    ? 90.0
                    : 130.0,
                width: (context.mdWindowSize == MobileWindowSize.small ||
                        context.mdWindowSize == MobileWindowSize.xsmall)
                    ? 210.0
                    : 300.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Text(
                        cardText.toString(),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    // (context.mdWindowSize == MobileWindowSize.small ||
                    //         context.mdWindowSize == MobileWindowSize.xsmall)
                    //     ? Container()
                    //     :
                         Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                               (
                            context.mdWindowSize == MobileWindowSize.xsmall)
                        ? Container()
                        :Flexible(
                                child: Text(
                                  '$duration sec',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Row(
                                children: [
                                  if(rating != null)
                                    Text(
                                    '${rating.toString()}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                              Icon(Icons.play_circle_outline),
                            ],
                          ),
                    Flexible(
                      child: Text(
                        discText.toString(),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(11.0),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            height:  (context.mdWindowSize == MobileWindowSize.small ||
                            context.mdWindowSize == MobileWindowSize.xsmall)
                        ? 60.0:90,
            width:  (context.mdWindowSize == MobileWindowSize.small ||
                            context.mdWindowSize == MobileWindowSize.xsmall)
                        ? 60.0:110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11.0),
              child: Image(
                image: NetworkImage(imagePath.toString()),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
    // (context.mdWindowSize == MobileWindowSize.small ||
    // context.mdWindowSize == MobileWindowSize.xsmall)
    // ? Container(
    //     // constraints: BoxConstraints(maxWidth: 200, minWidth: 200),
    //     child: Stack(
    //       alignment: Alignment.centerLeft,
    //       children: [
    //         InkWell(
    //           onTap: playButton,
    //           borderRadius: BorderRadius.circular(12.0),
    //           child: Container(
    //             constraints: BoxConstraints(minWidth: 190),
    //             margin: EdgeInsets.only(left: 55.0),
    //             decoration: BoxDecoration(
    //               color: Colors.red,
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //             child: Container(
    //               constraints: BoxConstraints(minWidth: 190),
    //               padding: const EdgeInsets.all(10.0),
    //               margin: const EdgeInsets.only(left: 15.0),
    //               height: 90.0,
    //               width: 190.0,
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Flexible(
    //                     child: Text(
    //                       cardText.toString(),
    //                       textAlign: TextAlign.start,
    //                       overflow: TextOverflow.ellipsis,
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.w900,
    //                       ),
    //                     ),
    //                   ),
    //                   Flexible(
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         Text(
    //                           '$duration sec',
    //                           textAlign: TextAlign.start,
    //                           overflow: TextOverflow.ellipsis,
    //                           maxLines: 2,
    //                         ),
    //                        (context.mdWindowSize == MobileWindowSize.small)? Flexible(
    //                           child: Row(
    //                        //     mainAxisAlignment:
    //                             //    MainAxisAlignment.spaceAround,
    //                             children: [
    //                               Text(
    //                                 '${rating.toString()}',
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                               Icon(
    //                                 Icons.star,
    //                                 color: Colors.yellow,
    //                               )
    //                             ],
    //                           ),
    //                         ):Container(),
    //                         Icon(Icons.play_circle_outline),
    //                       ],
    //                     ),
    //                   ),
    //                   Flexible(
    //                     child: Text(
    //                       discText.toString(),
    //                       textAlign: TextAlign.start,
    //                       overflow: TextOverflow.ellipsis,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //             color: Colors.black,
    //             borderRadius: BorderRadius.circular(11.0),
    //             border: Border.all(
    //               color: Colors.black,
    //             ),
    //           ),
    //           height: 55.0,
    //           width: 65.0,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(11.0),
    //             child: Image(
    //               image: NetworkImage(imagePath.toString()),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   )
    // ? Container(
    //     constraints: BoxConstraints(maxWidth: 200, minWidth: 200),
    //     child: Stack(
    //       alignment: Alignment.centerLeft,
    //       children: [
    //         Container(
    //           margin: EdgeInsets.only(left: 15.0),
    //           decoration: BoxDecoration(
    //               color: Colors.red,
    //               borderRadius: BorderRadius.circular(10.0)),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: [
    //               Container(
    //                 margin: const EdgeInsets.only(left: 55.0),
    //                 height: (context.mdWindowSize ==
    //                             MobileWindowSize.xsmall ||
    //                         context.mdWindowSize == MobileWindowSize.small)
    //                     ? null
    //                     : 100,
    //                 width: (context.mdWindowSize ==
    //                             MobileWindowSize.xsmall ||
    //                         context.mdWindowSize == MobileWindowSize.small)
    //                     ? 110.0
    //                     : 300.0,
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.max,
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: [
    //                     Text(cardText.toString()),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         Text(duration.toString()),
    //                         Row(
    //                           children: [
    //                             Text(
    //                               '${rating.toString()}',
    //                               overflow: TextOverflow.ellipsis,
    //                               maxLines: 2,
    //                             ),
    //                             Icon(
    //                               Icons.star,
    //                               color: Colors.yellow,
    //                             )
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       crossAxisAlignment: CrossAxisAlignment.end,
    //                       children: [
    //                         GestureDetector(
    //                           child: Icon(
    //                             Icons.play_arrow,
    //                             color: Colors.black87,
    //                           ),
    //                           onTap: playButton,
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //               color: Colors.black,
    //               borderRadius: BorderRadius.circular(5.0)),
    //           height: 50.0,
    //           width: 60.0,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(5.0),
    //             child: Image(
    //               image: NetworkImage(imagePath.toString()),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   )
    // : Container(
    //     // constraints: BoxConstraints(maxWidth: 200, minWidth: 200),
    //     child: Stack(
    //       alignment: Alignment.centerLeft,
    //       children: [
    //         InkWell(
    //           onTap: playButton,
    //           borderRadius: BorderRadius.circular(12.0),
    //           child: Container(
    //             margin: EdgeInsets.only(left: 55.0),
    //             decoration: BoxDecoration(
    //               color: Colors.red,
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //             child: Container(
    //               padding: const EdgeInsets.all(10.0),
    //               margin: const EdgeInsets.only(left: 55.0),
    //               height: 130.0,
    //               width: 300.0,
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Text(
    //                     cardText.toString(),
    //                     textAlign: TextAlign.start,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.w900,
    //                     ),
    //                   ),
    //                   Row(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Text(
    //                         '$duration sec',
    //                         textAlign: TextAlign.start,
    //                         overflow: TextOverflow.ellipsis,
    //                         maxLines: 2,
    //                       ),
    //                       Row(
    //                         children: [
    //                           Text(
    //                             '${rating.toString()}',
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                           Icon(
    //                             Icons.star,
    //                             color: Colors.yellow,
    //                           )
    //                         ],
    //                       ),
    //                       Icon(Icons.play_circle_outline),
    //                     ],
    //                   ),
    //                   Flexible(
    //                     child: Text(
    //                       discText.toString(),
    //                       textAlign: TextAlign.start,
    //                       overflow: TextOverflow.ellipsis,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //             color: Colors.black,
    //             borderRadius: BorderRadius.circular(11.0),
    //             border: Border.all(
    //               color: Colors.black,
    //             ),
    //           ),
    //           height: 90.0,
    //           width: 110.0,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(11.0),
    //             child: Image(
    //               image: NetworkImage(imagePath.toString()),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   );
  }
}

class CategoryStackCard extends StatelessWidget {
  const CategoryStackCard({Key key, this.cardText, this.imagePath})
      : super(key: key);
  final String cardText;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 100,
          width: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cardText,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Duration',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Rating',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 8,
          child: Container(
            height: 50,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Image(
              image: AssetImage(imagePath),
            ),
          ),
        ),
      ],
    );
  }
}
