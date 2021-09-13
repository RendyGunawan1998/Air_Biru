import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galon/controller/user_controller.dart';
import 'package:galon/helper/token.dart';
import 'package:galon/model/model_profile.dart';
import 'package:galon/pages/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController userController = UserController();
  bool loading = true;
  late Future<Profile> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = getInfo();
  }

  Future<Profile> getInfo() async {
    String url = 'https://gebyarairminumbiru.com/api/user/info';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer" + await Token().getAccessToken()
        //access token dlm bentuk bearer //disini udh ada auth untuk access
      },
    );
    //var toJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      Token().saveUserData(json.encode(res));
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      // throw Exception("Failed to load data");
      throw response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Profile>(
        future: futureProfile,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _buildBody(snapshot.data);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildBody(Profile data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildName(data),
          _buildBodyForm(data),
        ],
      ),
    );
  }

  Widget _buildName(Profile data) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 90,
          width: 90,
          child: Stack(
            // overflow: Overflow.visible,
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepOrange[300],
                child: Icon(Icons.person),
                radius: 30,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          data.name,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          data.noKtp,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBodyForm(Profile data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              _buildFormProfile(data),
              SizedBox(
                height: 65,
              ),
              _buildLogOut(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormProfile(Profile data) {
    return Card(
      elevation: 3,
      child: Column(
        children: <Widget>[
          // _buildPangkat(data),
          Divider(
            height: 1,
            color: Colors.black54,
            indent: 7,
            endIndent: 5,
          ),
          // _buildSatker(data),
          Divider(
            height: 1,
            color: Colors.black54,
            indent: 7,
            endIndent: 5,
          ),
          // _buildPhone(data),
        ],
      ),
    );
  }

  Widget _buildLogOut() {
    return Stack(
      children: [
        ListTile(
          onTap: () async {
            await Token().removeToken();
            Get.offAll(LoginAnimation());
          },
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          subtitle: Text(
            'Keluar dari Aplikasi',
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
          trailing: Icon(
            Icons.power_settings_new,
            color: Colors.red,
            size: 30,
          ),
        ),
      ],
    );
  }
}
