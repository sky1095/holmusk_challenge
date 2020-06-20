import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  bool isDark = false;

  changeTheme(bool value) {
    isDark = value;
    notifyListeners();
  }
}
