import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ModelBottomUpdate extends ChangeNotifier {
  int activeButton = 1;
  int money = Hive.box('modelUser').get('modelUser').money;
  bool notification = false;

  void bottomUpdateButton(int button) async {
    activeButton = button;
    notifyListeners();
  }

  void updateMoney(int money) async {
    money = money;
    notifyListeners();
  }

  void updateNotification(bool notification) async {
    notification = notification;
    notifyListeners();
  }
}
