import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_yummi/start/login/login.dart';
import 'package:money_yummi/start/registration/registration.dart';
import 'package:money_yummi/ui/buttons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.99999);

    return Scaffold(
        backgroundColor: Color(0xff2C304B),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset('picture/start/icon.png'),
              ),
              Text(
                'Money-Yummy',
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
                child: Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: Color(0xf24283F),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: -5,
                      intensity: 10,
                      lightSource: LightSource.topRight,
                      shadowLightColorEmboss: Color(0xff1D2032),
                      shadowLightColor: Color(0xff333751),
                      color: Color(0xff1D2133),
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                    ),
                    child: Column(children: [
                      Container(
                        height: 150,
                        child: PageView(
                          controller: controller,
                          allowImplicitScrolling: false,
                          onPageChanged: (i) {},
                          children: [
                            listInfo('Правила игры',
                                'После реестрации Вы можете купить монетки чтобы играть с друзьями или же с другими игроками с всего мира. Так же...'),
                            listInfo('Моментальные оповещения',
                                'Как только информация пользователя меняется, вы сразу получите Push - сообщение об этом'),
                            listInfo('Статистика',
                                'Моментально просматривайте всю статистику и информацию по каждому пользователю в реальном времени 24/7'),
                          ],
                        ),
                      ),
                      Spacer(),
                      SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const SwapEffect(
                            dotColor: Color(0xff85898F), activeDotColor: Colors.white, dotWidth: 10, dotHeight: 10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: DFilledButton('регистрация', () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Registration(),
                    )), true),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 50),
                child: DFilledButton(
                    'вход',
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        )),
                    false),
              ),
            ],
          ),
        ));
  }

  Widget listInfo(String header, String text) => Column(
        children: [
          SizedBox(
            height: 15,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: header.toUpperCase(),
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: text, style: GoogleFonts.rubik(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      );
}
