import 'package:flutter/material.dart';

class WaterMark extends StatefulWidget {
  final String userId;

  const WaterMark(this.userId);
  @override
  _WaterMarkState createState() => _WaterMarkState();
}

class _WaterMarkState extends State<WaterMark> {
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      fontSize: 28,
      color: Colors.white.withOpacity(0.2),
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OverflowBox(
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '${widget.userId}',
                      overflow: TextOverflow.clip,
                      style: style,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
