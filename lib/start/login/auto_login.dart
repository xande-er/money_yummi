import 'package:money_yummi/model_user/model_user.dart';
import 'package:money_yummi/server/socket/connect.dart';

autoLogin(ModelUser modelAuth, context) async {
  print('asdasdsa');


  var Platform;
  socket.emit('auth/authorization', {
    'email': modelAuth.email,
    'pass': modelAuth.pass,
    'device': Platform.isAndroid ? 'Android' : 'IOS',
    'token_notification': 'token',
    'meta': '123123',
  });


  // final res = await Requests.authorization(
  //     modelAuth.email, modelAuth.pass, 'token', context);
  // socket.on('auth/authorization', (res) async {
  //   print(res);
  // });

  // socket.emit('auth/authorization', {
  //   'email': 'sashamot@gmail.com',
  //   'pass': '123123',
  //   'con_pass': '123123',
  // });
  //
  // socket.on('chat_mes', (res) async {
  //   print(res);
  // });
  // });
  // if (res['status'] == 200) {
  //   await saveDataUser(res, modelAuth.pass);
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
  // } else {
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Start()));
  // }
}
