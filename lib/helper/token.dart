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

  Future<String?> readToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.getString('access_token');
    return data;
  }

  Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('access_token');
  }

  Future<void> saveUser(String email, String pass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', email);
    pref.setString('pass', pass);
  }

  Future<void> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("email");
    pref.getString("pass");
  }

  Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.getString('access_token');
    if (data != null) {
      // final accessToken = json.decode(data);
      return data;
    }
    return "";
  }
}
