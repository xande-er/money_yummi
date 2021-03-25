import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeWidget extends StatelessWidget {
  final String fromText;
  final String toText;
  final int activeSegmentCount;
  final Function onValueChanged;

  const SwipeWidget({Key key, this.fromText, this.toText, this.activeSegmentCount, this.onValueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyleActive = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);
    final textStyleDisable = const TextStyle(color: Color(0xff85898F), fontSize: 18, fontWeight: FontWeight.w400);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(0.60),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ]),
        child: CupertinoSlidingSegmentedControl<int>(
          backgroundColor: const Color(0xff2C304B),
          thumbColor: const Color(0xff343A58),
          children: <int, Widget>{
            0: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  fromText,
                  style: activeSegmentCount == 0 ? textStyleActive : textStyleDisable,
                )),
            1: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  toText,
                  style: activeSegmentCount == 1 ? textStyleActive : textStyleDisable,
                )),
          },
          onValueChanged: onValueChanged,
          groupValue: activeSegmentCount,
        ),
      ),
    );
  }
}
