import 'dart:convert';
import 'dart:io';

// import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:money_yummi/server/model_connect.dart';


class Requests {
  static final url = '61ec0bf8a456.ngrok.io';

  static dynamic headers(tokenActive) => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        // '${!tokenActive ? '' : 'Authorization'}':
        // '${!tokenActive ? '' : 'Bearer ${Hive.box('setting').get('modelAuth').tokenAuth}'}'
      };

  static dynamic registration(String username, String email, String pass, String passConfirmation,
          String tokenNotification, context) async =>
      ModelConnect().queryResult(
          jsonDecode((await http.post(
                  Uri.https(url, 'auth/registration', {
                    'username': username,
                    'email': email,
                    'pass': pass,
                    'pass_confirmation': passConfirmation,
                    'device': Platform.isAndroid ? 'Android' : 'IOS',
                    'token_notification': tokenNotification,
                    'meta': 'load'
                  }),
                  headers: headers(true)))
              .body),
          false,
          context);

  static dynamic authorization(String email, String pass, String tokenNotification, context) async =>
      ModelConnect().queryResult(
          jsonDecode((await http.post(
                  Uri.https(url, 'auth/authorization', {
                    'email': email,
                    'pass': pass,
                    'device': Platform.isAndroid ? 'Android' : 'IOS',
                    'token_notification': tokenNotification,
                    'meta': 'load'
                  }),
                  headers: headers(true)))
              .body),
          false,
          context);
}
