import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  // single pattern
  // observable pattern
  ThemeMode currentTheme = ThemeMode.dark;
  String currentLocal = "en";

  void changeTheme(ThemeMode newMode) async {
    saveTheme(newMode == ThemeMode.dark ? true : false);
    if (newMode == currentTheme) return;
    currentTheme = newMode;
    notifyListeners();
  }

  saveTheme(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', isDark);
    notifyListeners();
  }

  getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool theme = prefs.getBool('theme') ?? false;
    currentTheme = theme ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }

  bool isEn() {
    return currentLocal == 'en';
  }

  String getMainBackground() {
    return currentTheme == ThemeMode.dark
        ? 'assets/images/dark_bg.png'
        : 'assets/images/default_bg.png';
  }

  String getMainSplash() {
    return currentTheme == ThemeMode.dark
        ? 'assets/images/darksplash.png'
        : 'assets/images/splash.png';
  }

  void changeLanguage(String newLang) {
    saveLanguage(newLang);
    if (currentLocal == newLang) return;
    currentLocal = newLang;
    notifyListeners();
  }

  saveLanguage(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', lang);
    notifyListeners();
  }

  getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLocal = prefs.getString('language') ?? 'en';
    notifyListeners();
  }
}
