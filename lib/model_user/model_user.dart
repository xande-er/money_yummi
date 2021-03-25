import 'package:hive/hive.dart';

part 'model_user.g.dart';

@HiveType(typeId: 1)
class ModelUser {
  @HiveField(0)
  int id;
  @HiveField(1)
  int money;
  @HiveField(2)
  String username;
  @HiveField(3)
  String email;
  @HiveField(4)
  String tokenAuth;
  @HiveField(5)
  String device;
  @HiveField(6)
  String photo;
  @HiveField(7)
  DateTime registrationDate;
  @HiveField(8)
  bool confirmationEmail;
  @HiveField(9)
  String pass;
  @HiveField(10)
  bool notificationEmail;
  @HiveField(11)
  bool notificationDevice;

  ModelUser(
      {this.id,
      this.money,
      this.username,
      this.tokenAuth,
      this.device,
      this.photo,
      this.registrationDate,
      this.confirmationEmail,
      this.pass,
      this.email,
      this.notificationDevice,
      this.notificationEmail});
}
