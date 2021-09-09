import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Token {
  Future<void> saveUserData(String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user_data', data);
  }

  Future<void> saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('access_token', token);
  }

  Future<String> readToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.getString('access_token');
    return data;
  }

  Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('access_token');
  }

  Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.getString('access_token');
    if (data != null) {
      final accessToken = json.decode(data);
      return accessToken['access_token'];
    }
    return null;
  }
}
