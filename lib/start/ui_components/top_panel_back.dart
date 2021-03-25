import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_yummi/ui/buttons.dart';

Widget topPanelBack(String header, BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: DTransparentScalableButton(
                scale: ScaleFormat.big,
                child: SvgPicture.asset('picture/components/back.svg'),
                onPressed: () => Navigator.pop(context),
              )
              ),
          Expanded(
            child: Center(
                child: Text(
              header.toUpperCase(),
              style: GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
            )),
          ),
          SizedBox(
            width: 50,
          ),
        ],
      ),
    );
