import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_yummi/home/friends/ui/friends_widget.dart';
import 'package:money_yummi/home/friends/ui/swipe_widget.dart';
import 'package:money_yummi/ui/dNeuInput.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  int activeSegmentCount = 0;
  Key keySearch;
  final controllerPass = TextEditingController();
  String errorSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
            child: SwipeWidget(
                fromText: 'Мои друзья',
                toText: 'Поиск',
                activeSegmentCount: activeSegmentCount,
                onValueChanged: (num) => setState(() {
                      if (num != activeSegmentCount) {
                        activeSegmentCount = num;
                        controllerPass.text = '';
                      }
                    }))),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: DNeuInput(
            key: keySearch,
            hint: '',
            hintTextField: 'Поиск',
            error: errorSearch,
            controller: controllerPass,
            icon: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: SvgPicture.asset('picture/home/friends/search.svg'),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // FriendsWidget(),
        // FriendsWidget(),
        // FriendsWidget(),
      ],
    );
  }
}
