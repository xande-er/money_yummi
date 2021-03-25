import 'package:flutter/material.dart';
import 'package:money_yummi/home/panel/bottom_panel/bottom.dart';
import 'package:money_yummi/home/panel/top_panel/top.dart';
import 'package:money_yummi/struct/model/model_panel_update.dart';
import 'package:provider/provider.dart';

import 'account/account.dart';
import 'friends/friends.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModelBottomUpdate>(
      create: (context) => ModelBottomUpdate(),
      child: Scaffold(
          backgroundColor: const Color(0xff2C304B),
          bottomNavigationBar: BottomPanel(),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0), // here the desired height
              child: Top()),
          body: Consumer<ModelBottomUpdate>(
              builder: (context, ModelBottomUpdate m, Widget child) {
            if (m.activeButton == 4) {
              return Account();
            } else if (m.activeButton == 3) {
              return Friends();
            } else
              return Container();
          })),
    );
  }
}
