import 'dart:convert';

import 'package:galon/helper/token.dart';
import 'package:galon/model/banners.dart';
import 'package:galon/model/model_profile.dart';
import 'package:galon/model/notif.dart';
import 'package:galon/model/posts.dart';
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

  Future<String> loginGoogle(String email, String name) async {
    var _body = {'email': email, 'name': name};
    print("loginGoogle body: " + json.encode(_body));
    try {
      var response = await http.post(
        Uri.parse("https://gebyarairminumbiru.com/api/user/logingoogle"),
        body: json.encode(_body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      print("loginGoogle: ${response.body}");
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

  Future<String> franchiese(
      String name, String phone, String subjek, String pesan) async {
    // var _headers = {
    //   "Authorization": "Bearer" + await Token().getAccessToken(),
    // };
    // print("ini header franchiese : $_headers");

    var _body = {
      'name': name,
      'phone_number': phone,
      'subject': subjek,
      'message': pesan
    };
    print("fungsi upload franchiese " + json.encode(_body));
    print(_body);
    print("token: " + await token.getAccessToken());
    try {
      var response = await http.post(
        Uri.parse("https://gebyarairminumbiru.com/api/business/submission"),
        body: json.encode(_body),
        headers: {
          "Authorization": "Bearer " + await token.getAccessToken(),
          "Content-Type": "application/json"
        },
      );
      print(response.body);
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

  Future<List<Posts>> getPosts() async {
    try {
      var response = await http.get(
        Uri.parse("https://gebyarairminumbiru.com/api/posts"),
        // body: json.encode(_body),
        headers: {
          "Authorization": "Bearer " + await token.getAccessToken(),
          // "Content-Type": "application/json"
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        final dataDecode = json.decode(response.body);
        final data = dataDecode['posts'];
        // data = data['posts'];
        return data.map<Posts>((rawPost) {
          return Posts.fromJson(rawPost);
        }).toList();
      } else {
        throw ("error saat mengambil data");
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Banners>> getBanner() async {
    try {
      var response = await http.get(
        Uri.parse("https://gebyarairminumbiru.com/api/banners"),
        // body: json.encode(_body),
        headers: {
          "Authorization": "Bearer " + await token.getAccessToken(),
          // "Content-Type": "application/json"
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final dataDecode = json.decode(response.body);
        final data = dataDecode['banners'];
        // data = data['posts'];
        return data.map<Banners>((rawPost) {
          return Banners.fromJson(rawPost);
        }).toList();
      } else {
        throw ("error saat mengambil data");
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Notif>> notif() async {
    try {
      var response = await http.get(
        Uri.parse("https://gebyarairminumbiru.com/api/user/all/notifications"),
        headers: {
          "Authorization": "Bearer " + await token.getAccessToken(),
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final dataDecode = json.decode(response.body);
        final data = dataDecode['notifications'];
        return data.map<Notif>((rawNotif) {
          return Notif.fromJson(rawNotif);
        }).toList();
      } else {
        throw ("error saat mengambil data");
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Profile> profil() async {
    try {
      var response = await http.get(
        Uri.parse("https://gebyarairminumbiru.com/api/user/info"),
        headers: {
          "Authorization": "Bearer " + await token.getAccessToken(),
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return Profile.fromJson(jsonDecode(response.body));
      } else {
        throw ("error saat mengambil data");
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<String> updateProfile(
      String nama, String telp, String email, String alamat, String ktp) async {
    var _url = "https://gebyarairminumbiru.com/api/user/info";

    var _body = {
      'name': nama,
      'phone': telp,
      'email': email,
      'address': alamat,
      'no_ktp': ktp
    };
    print("ini url di update profile $_url");
    print("ini body update profile " + json.encode(_body));
    try {
      var response = await http.put(
        Uri.parse(_url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer " + await token.getAccessToken(),
        },
        body: json.encode(_body),
        // encoding:
      );
      // print(body);
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var res = json.decode(response.body);
        print(res);
        return res['message'];
      } else {
        throw ("Gagal Update Profile");
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<String> updatePassword(String old, String pass, String re) async {
    var _url = "https://gebyarairminumbiru.com/api/user/ubah-password";

    var _body = {'oldpswd': old, 'newpswd': pass, 'repswd': re};
    print("ini url di update password $_url");
    print("ini body update password " + json.encode(_body));
    try {
      var response = await http.post(
        Uri.parse(_url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer " + await token.getAccessToken(),
        },
        body: json.encode(_body),
        // encoding:
      );
      // print(body);
      print(response.body);
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(response.body);
        // print(res);
        return res['message'];
      } else {
        return res['error'];
      }
    } catch (e) {
      throw ('terjadi kesalahan saat update password');
    }
  }

  Future<String> cariUserByEmailPhone(String email, String phone) async {
    var _url = "https://gebyarairminumbiru.com/api/user/cari-by-email-phone";

    var _body = {'email': email, 'phone': phone};
    print("ini url di cariUserByEmailPhone $_url");
    print("ini body cariUserByEmailPhone " + json.encode(_body));
    try {
      var response = await http.post(
        Uri.parse(_url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          // "Authorization": "Bearer " + await token.getAccessToken(),
        },
        body: json.encode(_body),
        // encoding:
      );
      // print(body);
      print(response.body);
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(response.body);
        // print(res);
        return res['message'];
      } else {
        return res['error'];
      }
    } catch (e) {
      throw ('terjadi kesalahan saat cariUserByEmailPhone');
    }
  }

  Future<String> ubahPasswordByEmailPhone(
      String email, String phone, String pass, String re) async {
    var _url =
        "https://gebyarairminumbiru.com/api/user/ubah-password-by-email-phone";

    var _body = {'email': email, 'phone': phone, 'newpswd': pass, 'repswd': re};
    print("ini url di ubahPasswordByEmailPhone $_url");
    print("ini body ubahPasswordByEmailPhone " + json.encode(_body));
    try {
      var response = await http.post(
        Uri.parse(_url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          // "Authorization": "Bearer " + await token.getAccessToken(),
        },
        body: json.encode(_body),
        // encoding:
      );
      // print(body);
      print(response.body);
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(response.body);
        // print(res);
        return res['message'];
      } else {
        return res['error'];
      }
    } catch (e) {
      throw ('terjadi kesalahan saat ubahPasswordByEmailPhone');
    }
  }

  Future<String> updateFCMToken(String token) async {
    var _url = "https://gebyarairminumbiru.com/api/user/update/fcm_token";

    var _body = {'fcm_token': token};
    print("ini url di updateFCMToken $_url");
    print("ini body updateFCMToken " + json.encode(_body));
    try {
      var response = await http.put(
        Uri.parse(_url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          // "Authorization": "Bearer " + await token.getAccessToken(),
        },
        body: json.encode(_body),
        // encoding:
      );
      // print(body);
      print(response.body);
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(response.body);
        // print(res);
        return res['message'];
      } else {
        return res['error'];
      }
    } catch (e) {
      throw ('terjadi kesalahan saat updateFCMToken');
    }
  }
}
