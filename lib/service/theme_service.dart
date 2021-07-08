import 'package:flutter/material.dart';
import 'package:newsroom/utilities/store_manager.dart';

class ThemeService extends ChangeNotifier {
  ThemeMode? themeMode;

  //bool get isDarkMode => themeMode == ThemeMode.dark;

  ThemeService() {
    StorageManager.readData('themeMode').then((value) {
      var themeName = value ?? 'light';
      if (themeName == 'light')
        themeMode = ThemeMode.light;
      else
        themeMode = ThemeMode.dark;
      notifyListeners();
    });
  }

  getTheme() {
    return themeMode;
  }

  switchTheme() {
    StorageManager.readData('themeMode').then((value) {
      var themeName = value ?? 'light';
      if (themeName == 'light') {
        themeMode = ThemeMode.dark;
        StorageManager.saveData('themeMode', 'dark');
        notifyListeners();
      } else {
        themeMode = ThemeMode.light;
        StorageManager.saveData('themeMode', 'light');
        notifyListeners();
      }
    });
  }
}
