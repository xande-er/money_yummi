import 'package:hive/hive.dart';
import 'package:money_yummi/model_user/model_user.dart';

saveDataUser(res, pass) async {
  print(res);
  ModelUser modelUser = ModelUser();
  modelUser.id = res['data']['id_user'];
  modelUser.username = res['data']['username'];
  modelUser.email = res['data']['email'];
  // modelUser.tokenAuth = res['data']['token_auth'];
  modelUser.device = res['data']['device'];
  modelUser.registrationDate = DateTime.parse(res['data']['registration_date']);
  modelUser.photo = res['data']['photo'];
  modelUser.money = int.parse(res['data']['money']);
  modelUser.confirmationEmail = res['data']['confirmation_email'];
  modelUser.confirmationEmail = res['data']['confirmation_email'];
  modelUser.notificationDevice = res['data']['notification_device'];
  modelUser.notificationEmail = res['data']['notification_email'];
  modelUser.pass = pass;
  await Hive.box('modelUser').put('modelUser', modelUser);
}
