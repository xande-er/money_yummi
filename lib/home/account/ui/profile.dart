import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_yummi/ui/buttons.dart';

class Profile extends StatelessWidget {
  final String username;
  final String icon;
  final Function onPressed;

  const Profile({Key key, this.username, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Transform.scale(
                alignment: FractionalOffset.center,
                scale: 1.05,
                child: Image.asset('picture/home/account/column_profile.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 38),
            child: Row(
              children: [
                Transform.scale(
                    alignment: FractionalOffset.center,
                    scale: 1.05,
                    child: Image.asset('picture/home/account/no_account_photo.png')),
                Padding(
                  padding: const EdgeInsets.only(top: 55, left: 15),
                  child: Text(
                    username,
                    style: GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 56, right: 30),
                  child: DTransparentScalableButton(
                    onPressed: () {},
                    scale: ScaleFormat.big,
                    child: Image.asset(
                      'picture/home/account/exit.png',
                      height: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 40),
              child: DTransparentScalableButton(
                onPressed: onPressed,
                scale: ScaleFormat.big,
                child: SvgPicture.asset(
                  'picture/home/account/$icon.svg',
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 100, right: 185),
              child: DTransparentScalableButton(
                onPressed: () {},
                scale: ScaleFormat.big,
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xffFF871A)),
                  child: Center(
                    child: SvgPicture.asset(
                      'picture/home/account/add_photo.svg',
                      height: 12,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
