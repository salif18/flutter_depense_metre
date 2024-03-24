import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color? _colorText ;
  Color? _colorBackground;
  Color? _containerBackg;
  Color? _colorBtn ;
  bool isDark = false;

  Color? get colorText => _colorText;
  Color? get colorBackground => _colorBackground;
  Color? get containerBackg => _containerBackg;
  Color? get colorBtn => _colorBtn;
 
   changeTheme() {
    isDark = !isDark;
    _updateColors();
    notifyListeners();
  }

  void _updateColors() {
    _colorText = isDark ? Colors.grey[200] : null;
    _colorBackground = isDark ? Colors.black : null;
    _containerBackg = isDark ? const Color.fromARGB(226, 29, 29, 29) : null;
    _colorBtn = isDark ? Colors.white : null;
  }
}
