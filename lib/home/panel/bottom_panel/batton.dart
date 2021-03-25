import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_yummi/ui/buttons.dart';
import 'package:money_yummi/ui/elements/bottom_panel/shadow.dart';

class Button extends StatelessWidget {
  final bool activeButton;
  final String image;
  final Function onPressed;

  Button({this.activeButton, this.image, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Container(
        child: DTransparentScalableButton(
          onPressed: onPressed,
          scale: ScaleFormat.big,
          child: Container(
              decoration: BoxDecoration(color: Color(0xff231D28), borderRadius: BorderRadius.circular(15), boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.25),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 0),
                ),
              ]),
              child: InnerShadow(
                color: activeButton ? Color(0xffFF871A).withOpacity(0.40) : Colors.white.withOpacity(0.20),
                offset: const Offset(-1, -1),
                blur: 10 / 3,
                child: InnerShadow(
                  color: activeButton ? Color(0xffFF871A).withOpacity(0.40) : Colors.white.withOpacity(0.20),
                  offset: const Offset(1, 1),
                  blur: 10 / 3,
                  child: Container(
                      height: 61,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff231D28),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(image == 'wallet' ? 15.0 : 12.0),
                        child: SvgPicture.asset(
                          'picture/panel/bottom/$image.svg',
                          color: image == 'friendActive' || image == 'friend'
                              ? null
                              : activeButton
                                  ? Color(0xffFF871A)
                                  : Colors.white,
                        ),
                      )),
                ),
              )),
        ),
      ),
    );
  }
}
