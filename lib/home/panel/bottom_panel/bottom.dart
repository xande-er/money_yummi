import 'package:flutter/material.dart';
import 'package:money_yummi/home/panel/bottom_panel/batton.dart';
import 'package:money_yummi/struct/model/model_panel_update.dart';
import 'package:money_yummi/ui/dNeuInput.dart';
import 'package:provider/provider.dart';

class BottomPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xff231D28),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ]),
        child: SizedBox(
          height: 90,
          child: Stack(children: [
            InnerShadow(
              color: Color(0xff231D28),
              offset: const Offset(0, 2),
              blur: 10,
              child: InnerShadow(
                color: Colors.white.withOpacity(0.25),
                // color: Colors.transparent,
                offset: const Offset(0, 2),
                blur: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    color: Color(0xff231D28),
                  ),
                ),
              ),
            ),
            Consumer<ModelBottomUpdate>(builder: (context, ModelBottomUpdate m, Widget child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Spacer(),
                    Button(
                      activeButton: m.activeButton == 1,
                      image: 'game',
                      onPressed: () => context.read<ModelBottomUpdate>().bottomUpdateButton(1),
                    ),
                    Spacer(),
                    Button(
                      activeButton: m.activeButton == 2,
                      image: 'wallet',
                      onPressed: () => context.read<ModelBottomUpdate>().bottomUpdateButton(2),
                    ),
                    Spacer(),
                    Button(
                      activeButton: m.activeButton == 3,
                      image: m.activeButton == 3 ? 'friendActive' : 'friend',
                      onPressed: () {
                        context.read<ModelBottomUpdate>().bottomUpdateButton(3);
                      },
                    ),
                    Spacer(),
                    Button(
                      activeButton: m.activeButton == 4,
                      image: 'account',
                      onPressed: () {
                        context.read<ModelBottomUpdate>().bottomUpdateButton(4);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              );
            }),
          ]),
        ));
  }
}
