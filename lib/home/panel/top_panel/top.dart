import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_yummi/struct/model/model_panel_update.dart';
import 'package:provider/provider.dart';

class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xff231D28),
            border: Border(
              bottom: BorderSide(
                color: const Color(0xff383D5F),
                width: 2.0,
              ),
            )),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: 50,
            child: Consumer<ModelBottomUpdate>(builder: (context, ModelBottomUpdate m, Widget child) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Image.asset('picture/panel/top/money.png'),
                  ),
                  Text(
                    m.money.toString(),
                    style: GoogleFonts.rubik(color: Colors.white, fontSize: 18),
                  ),
                  Spacer(),
                  SvgPicture.asset('picture/panel/top/notification.svg'),
                  SizedBox(
                    width: 25,
                  )
                ],
              );
            }),
          ),
        ));
  }
}
