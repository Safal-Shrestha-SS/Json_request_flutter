import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModels extends ChangeNotifier {
  bool _isDark = false;
  SharedPreferences? _prefs;
  bool get isDark => _isDark;
  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _isDark = _prefs!.getBool('isDark') ?? true;
    notifyListeners();
  }

  ThemeModels() {
    _isDark = false;
    _loadFromPrefs();
  }
  changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = !_isDark;
    prefs.setBool('isDark', _isDark);
    notifyListeners();
  }
}
