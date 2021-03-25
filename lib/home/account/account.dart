import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_yummi/home/account/ui/button.dart';
import 'package:money_yummi/home/account/ui/profile.dart';
import 'package:money_yummi/model_user/model_user.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  ModelUser modelUser = Hive.box('modelUser').get('modelUser');
  bool activeSetting = false;

  @override
  Widget build(BuildContext context) {
    return ListView(physics: const ClampingScrollPhysics(), padding: EdgeInsets.all(0), children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Profile(
          username: modelUser.username,
          icon: activeSetting ? 'setting' : 'info',
          onPressed: () => setState(() {
            activeSetting = !activeSetting;
          }),
        ),
      ),
      if (!activeSetting) ...[
        ButtonAccount(header: 'Сменить имя пользователя', onPressed: () {}),
        ButtonAccount(header: 'Сменить пароль', onPressed: () {}),
        ButtonAccount(
            header: 'Push - уведомления',
            onPressed: () {},
            slider: true,
            sliderRes: modelUser.notificationDevice,
            sliderOnChanged: (_) {}),
        ButtonAccount(
            header: 'Уведомления на пошту',
            onPressed: () => setState(() => modelUser.notificationEmail = !modelUser.notificationEmail),
            slider: true,
            sliderRes: modelUser.notificationEmail,
            sliderOnChanged: (_) => setState(() => modelUser.notificationEmail = !modelUser.notificationEmail)),
        ButtonAccount(header: 'Сменить язык', onPressed: () {})
      ] else ...[
        ButtonAccount(header: 'Служба поддержки', onPressed: () {}),
        ButtonAccount(header: 'Инструкция', onPressed: () {}),
        ButtonAccount(header: 'Условия использования', onPressed: () {}),
        ButtonAccount(header: 'Политика конфиденциальности', onPressed: () {}),
        ButtonAccount(header: 'О нас', onPressed: () {}),
      ]
    ]);
  }
}
