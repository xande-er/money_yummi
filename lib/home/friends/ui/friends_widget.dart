import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_yummi/ui/buttons.dart';
import 'package:money_yummi/ui/dNeuInput.dart';

class FriendsWidget extends StatelessWidget {
  final String username, email, money, photo;
  final bool activeIcon;
  final Function onPressed;

  FriendsWidget({this.username, this.email, this.money, this.activeIcon, this.photo, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            decoration: BoxDecoration(color: Color(0xff343A58), borderRadius: BorderRadius.circular(10), boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(0.60),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ]),
            child: Row(
              children: [
                Container(
                  width: 25,
                  decoration: BoxDecoration(
                    color: Color(0xff2A2D47),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            money,
                            style: GoogleFonts.rubik(color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            'picture/panel/top/money.png',
                            height: 12,
                          ),
                        ],
                      )),
                ),
                Expanded(
                  child: InnerShadow(
                      color: Color(0xffFFFFFF).withOpacity(0.25),
                      offset: const Offset(1, 1),
                      blur: 2,
                      child: InnerShadow(
                          color: Color(0xffFFFFFF).withOpacity(0.25),
                          offset: const Offset(-1, -1),
                          blur: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff343A58),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 7, bottom: 7, right: 7),
                                  child: Image.asset('picture/home/friends/account_photo.png'),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(username,
                                            style: GoogleFonts.rubik(color: Colors.white, fontSize: 16))),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(email, style: GoogleFonts.rubik(color: Color(0xff85898F), fontSize: 14)),
                                  ],
                                ),
                                Spacer(),
                                DTransparentScalableButton(
                                  onPressed: onPressed,
                                  scale: ScaleFormat.small,
                                  child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: Color(0xff343A58),
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff000000).withOpacity(0.25),
                                              spreadRadius: 3,
                                              blurRadius: 3,
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
                                                decoration: BoxDecoration(
                                                    color: Color(0xff343A58), borderRadius: BorderRadius.circular(8)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset('picture/home/friends/dell_user.svg',
                                                      color: activeIcon ? Color(0xffFF871A) : Colors.white),
                                                ),
                                              )))),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ))),
                ),
              ],
            )));
  }
}
