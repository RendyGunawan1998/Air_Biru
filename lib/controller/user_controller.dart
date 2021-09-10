import 'dart:convert';

import 'package:galon/helper/token.dart';
import 'package:http/http.dart' as http;

class UserController {
  Token token = Token();

  Future getInfo() async {
    String url = 'https://gebyarairminumbiru.com/api/user/info';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer" + await token.getAccessToken()
        //access token dlm bentuk bearer //disini udh ada auth untuk access
      },
    );
    //var toJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      Token().saveUserData(json.encode(res));
      return response.body;
    } else {
      // throw Exception("Failed to load data");
      throw response;
    }
  }

  Future<String> login(String email, String password) async {
    var _body = {'email': email, 'password': password};
    print("email " + json.encode(_body));
    try {
      var response = await http.post(
        Uri.parse("https://gebyarairminumbiru.com/api/user/login"),
        body: json.encode(_body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      print("login: ${response.body}");
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        token.saveToken(res['token']);
        return res['message'];
      } else {
        return res['error'];
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<String> regis(String name, String phone, String email, String address,
      String ktp, String password) async {
    var _body = {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'no_ktp': ktp,
      'password': password
    };
    // print("email " + json.encode(_body));
    print(_body);
    try {
      var response = await http.post(
        Uri.parse("https://gebyarairminumbiru.com/api/user/register"),
        body: json.encode(_body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      print("regis: ${response.body}");
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        return res['message'];
      } else {
        return res['error'];
      }
    } catch (e) {
      throw (e);
    }
  }
}
