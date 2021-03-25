import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_yummi/ui/buttons.dart';
import 'package:money_yummi/ui/elements/bottom_panel/shadow.dart';

class ButtonAccount extends StatelessWidget {
  final String header;
  final Function onPressed;
  final bool slider;
  final bool sliderRes;
  final Function sliderOnChanged;

  const ButtonAccount({Key key, this.header, this.onPressed, this.slider, this.sliderRes, this.sliderOnChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
        child: DTransparentScalableButton(
          onPressed: onPressed,
          scale: ScaleFormat.small,
          child: Container(
              height: 50,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.60),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ]),
              child: InnerShadow(
                  color: Color(0xffFFFFFF).withOpacity(0.25),
                  offset: const Offset(1, 1),
                  blur: 2,
                  child: InnerShadow(
                    color: Color(0xffFFFFFF).withOpacity(0.25),
                    offset: const Offset(-1, -1),
                    blur: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xff343A58), borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              header,
                              style: GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                          ),
                          Spacer(),
                          if (slider == null || !slider) ...[
                            Padding(
                              padding: const EdgeInsets.only(right: 17),
                              child: SvgPicture.asset(
                                'picture/home/account/row.svg',
                                height: 14,
                              ),
                            )
                          ] else ...[
                            Switch(
                              value: sliderRes,
                              onChanged: sliderOnChanged,
                              activeColor: Color(0xffFF871A),
                              inactiveThumbColor: Color(0xff85898F),
                            )
                          ]
                        ],
                      ),
                    ),
                  ))),
        ));
  }
}
