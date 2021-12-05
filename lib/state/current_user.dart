import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intern_challenges/data_model/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser extends ChangeNotifier {
  late User currentUser;
  SharedPreferences? _prefs;
  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  loadFromPrefs(User user) async {
    await _initPrefs();
    currentUser = user;
    if (_prefs!.getString('Current_User_Key') == null) {
      _prefs!.setString('Current_User_Key', jsonEncode(user));
    }
    notifyListeners();
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('Current_User_Key');
  }
}
