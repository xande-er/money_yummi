import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:money_yummi/home/home.dart';
import 'package:money_yummi/server/requests.dart';
import 'package:money_yummi/server/socket/connect.dart';
import 'package:money_yummi/start/save_date_user.dart';
import 'package:money_yummi/start/ui_components/top_panel_back.dart';
import 'package:money_yummi/ui/buttons.dart';
import 'package:money_yummi/ui/dNeuInput.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controllerLogin = TextEditingController(), controllerPass = TextEditingController();
  String errorLogin, errorPass;
  Key loginKey, passKey;
  bool loadButton = false;

  @override
  void initState() {
    if (Hive.box('modelUser').get('modelUser').email != null)
      controllerLogin.text = Hive.box('modelUser').get('modelUser').email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff2C304B),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              topPanelBack('Вход', context),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: DNeuInput(
                  key: loginKey,
                  hint: 'электронный адрес',
                  hintTextField: 'example@gmail.com',
                  error: errorLogin,
                  controller: controllerLogin,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: DNeuInput(
                  key: passKey,
                  hint: 'пароль',
                  hintTextField: '••••••••',
                  error: errorPass,
                  controller: controllerPass,
                  obscure: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 25),
                child: DFilledButton(
                    'ввойти',
                    loadButton
                        ? null
                        : () async {
                            setState(() {
                              loadButton = true;
                              errorLogin = null;
                              errorPass = null;
                              loginKey = UniqueKey();
                              passKey = UniqueKey();
                            });
                            socket.emit('auth/authorization', {
                              'email': controllerLogin.text,
                              'pass': controllerPass.text,
                              'device': Platform.isAndroid ? 'Android' : 'IOS',
                              'token_notification': 'token',
                              'meta': '123123',
                            });

                            socket.on('auth/authorization/res', (res) async {
                              if (res['status'] == 200) {
                                await saveDataUser(res, controllerPass.text);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (BuildContext context) => Home()),
                                    ModalRoute.withName('/'));
                              } else {
                                setState(() {
                                  for (var i in res['error'].keys) {
                                    switch (i) {
                                      case 'email':
                                        errorLogin = res['error'][i];
                                        loginKey = UniqueKey();
                                        break;
                                      case 'pass':
                                        errorPass = res['error'][i];
                                        passKey = UniqueKey();
                                        break;
                                      default:
                                        errorLogin = res['error'][i];
                                        loginKey = UniqueKey();
                                        break;
                                    }
                                    break;
                                  }
                                });

                              }
                            });
                            // final res = await Requests.authorization(
                            //     controllerLogin.text, controllerPass.text, 'token', context);
                            // if (res['status'] == 200) {
                            //   await saveDataUser(res, controllerPass.text);
                            //   Navigator.pushAndRemoveUntil(
                            //       context,
                            //       MaterialPageRoute(builder: (BuildContext context) => Home()),
                            //       ModalRoute.withName('/'));
                            // } else {
                            //   for (var i in res['error'].keys) {
                            //     switch (i) {
                            //       case 'email':
                            //         errorLogin = res['error'][i];
                            //         loginKey = UniqueKey();
                            //         break;
                            //       case 'pass':
                            //         errorPass = res['error'][i];
                            //         passKey = UniqueKey();
                            //         break;
                            //       default:
                            //         errorLogin = res['error'][i];
                            //         loginKey = UniqueKey();
                            //         break;
                            //     }
                            //     break;
                            //   }
                            // }

                            setState(() {
                              loadButton = false;
                            });
                          },
                    true),
              ),
              DTransparentScalableButton(
                scale: ScaleFormat.big,
                child: Text(
                  'Забыли пароль?',
                  style: GoogleFonts.rubik(color: Color(0xff85898F), fontSize: 15),
                ),
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
