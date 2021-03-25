import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_yummi/home/home.dart';
import 'package:money_yummi/server/requests.dart';
import 'package:money_yummi/start/save_date_user.dart';
import 'package:money_yummi/start/ui_components/top_panel_back.dart';
import 'package:money_yummi/ui/buttons.dart';
import 'package:money_yummi/ui/dNeuInput.dart';

class Registration extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Registration> {
  final controllerUsername = TextEditingController(),
      controllerLogin = TextEditingController(),
      controllerPass = TextEditingController(),
      controllerPassRepeat = TextEditingController();
  String errorUsername, errorLogin, errorPass, errorPassRepeat;
  Key usernameKey, loginKey, passKey, passRepeatKey;
  bool loadButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff2C304B),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              topPanelBack('Регистрация', context),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: DNeuInput(
                  key: usernameKey,
                  hint: 'имя пользователя',
                  hintTextField: 'Xander',
                  error: errorUsername,
                  controller: controllerUsername,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
                child: DNeuInput(
                  key: passRepeatKey,
                  hint: 'Повторите пароль',
                  hintTextField: '••••••••',
                  error: errorPassRepeat,
                  controller: controllerPassRepeat,
                  obscure: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: DFilledButton(
                    'создать аккаунт',
                    loadButton
                        ? null
                        : () async {
                            setState(() {
                              loadButton = true;
                              errorUsername = null;
                              errorLogin = null;
                              errorPass = null;
                              errorPassRepeat = null;
                              usernameKey = UniqueKey();
                              loginKey = UniqueKey();
                              passKey = UniqueKey();
                              passRepeatKey = UniqueKey();
                            });

                            final res = await Requests.registration(controllerUsername.text, controllerLogin.text,
                                controllerPass.text, controllerPassRepeat.text, 'token', context);
                            print(res);
                            if (res['status'] == 200) {
                              await saveDataUser(res, controllerPass.text);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                                  ModalRoute.withName('/'));
                            } else {
                              for (var i in res['error'].keys) {
                                switch (i) {
                                  case 'username':
                                    errorUsername = res['error'][i];
                                    usernameKey = UniqueKey();
                                    break;
                                  case 'email':
                                    errorLogin = res['error'][i];
                                    loginKey = UniqueKey();
                                    break;
                                  case 'pass':
                                    errorPass = res['error'][i];
                                    passKey = UniqueKey();
                                    break;
                                  case 'pass_confirmation':
                                    errorPassRepeat = res['error'][i];
                                    passRepeatKey = UniqueKey();
                                    break;
                                  default:
                                    errorUsername = res['error'][i];
                                    usernameKey = UniqueKey();
                                    break;
                                }
                                break;
                              }
                            }

                            setState(() {
                              loadButton = false;
                            });
                          },
                    true),
              ),
              DTransparentScalableButton(
                scale: ScaleFormat.big,
                child: Text(
                  'Вернуться',
                  style: GoogleFonts.rubik(color: Color(0xff85898F), fontSize: 15),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ));
  }
}
